//
//  VideoTileFactory.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2023/08/29.
//

import Foundation
import Flutter

final class FlutterVideoTileFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return VideoTileView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args
        )
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
