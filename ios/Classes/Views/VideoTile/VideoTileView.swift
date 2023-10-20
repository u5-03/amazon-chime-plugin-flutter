//
//  VideoTileView.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2023/08/29.
//

import AmazonChimeSDK
import AmazonChimeSDKMedia
import Foundation
import Flutter

final class VideoTileView: NSObject, FlutterPlatformView {
    private let videoRenderView: VideoRenderView = DefaultVideoRenderView()
    private let logger = ConsoleLogger(name: "MeetingSession")
    private let tileId: Int

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) {

        // Receieve tileId as a param.
        guard let params = args as? Dictionary<String, Any>,
              let tileId = params["tileId"] as? Int,
              let isMirror = params["isMirror"] as? Bool,
              let isScaleToFill = params["isScaleToFill"] as? Bool else {
            fatalError("`args` paramter must be `Int`!")
        }
        self.tileId = tileId
        super.init()

        // Memo: without delay, tileView won't present when re-display tileView
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Bind view to VideoView
            MeetingSession.shared.meetingSession?.audioVideo.bindVideoView(videoView: self.videoRenderView, tileId: tileId)
            // この辺りの設定をViewの宣言時に設定すると、なぜかUIが崩れるのでここに記載
            // Fix aspect ratio
            (self.videoRenderView as? UIView)?.contentMode = isScaleToFill ? .scaleToFill : .scaleAspectFit
            (self.videoRenderView as? DefaultVideoRenderView)?.mirror = isMirror

        }
        // Declare _view as UIView for Flutter interpretation
        //        videoRenderView = videoRenderView as UIView
    }

    deinit {
        // deinit when this view will removed from flutter widgets.
        MeetingSession.shared.meetingSession?.audioVideo.unbindVideoView(tileId: tileId)
    }

    func view() -> UIView {
        return videoRenderView as! UIView
    }
}
