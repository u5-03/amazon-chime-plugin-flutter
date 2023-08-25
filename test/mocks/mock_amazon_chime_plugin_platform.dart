import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
import 'package:amazon_chime_plugin/amazon_chime_plugin_platform_interface.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAmazonChimePluginPlatform
    with MockPlatformInterfaceMixin
    implements AmazonChimePluginPlatform {
  @override
  Future<Result<String, AmazonChimeError>> getPlatformVersion() {
    return Future.value(const Success('42'));
  }

  @override
  Future<Result<String, AmazonChimeError>> requestCameraPermissions() {
    return Future.value(const Success('Camera authorized.'));
  }

  @override
  Future<Result<String, AmazonChimeError>> requestMicrophonePermissions() {
    return Future.value(const Success('Microphone authorized.'));
  }
}
