import 'package:amazon_chime_plugin/src/controllers/meeting_notifier.dart';
import 'package:amazon_chime_plugin/src/data/api_client.dart';
import 'package:amazon_chime_plugin/src/data/api_config.dart';
import 'package:amazon_chime_plugin/src/interfaces/audio_devices_interface.dart';
import 'package:amazon_chime_plugin/src/models/join_info_model.dart';
import 'package:amazon_chime_plugin/src/native/native_interface.dart';
import 'package:amazon_chime_plugin/src/native/requester_to_flutter/requester_to_flutter_callbacks.dart';

final class MeetingController implements AudioDevicesInterface {
  MeetingController({
    this.callbacks,
    NativeInterface? native,
  })  : native = native ?? NativeInterface.defaultInstance,
        notifier = MeetingNotifier(
          native: NativeInterface.defaultInstance,
          callbacks: callbacks,
        );

  final NativeInterface native;
  final MeetingNotifier notifier;
  final RequesterToFlutterCallbacks? callbacks;

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
    return native.startLocalVideo();
  }

  Future<void> stopMeeting() {
    return native.stop();
  }

  Future<void> stopLocalVideo() {
    return native.stopLocalVideo();
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
