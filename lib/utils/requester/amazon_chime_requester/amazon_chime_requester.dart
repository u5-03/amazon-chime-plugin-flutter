import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_plugin_platform_interface.dart';
import 'package:amazon_chime_plugin/utils/result.dart';

export '../../result.dart';

final class AmazonChimeRequester extends AmazonChimeRequesterPlatform {
  @override
  Future<Result<String, AmazonChimeError>> getPlatformVersion() {
    return AmazonChimeRequesterPlatform.instance.getPlatformVersion();
  }

  @override
  Future<Result<String, AmazonChimeError>> requestMicrophonePermissions() {
    return AmazonChimeRequesterPlatform.instance.requestMicrophonePermissions();
  }

  @override
  Future<Result<String, AmazonChimeError>> requestCameraPermissions() {
    return AmazonChimeRequesterPlatform.instance.requestCameraPermissions();
  }

  @override
  Future<Result<String, AmazonChimeError>> initialAudioSelection() async {
    return AmazonChimeRequesterPlatform.instance.initialAudioSelection();
  }

  @override
  Future<Result<List<String>, AmazonChimeError>> listAudioDevices() async {
    return AmazonChimeRequesterPlatform.instance.listAudioDevices();
  }

  @override
  Future<Result<String, AmazonChimeError>> updateCurrentDevice(
    String deviceLabel,
  ) async {
    return AmazonChimeRequesterPlatform.instance
        .updateCurrentDevice(deviceLabel);
  }

  @override
  Future<Result<void, AmazonChimeError>> startLocalVideo() async {
    return AmazonChimeRequesterPlatform.instance.startLocalVideo();
  }

  @override
  Future<Result<void, AmazonChimeError>> stopLocalVideo() async {
    return AmazonChimeRequesterPlatform.instance.stopLocalVideo();
  }

  @override
  Future<Result<void, AmazonChimeError>> join(
    JoinParameter parameter,
  ) async {
    return AmazonChimeRequesterPlatform.instance.join(parameter);
  }

  @override
  Future<Result<void, AmazonChimeError>> stop() async {
    return AmazonChimeRequesterPlatform.instance.stop();
  }

  @override
  Future<Result<void, AmazonChimeError>> mute() async {
    return AmazonChimeRequesterPlatform.instance.mute();
  }

  @override
  Future<Result<void, AmazonChimeError>> unmute() async {
    return AmazonChimeRequesterPlatform.instance.unmute();
  }
}
