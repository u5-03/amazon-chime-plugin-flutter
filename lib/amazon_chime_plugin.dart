import 'package:amazon_chime_plugin/amazon_chime_plugin_platform_interface.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/utils/result.dart';

export 'utils/result.dart';

class AmazonChimePlugin {
  Future<Result<String, AmazonChimeError>> getPlatformVersion() {
    return AmazonChimePluginPlatform.instance.getPlatformVersion();
  }

  Future<Result<String, AmazonChimeError>> requestMicrophonePermissions() {
    return AmazonChimePluginPlatform.instance.requestMicrophonePermissions();
  }

  Future<Result<String, AmazonChimeError>> requestCameraPermissions() {
    return AmazonChimePluginPlatform.instance.requestCameraPermissions();
  }
}
