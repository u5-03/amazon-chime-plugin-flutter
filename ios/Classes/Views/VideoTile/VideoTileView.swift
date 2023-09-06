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

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) {
        super.init()

        // Receieve tileId as a param.
        guard let tileId = args as? Int else {
            fatalError("`args` paramter must be `Int`!")
        }

        // Bind view to VideoView
        MeetingSession.shared.meetingSession?.audioVideo.bindVideoView(videoView: videoRenderView, tileId: tileId)

        // Fix aspect ratio
        (videoRenderView as? UIView)?.contentMode = .scaleAspectFit

        // Declare _view as UIView for Flutter interpretation
//        videoRenderView = videoRenderView as UIView
    }

    func view() -> UIView {
        return videoRenderView as! UIView
    }
}
