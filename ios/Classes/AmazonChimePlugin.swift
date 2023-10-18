import Flutter
import UIKit
import AmazonChimeSDK

// After modified, must modify android/dart definition too.
enum PlatformViewKind: String {
    case videoTile
}

public class AmazonChimePlugin: NSObject, FlutterPlugin {
    static var requester: RequesterToFlutter?

    public static func register(with registrar: FlutterPluginRegistrar) {
        RequesterToNativeSetup.setUp(binaryMessenger: registrar.messenger(), api: RequesterToNativeImpl())
        registrar.register(
            FlutterVideoTileFactory(messenger: registrar.messenger()),
            withId: PlatformViewKind.videoTile.rawValue
        )
        let requester = RequesterToFlutter(binaryMessenger: registrar.messenger())
        self.requester = requester
    }
}
