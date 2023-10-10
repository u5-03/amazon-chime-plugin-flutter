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
  case initialAudioSelection = 3
  case listAudioDevices = 4
  case updateAudioDevice = 5
  case localVideoOn = 6
  case localVideoOff = 7
  case join = 8
  case mute = 9
  case unmute = 10
  case stop = 11
  case videoTileAdd = 12
  case videoTileRemove = 13
  case audioSessionDidDrop = 14
  case audioSessionDidStop = 15
}

enum AmazonChimeErrorType: Int {
  case unknown = 0
  case invalidResponse = 1
  case responseMessage = 2
  case customError = 3
}

/// Generated class from Pigeon that represents data sent in messages.
struct JoinParameter {
  var meetingId: String
  var externalMeetingId: String
  var mediaRegion: String
  var audioHostUrl: String
  var audioFallbackUrl: String
  var signalingUrl: String
  var turnControlUrl: String
  var externalUserId: String
  var attendeeId: String
  var joinToken: String

  static func fromList(_ list: [Any?]) -> JoinParameter? {
    let meetingId = list[0] as! String
    let externalMeetingId = list[1] as! String
    let mediaRegion = list[2] as! String
    let audioHostUrl = list[3] as! String
    let audioFallbackUrl = list[4] as! String
    let signalingUrl = list[5] as! String
    let turnControlUrl = list[6] as! String
    let externalUserId = list[7] as! String
    let attendeeId = list[8] as! String
    let joinToken = list[9] as! String

    return JoinParameter(
      meetingId: meetingId,
      externalMeetingId: externalMeetingId,
      mediaRegion: mediaRegion,
      audioHostUrl: audioHostUrl,
      audioFallbackUrl: audioFallbackUrl,
      signalingUrl: signalingUrl,
      turnControlUrl: turnControlUrl,
      externalUserId: externalUserId,
      attendeeId: attendeeId,
      joinToken: joinToken
    )
  }
  func toList() -> [Any?] {
    return [
      meetingId,
      externalMeetingId,
      mediaRegion,
      audioHostUrl,
      audioFallbackUrl,
      signalingUrl,
      turnControlUrl,
      externalUserId,
      attendeeId,
      joinToken,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct ParticipantInfo {
  var attendeeId: String
  var externalUserId: String

  static func fromList(_ list: [Any?]) -> ParticipantInfo? {
    let attendeeId = list[0] as! String
    let externalUserId = list[1] as! String

    return ParticipantInfo(
      attendeeId: attendeeId,
      externalUserId: externalUserId
    )
  }
  func toList() -> [Any?] {
    return [
      attendeeId,
      externalUserId,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct TileInfo {
  var tileId: Int64
  var attendeeId: String
  var videoStreamContentWidth: Double
  var videoStreamContentHeight: Double
  var isLocalTile: Bool
  var isContent: Bool

  static func fromList(_ list: [Any?]) -> TileInfo? {
    let tileId = list[0] is Int64 ? list[0] as! Int64 : Int64(list[0] as! Int32)
    let attendeeId = list[1] as! String
    let videoStreamContentWidth = list[2] as! Double
    let videoStreamContentHeight = list[3] as! Double
    let isLocalTile = list[4] as! Bool
    let isContent = list[5] as! Bool

    return TileInfo(
      tileId: tileId,
      attendeeId: attendeeId,
      videoStreamContentWidth: videoStreamContentWidth,
      videoStreamContentHeight: videoStreamContentHeight,
      isLocalTile: isLocalTile,
      isContent: isContent
    )
  }
  func toList() -> [Any?] {
    return [
      tileId,
      attendeeId,
      videoStreamContentWidth,
      videoStreamContentHeight,
      isLocalTile,
      isContent,
    ]
  }
}

private class RequesterToNativeCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return JoinParameter.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class RequesterToNativeCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? JoinParameter {
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
  func getPlatformVersion(completion: @escaping (Result<String, Error>) -> Void)
  func requestMicrophonePermissions(completion: @escaping (Result<String, Error>) -> Void)
  func requestCameraPermissions(completion: @escaping (Result<String, Error>) -> Void)
  func initialAudioSelection(completion: @escaping (Result<String, Error>) -> Void)
  func listAudioDevices(completion: @escaping (Result<[String], Error>) -> Void)
  func updateCurrentDevice(deviceLabel: String, completion: @escaping (Result<String, Error>) -> Void)
  func startLocalVideo(completion: @escaping (Result<Void, Error>) -> Void)
  func stopLocalVideo(completion: @escaping (Result<Void, Error>) -> Void)
  func join(parameter: JoinParameter, completion: @escaping (Result<Void, Error>) -> Void)
  func stop(completion: @escaping (Result<Void, Error>) -> Void)
  func mute(completion: @escaping (Result<Void, Error>) -> Void)
  func unmute(completion: @escaping (Result<Void, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class RequesterToNativeSetup {
  /// The codec used by RequesterToNative.
  static var codec: FlutterStandardMessageCodec { RequesterToNativeCodec.shared }
  /// Sets up an instance of `RequesterToNative` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: RequesterToNative?) {
    let getPlatformVersionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.getPlatformVersion", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getPlatformVersionChannel.setMessageHandler { _, reply in
        api.getPlatformVersion() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      getPlatformVersionChannel.setMessageHandler(nil)
    }
    let requestMicrophonePermissionsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.requestMicrophonePermissions", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      requestMicrophonePermissionsChannel.setMessageHandler { _, reply in
        api.requestMicrophonePermissions() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      requestMicrophonePermissionsChannel.setMessageHandler(nil)
    }
    let requestCameraPermissionsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.requestCameraPermissions", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      requestCameraPermissionsChannel.setMessageHandler { _, reply in
        api.requestCameraPermissions() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      requestCameraPermissionsChannel.setMessageHandler(nil)
    }
    let initialAudioSelectionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.initialAudioSelection", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      initialAudioSelectionChannel.setMessageHandler { _, reply in
        api.initialAudioSelection() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      initialAudioSelectionChannel.setMessageHandler(nil)
    }
    let listAudioDevicesChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.listAudioDevices", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      listAudioDevicesChannel.setMessageHandler { _, reply in
        api.listAudioDevices() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      listAudioDevicesChannel.setMessageHandler(nil)
    }
    let updateCurrentDeviceChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.updateCurrentDevice", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      updateCurrentDeviceChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let deviceLabelArg = args[0] as! String
        api.updateCurrentDevice(deviceLabel: deviceLabelArg) { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      updateCurrentDeviceChannel.setMessageHandler(nil)
    }
    let startLocalVideoChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.startLocalVideo", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startLocalVideoChannel.setMessageHandler { _, reply in
        api.startLocalVideo() { result in
          switch result {
            case .success:
              reply(wrapResult(nil))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      startLocalVideoChannel.setMessageHandler(nil)
    }
    let stopLocalVideoChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.stopLocalVideo", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      stopLocalVideoChannel.setMessageHandler { _, reply in
        api.stopLocalVideo() { result in
          switch result {
            case .success:
              reply(wrapResult(nil))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      stopLocalVideoChannel.setMessageHandler(nil)
    }
    let joinChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.join", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      joinChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let parameterArg = args[0] as! JoinParameter
        api.join(parameter: parameterArg) { result in
          switch result {
            case .success:
              reply(wrapResult(nil))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      joinChannel.setMessageHandler(nil)
    }
    let stopChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.stop", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      stopChannel.setMessageHandler { _, reply in
        api.stop() { result in
          switch result {
            case .success:
              reply(wrapResult(nil))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      stopChannel.setMessageHandler(nil)
    }
    let muteChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.mute", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      muteChannel.setMessageHandler { _, reply in
        api.mute() { result in
          switch result {
            case .success:
              reply(wrapResult(nil))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      muteChannel.setMessageHandler(nil)
    }
    let unmuteChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.unmute", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      unmuteChannel.setMessageHandler { _, reply in
        api.unmute() { result in
          switch result {
            case .success:
              reply(wrapResult(nil))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      unmuteChannel.setMessageHandler(nil)
    }
  }
}
private class RequesterToFlutterCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return ParticipantInfo.fromList(self.readValue() as! [Any?])
      case 129:
        return TileInfo.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class RequesterToFlutterCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? ParticipantInfo {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? TileInfo {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class RequesterToFlutterCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return RequesterToFlutterCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return RequesterToFlutterCodecWriter(data: data)
  }
}

class RequesterToFlutterCodec: FlutterStandardMessageCodec {
  static let shared = RequesterToFlutterCodec(readerWriter: RequesterToFlutterCodecReaderWriter())
}

/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class RequesterToFlutter {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
  var codec: FlutterStandardMessageCodec {
    return RequesterToFlutterCodec.shared
  }
  func audioSessionDidDrop(completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.audioSessionDidDrop", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage(nil) { _ in
      completion()
    }
  }
  func audioSessionDidStop(completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.audioSessionDidStop", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage(nil) { _ in
      completion()
    }
  }
  func joined(info infoArg: ParticipantInfo, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.joined", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([infoArg] as [Any?]) { _ in
      completion()
    }
  }
  func left(info infoArg: ParticipantInfo, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.left", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([infoArg] as [Any?]) { _ in
      completion()
    }
  }
  func dropped(info infoArg: ParticipantInfo, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.dropped", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([infoArg] as [Any?]) { _ in
      completion()
    }
  }
  func muted(info infoArg: ParticipantInfo, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.muted", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([infoArg] as [Any?]) { _ in
      completion()
    }
  }
  func unmuted(info infoArg: ParticipantInfo, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.unmuted", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([infoArg] as [Any?]) { _ in
      completion()
    }
  }
  func videoTileAdded(info infoArg: TileInfo, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileAdded", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([infoArg] as [Any?]) { _ in
      completion()
    }
  }
  func videoTileRemoved(info infoArg: TileInfo, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileRemoved", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([infoArg] as [Any?]) { _ in
      completion()
    }
  }
}
