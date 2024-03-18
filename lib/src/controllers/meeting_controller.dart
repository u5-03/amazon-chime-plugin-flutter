import 'package:amazon_chime_plugin/src/controllers/meeting_notifier.dart';
import 'package:amazon_chime_plugin/src/data/api_client.dart';
import 'package:amazon_chime_plugin/src/data/api_config.dart';
import 'package:amazon_chime_plugin/src/interfaces/audio_devices_interface.dart';
import 'package:amazon_chime_plugin/src/models/join_info_model.dart';
import 'package:amazon_chime_plugin/src/native/native_interface.dart';

final class MeetingController implements AudioDevicesInterface {
  MeetingController({
    NativeInterface? native,
  })  : native = native ?? NativeInterface.defaultInstance,
        notifier = MeetingNotifier(
          native: NativeInterface.defaultInstance,
        );

  final NativeInterface native;
  final MeetingNotifier notifier;

  void setAudioSessionDidStop(void Function() audioSessionDidStop) {
    notifier.callbacks.audioSessionDidStop = audioSessionDidStop;
  }

  void setAudioSessionDidDrop(void Function() audioSessionDidDrop) {
    notifier.callbacks.audioSessionDidDrop = audioSessionDidDrop;
  }

  void setConnectionDidRecover(void Function() connectionDidRecover) {
    notifier.callbacks.connectionDidRecover = connectionDidRecover;
  }

  void setConnectionDidBecomePoor(void Function() connectionDidBecomePoor) {
    notifier.callbacks.connectionDidBecomePoor = connectionDidBecomePoor;
  }

  void setAudioSessionDidCancelReconnect(
    void Function() audioSessionDidCancelReconnect,
  ) {
    notifier.callbacks.audioSessionDidCancelReconnect =
        audioSessionDidCancelReconnect;
  }

  void setVideoSessionDidStartConnecting(
    void Function() videoSessionDidStartConnecting,
  ) {
    notifier.callbacks.videoSessionDidStartConnecting =
        videoSessionDidStartConnecting;
  }

  void setAudioSessionDidStartConnecting(
    void Function(bool) audioSessionDidStartConnecting,
  ) {
    notifier.callbacks.audioSessionDidStartConnecting =
        audioSessionDidStartConnecting;
  }

  void setAudioSessionDidStart(
    void Function(bool) audioSessionDidStart,
  ) {
    notifier.callbacks.audioSessionDidStart = audioSessionDidStart;
  }

  void setCameraSendAvailabilityDidChange(
    void Function(bool) cameraSendAvailabilityDidChange,
  ) {
    notifier.callbacks.cameraSendAvailabilityDidChange =
        cameraSendAvailabilityDidChange;
  }

  void setRemoteVideoSourcesDidBecomeAvailable(
    void Function(List<String>) remoteVideoSourcesDidBecomeAvailable,
  ) {
    notifier.callbacks.remoteVideoSourcesDidBecomeAvailable =
        remoteVideoSourcesDidBecomeAvailable;
  }

  void setRemoteVideoSourcesDidBecomeUnavailable(
    void Function(List<String>) remoteVideoSourcesDidBecomeUnavailable,
  ) {
    notifier.callbacks.remoteVideoSourcesDidBecomeUnavailable =
        remoteVideoSourcesDidBecomeUnavailable;
  }

  Future<String> getPlatformVersion() {
    return native.getPlatformVersion();
  }

  /// join amazon chime meeting
  ///
  /// To enter chime meeting, call this method with [info].
  /// Before calling this method, camera and microphone permissions must be granted.
  ///
  ///
  /// [info] - parameter to join aws chime meeting。
  /// return void when succeeded, throw error when failed.
  Future<void> joinMeeting(JoinInfoModel info) async {
    notifier.initializeMeetingData(info);
    try {
      await native.joinMeeting(info);
      notifier.initializeLocalAttendee();
      // Androidでたまにエラーになるので、いったんコメントアウト
      // await listAudioDevices();
      // await initialAudioSelection();
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> joinMeetingWithAPI(
    ApiConfig config,
    JoinInfoModel Function(Map<String, dynamic> map) parse,
  ) async {
    final result = await ApiClient.post(uri: config.requestUrl());
    return joinMeeting(parse(result));
  }

  Future<void> mute() {
    return notifier.switchMuteStatus(toBeMute: true);
  }

  Future<void> unmute() {
    return notifier.switchMuteStatus(toBeMute: false);
  }

  Future<void> startLocalVideo() {
    notifier.updateLocalVideoEnabled(isLocalVideoEnabled: true);
    return native.startLocalVideo();
  }

  Future<void> stopMeeting() {
    return native.stop();
  }

  Future<void> stopLocalVideo() {
    notifier.updateLocalVideoEnabled(isLocalVideoEnabled: false);
    return native.stopLocalVideo();
  }

  Future<void> startRemoteVideo() {
    return native.startRemoteVideo();
  }

  Future<void> stopRemoteVideo() {
    return native.stopRemoteVideo();
  }

  Future<void> switchLocalCamera() {
    return native.switchLocalCamera();
  }

  /// AudioDevicesInterface methods
  @override
  Future<String> initialAudioSelection() {
    return native.initialAudioSelection();
  }

  @override
  Future<List<String?>> listAudioDevices() {
    return native.listAudioDevices();
  }

  @override
  Future<void> updateCurrentAudioDevice(String device) {
    // TODO: implement updateCurrentAudioDevice
    throw UnimplementedError();
  }
}

extension MeetingControllerExt on MeetingController {}
