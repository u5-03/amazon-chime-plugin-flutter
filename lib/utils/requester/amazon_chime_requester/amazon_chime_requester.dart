import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_plugin_platform_interface.dart';
import 'package:amazon_chime_plugin/utils/result.dart';

final class AmazonChimeRequester extends AmazonChimeRequesterPlatform {
  @override
  Future<Result<String>> getPlatformVersion() {
    return AmazonChimeRequesterPlatform.instance.getPlatformVersion();
  }

  @override
  Future<Result<String>> initialAudioSelection() async {
    return AmazonChimeRequesterPlatform.instance.initialAudioSelection();
  }

  @override
  Future<Result<List<String>>> listAudioDevices() async {
    return AmazonChimeRequesterPlatform.instance.listAudioDevices();
  }

  @override
  Future<Result<String>> updateCurrentDevice(
    String deviceLabel,
  ) async {
    return AmazonChimeRequesterPlatform.instance
        .updateCurrentDevice(deviceLabel);
  }

  @override
  Future<Result<void>> startLocalVideo() async {
    return AmazonChimeRequesterPlatform.instance.startLocalVideo();
  }

  @override
  Future<Result<void>> stopLocalVideo() async {
    return AmazonChimeRequesterPlatform.instance.stopLocalVideo();
  }

  @override
  Future<Result<void>> join(
    JoinParameter parameter,
  ) async {
    return AmazonChimeRequesterPlatform.instance.join(parameter);
  }

  @override
  Future<Result<void>> stop() async {
    return AmazonChimeRequesterPlatform.instance.stop();
  }

  @override
  Future<Result<void>> mute() async {
    return AmazonChimeRequesterPlatform.instance.mute();
  }

  @override
  Future<Result<void>> unmute() async {
    return AmazonChimeRequesterPlatform.instance.unmute();
  }
}
