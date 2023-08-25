// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum MethodType: Int {
  case getPlatformVersion = 0
  case requestMicrophonePermissions = 1
  case requestCameraPermissions = 2
}

enum AmazonChimeErrorType: Int {
  case unknown = 0
  case invalidResponse = 1
  case customError = 2
}

/// Generated class from Pigeon that represents data sent in messages.
struct StringData {
  var result: Bool
  var data: String

  static func fromList(_ list: [Any?]) -> StringData? {
    let result = list[0] as! Bool
    let data = list[1] as! String

    return StringData(
      result: result,
      data: data
    )
  }
  func toList() -> [Any?] {
    return [
      result,
      data,
    ]
  }
}

private class RequesterToNativeCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return StringData.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class RequesterToNativeCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? StringData {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class RequesterToNativeCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return RequesterToNativeCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return RequesterToNativeCodecWriter(data: data)
  }
}

class RequesterToNativeCodec: FlutterStandardMessageCodec {
  static let shared = RequesterToNativeCodec(readerWriter: RequesterToNativeCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol RequesterToNative {
  func sendMessage(type: MethodType, completion: @escaping (Result<StringData, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class RequesterToNativeSetup {
  /// The codec used by RequesterToNative.
  static var codec: FlutterStandardMessageCodec { RequesterToNativeCodec.shared }
  /// Sets up an instance of `RequesterToNative` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: RequesterToNative?) {
    let sendMessageChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.sendMessage", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      sendMessageChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let typeArg = MethodType(rawValue: args[0] as! Int)!
        api.sendMessage(type: typeArg) { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      sendMessageChannel.setMessageHandler(nil)
    }
  }
}
/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class RequesterToFlutter {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
}
