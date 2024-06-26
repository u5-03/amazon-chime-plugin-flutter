//
//  LocalCameraController.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2024/06/06.
//

import Foundation
import AVFoundation
import Combine

final class LocalCameraController: NSObject {
    private let captureSession: AVCaptureSession
    private let videoQueue = DispatchQueue(label: "videoQueue")
    private let cmSampleBufferSubject = PassthroughSubject<CMSampleBuffer, Never>()
    private let initialCameraPosition: AVCaptureDevice.Position = .front
    private let videoOutput = AVCaptureVideoDataOutput()
    var cmSampleBufferPublisher: AnyPublisher<CMSampleBuffer, Never> {
        return cmSampleBufferSubject.eraseToAnyPublisher()
    }
    var currentInput: AVCaptureDeviceInput? {
        return captureSession.inputs.first as? AVCaptureDeviceInput
    }
    var isFrontCamera: Bool {
        guard let currentInput = currentInput else { return initialCameraPosition == .front }
        return currentInput.device.position == .front
    }

    override init() {
        captureSession = AVCaptureSession()
        super.init()
        setUp()
    }

    func dispose() {
        captureSession.stopRunning()
        for input in captureSession.inputs {
            captureSession.removeInput(input)
        }
        for output in captureSession.outputs {
            captureSession.removeOutput(output)
        }
    }

    func startRunning() {
        if !captureSession.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }

    func stopRunning() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }

    func switchCamera() {
        guard let currentInput = currentInput else { return }
        let isFrontCamera = isFrontCamera
        captureSession.beginConfiguration()
        captureSession.removeInput(currentInput)

        guard let newCameraDevice = isFrontCamera ? getCamera(with: .back) : getCamera(with: .front),
              let newVideoInput = try? AVCaptureDeviceInput(device: newCameraDevice),
               captureSession.canAddInput(newVideoInput) else {
            captureSession.commitConfiguration()
            return
        }
        captureSession.addInput(newVideoInput)
        setVideoRotationState()
        captureSession.commitConfiguration()
    }

    private func setUp() {
        captureSession.beginConfiguration()

        guard let videoDevice = getCamera(with: initialCameraPosition), captureSession.canAddOutput(videoOutput) else { return }

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)

            captureSession.addInput(videoInput)
            captureSession.addOutput(videoOutput)
            setVideoRotationState()
            videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
            captureSession.commitConfiguration()
        } catch {
            print("Error setting device video input: \(error)")
        }
    }

    private func setVideoRotationState() {
        if #available(iOS 17.0, *) {
            videoOutput.connection(with: .video)?.videoRotationAngle = 90
        } else {
            videoOutput.connection(with: .video)?.videoOrientation = .portrait
        }
    }

    private func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let deviceTypes: [AVCaptureDevice.DeviceType] = [
            .builtInWideAngleCamera,
            .builtInTelephotoCamera,
            .builtInDualCamera,
            .builtInTripleCamera,
            .builtInDualWideCamera,
            .builtInUltraWideCamera
        ]

        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: deviceTypes,
            mediaType: .video,
            position: position
        )

        return discoverySession.devices.first { $0.position == position }
    }
}

extension LocalCameraController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        cmSampleBufferSubject.send(sampleBuffer)
    }
}
