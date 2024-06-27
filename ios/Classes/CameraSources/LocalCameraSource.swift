//
//  LocalCameraSource.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2024/06/06.
//

import Foundation
import AmazonChimeSDK
import Combine
import CoreMedia

// Ref: https://github.com/aws/amazon-chime-sdk-ios/blob/master/guides/custom_video.md#implementing-a-custom-video-source-and-transmitting
final class LocalCameraSource: VideoSource {
    private let localCameraController: LocalCameraController
    private let sinks = NSMutableSet()
    private let context = CIContext()
    private var cancellableSet = Set<AnyCancellable>()
    var videoContentHint: AmazonChimeSDK.VideoContentHint = .none

    init(localCameraController: LocalCameraController) {
        self.localCameraController = localCameraController

        localCameraController.cmSampleBufferPublisher
            .sink { [weak self] buffer in
                self?.processBuffer(cmSampleBuffer: buffer)
            }
            .store(in: &cancellableSet)
    }

    func addVideoSink(sink: VideoSink) {
        sinks.add(sink)
    }

    func removeVideoSink(sink: VideoSink) {
        sinks.remove(sink)
    }
}

private extension LocalCameraSource {
    func processBuffer(cmSampleBuffer: CMSampleBuffer) {
        guard let cvPixelBuffer = CMSampleBufferGetImageBuffer(cmSampleBuffer) else { return }
        let timestamp = CMSampleBufferGetPresentationTimeStamp(cmSampleBuffer)
        let processedFrame = VideoFrame(timestampNs: cmTimeToNanoSeconds(timestamp),
                                        rotation: .rotation0,
                                        buffer: VideoFramePixelBuffer(pixelBuffer: cvPixelBuffer))

        for sink in sinks {
            (sink as? VideoSink)?.onVideoFrameReceived(frame: processedFrame)
        }
    }

    func cmTimeToNanoSeconds(_ time: CMTime) -> Int64 {
        let seconds = Double(time.value) / Double(time.timescale)
        let nanoseconds = seconds * 1_000_000_000.0
        return Int64(nanoseconds)
    }
}
