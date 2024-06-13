//
//  VideoTileTextureController.swift
//  abseil
//
//  Created by Yugo Sugiyama on 2024/05/31.
//

import Foundation
import Flutter
import AmazonChimeSDK

// Ref: https://qiita.com/mao_/items/aa219925270e7dfaee39
final class VideoTileTextureController: NSObject {

    private static let uninitializedTextureId: Int64 = -1

    private let tileId: Int
    private let textureRegistry: FlutterTextureRegistry
    private var _textureId: Int64 = uninitializedTextureId
    var textureId: Int64 {
        return _textureId
    }
    private var videoFrame: VideoFrame?

    init(tileId: Int, registrar: FlutterTextureRegistry) {
        self.tileId = tileId
        textureRegistry = registrar

        super.init()
        _textureId = textureRegistry.register(self)
        MeetingSession.shared.meetingSession?.audioVideo.bindVideoView(videoView: self, tileId: tileId)
    }

    func dispose() {
        textureRegistry.unregisterTexture(_textureId)
    }
}

extension VideoTileTextureController: FlutterTexture {
    // This is fired when `textureRegistry.textureFrameAvailable` is called.
    // → The returned CVPixelBuffer is actually displayed on the TextureWidget.
    func copyPixelBuffer() -> Unmanaged<CVPixelBuffer>? {
        guard let videoFramePixelBuffer = videoFrame?.buffer as? VideoFramePixelBuffer else { return nil }
        let cvPixelBuffer = videoFramePixelBuffer.pixelBuffer
        return Unmanaged.passRetained(cvPixelBuffer)
    }
}

extension VideoTileTextureController: VideoSink, VideoRenderView {
    func onVideoFrameReceived(frame: VideoFrame) {
        videoFrame = frame
        textureRegistry.textureFrameAvailable(_textureId)
    }
}
