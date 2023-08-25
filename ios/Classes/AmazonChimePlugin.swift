import Flutter
import UIKit
import AmazonChimeSDK

public class AmazonChimePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        RequesterToNativeSetup.setUp(binaryMessenger: registrar.messenger(), api: RequesterToNativeImpl())
    }
}
