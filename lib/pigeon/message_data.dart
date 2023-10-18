// ignore_for_file: one_member_abstracts

// ignore: depend_on_referenced_packages
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/generated/message_data.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/example/amazon_chime_plugin/Generated/MessageData.g.kt',
    kotlinOptions: KotlinOptions(),
    swiftOut: 'ios/Classes/Generated/MessageData.g.swift',
    swiftOptions: SwiftOptions(),
    copyrightHeader: 'lib/pigeon/generated/copyright.txt',
    dartPackageName: 'amazon_chime_plugin',
  ),
)
enum MethodType {
  getPlatformVersion,
  requestMicrophonePermissions,
  requestCameraPermissions,
  initialAudioSelection,
  listAudioDevices,
  updateAudioDevice,
  localVideoOn,
  localVideoOff,
  join,
  mute,
  unmute,
  stop,
  videoTileAdd,
  videoTileRemove,
  audioSessionDidDrop,
  audioSessionDidStop,
}

class StringData {
  StringData({required this.result, required this.data});
  bool result;
  String data;
}

class JoinParameter {
  JoinParameter({
    required this.meetingId,
    required this.externalMeetingId,
    required this.mediaRegion,
    required this.audioHostUrl,
    required this.audioFallbackUrl,
    required this.signalingUrl,
    required this.turnControlUrl,
    required this.externalUserId,
    required this.attendeeId,
    required this.joinToken,
  });

  final String meetingId;
  final String externalMeetingId;
  final String mediaRegion;
  final String audioHostUrl;
  final String audioFallbackUrl;
  final String signalingUrl;
  final String turnControlUrl;
  final String externalUserId;
  final String attendeeId;
  final String joinToken;
}

class ParticipantInfo {
  ParticipantInfo({
    required this.externalUserId,
    required this.attendeeId,
  });

  final String attendeeId;
  final String externalUserId;
}

class TileInfo {
  TileInfo({
    required this.tileId,
    required this.attendeeId,
    required this.videoStreamContentWidth,
    required this.videoStreamContentHeight,
    required this.isLocalTile,
    required this.isContent,
  });

  final int tileId;
  final String attendeeId;
  final double videoStreamContentWidth;
  final double videoStreamContentHeight;
  final bool isLocalTile;
  final bool isContent;
}

enum AmazonChimeErrorType {
  unknown,
  invalidResponse,
  responseMessage,
  customError,
}

@HostApi() // Flutter -> Native
abstract class RequesterToNative {
  @async
  String getPlatformVersion();
  @async
  String initialAudioSelection();
  @async
  List<String> listAudioDevices();
  @async
  String updateCurrentDevice(String deviceLabel);
  @async
  void startLocalVideo();
  @async
  void stopLocalVideo();
  @async
  void join(JoinParameter parameter);
  @async
  void stop();
  @async
  void mute();
  @async
  void unmute();
}

@FlutterApi() // Native -> Flutter
abstract class RequesterToFlutter {
  void audioSessionDidDrop();
  void audioSessionDidStop();
  void joined(ParticipantInfo info);
  void left(ParticipantInfo info);
  void dropped(ParticipantInfo info);
  void muted(ParticipantInfo info);
  void unmuted(ParticipantInfo info);
  void videoTileAdded(TileInfo info);
  void videoTileRemoved(TileInfo info);
}
