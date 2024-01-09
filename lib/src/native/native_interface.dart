import 'package:amazon_chime_plugin/src/models/join_info_model.dart';
import 'package:amazon_chime_plugin/src/native/native_impl.dart';

abstract class NativeInterface {
  Future<String> getPlatformVersion();
  Future<String> initialAudioSelection();
  Future<List<String?>> listAudioDevices();
  Future<String> updateCurrentDevice(
    String deviceLabel,
  );
  Future<void> startLocalVideo();
  Future<void> stopLocalVideo();
  Future<void> joinMeeting(
    JoinInfoModel info,
  );
  Future<void> stop();
  Future<void> mute();
  Future<void> unmute();
  Future<void> switchLocalCamera();

  static NativeInterface get defaultInstance => NativeImpl();
}
