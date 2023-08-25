//
//  PlatformRequester.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2023/08/17.
//

import Foundation
import AVFoundation
import Flutter

extension FlutterError: Error {}

enum AmazonChimeError: Error {
    case invalidResponse
    case customError(text: String)

    var errorType: AmazonChimeErrorType {
        switch self {
        case .invalidResponse:
            return .invalidResponse
        case .customError:
            return .customError
        }
    }

    var asFlutterError: FlutterError {
        let code = String(errorType.rawValue)
        switch self {
        case .invalidResponse:
            return FlutterError(code: code, message: nil, details: nil)
        case .customError(let text):
            return FlutterError(code: code, message: text, details: nil)
        }
    }
}

final class RequesterToNativeImpl: RequesterToNative {
    func sendMessage(type: MethodType, completion: @escaping (Result<StringData, Error>) -> Void) {
        Task {
            let result = await sendMessage(type: type)
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure.asFlutterError))
            }
        }
    }
}

private extension RequesterToNativeImpl {
    func sendMessage(type: MethodType) async -> Result<StringData, AmazonChimeError> {
        switch type {
        // エラーの場合は、`return .failure(AmazonChimeError.invalidResponse)`のように記載
        case .getPlatformVersion:
            return .success(StringData(result: true, data: "iOS \(await UIDevice.current.systemVersion)"))
        case .requestMicrophonePermissions:
            let result = await requestMicrophonePermission().asStringData
            return .success(result)
        case .requestCameraPermissions:
            let result = await requestCameraPermission().asStringData
            return .success(result)
        }
    }
}

private extension RequesterToNativeImpl {
    func requestMicrophonePermission() async -> ResponseMessageData {
        func requestMicrophonePermission() async -> Bool {
            return await withCheckedContinuation { continuation in
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    continuation.resume(returning: granted)
                }
            }
        }

        let microphonePermission = AVAudioSession.sharedInstance().recordPermission
        switch microphonePermission {
        case .undetermined:
            if await requestMicrophonePermission() {
                return ResponseMessageData(result: true, type: .microphoneAuthorized)
            } else {
                return ResponseMessageData(result: false, type: .microphoneAuthNotGranted)
            }
        case .granted:
            return ResponseMessageData(result: true, type: .microphoneAuthorized)
        case .denied:
            return ResponseMessageData(result: false, type: .microphoneAuthNotGranted)
        @unknown default:
            return ResponseMessageData(result: false, type: .unknownMicrophoneAuthorizationStatus)
        }
    }

    func requestCameraPermission() async -> ResponseMessageData {
        func requestCameraPermission() async -> Bool {
            return await withCheckedContinuation { continuation in
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    continuation.resume(returning: granted)
                }
            }
        }

        let cameraPermission = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraPermission {
        case .notDetermined:
            if await requestCameraPermission() {
                return ResponseMessageData(result: true, type: .cameraAuthorized)
            } else {
                return ResponseMessageData(result: false, type: .cameraAuthNotGranted)
            }
        case .authorized:
            return ResponseMessageData(result: true, type: .cameraAuthorized)
        case .denied, .restricted:
            return ResponseMessageData(result: false, type: .cameraAuthNotGranted)
        @unknown default:
            return ResponseMessageData(result: false, type: .unknownCameraAuthorizationStatus)
        }
    }
}
