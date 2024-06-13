import Flutter
import UIKit
import AmazonChimeSDK

// After modified, must modify android/dart definition too.
enum PlatformViewKind: String {
    case videoTile
}

public class AmazonChimePlugin: NSObject, FlutterPlugin {
    static var requester: RequesterToFlutter?
    static var videoTileTextureControllers: [Int64: VideoTileTextureController] = [:]

    public static func register(with registrar: FlutterPluginRegistrar) {
        RequesterToNativeSetup.setUp(binaryMessenger: registrar.messenger(), api: RequesterToNativeImpl(textureRegistry: registrar.textures()))
        registrar.register(
            FlutterVideoTileFactory(registrar: registrar),
            withId: PlatformViewKind.videoTile.rawValue
        )
        let requester = RequesterToFlutter(binaryMessenger: registrar.messenger())
        self.requester = requester
    }
}
