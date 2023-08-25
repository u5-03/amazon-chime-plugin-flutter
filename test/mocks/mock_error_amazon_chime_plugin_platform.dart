import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
import 'package:amazon_chime_plugin/amazon_chime_plugin_platform_interface.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockErrorAmazonChimePluginPlatform
    with MockPlatformInterfaceMixin
    implements AmazonChimePluginPlatform {
  @override
  Future<Result<String, AmazonChimeError>> getPlatformVersion() {
    return Future.value(Failure(AmazonChimeError.invalidResponse()));
  }

  @override
  Future<Result<String, AmazonChimeError>> requestCameraPermissions() {
    return Future.value(
      Failure(
        AmazonChimeError.customError('This is camera permission error!'),
      ),
    );
  }

  @override
  Future<Result<String, AmazonChimeError>> requestMicrophonePermissions() {
    return Future.value(Failure(AmazonChimeError.unknown()));
  }
}
