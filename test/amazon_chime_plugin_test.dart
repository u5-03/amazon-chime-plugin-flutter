import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
import 'package:amazon_chime_plugin/amazon_chime_plugin_method_channel.dart';
import 'package:amazon_chime_plugin/amazon_chime_plugin_platform_interface.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_amazon_chime_plugin_platform.dart';
import 'mocks/mock_error_amazon_chime_plugin_platform.dart';

void main() {
  final initialPlatform = AmazonChimePluginPlatform.instance;

  test('$MethodChannelAmazonChimePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAmazonChimePlugin>());
  });

  test('testFromFlutterToNative', () async {
    final amazonChimePlugin = AmazonChimePlugin();
    final fakePlatform = MockAmazonChimePluginPlatform();
    AmazonChimePluginPlatform.instance = fakePlatform;

    expect((await amazonChimePlugin.getPlatformVersion()).value, '42');
    expect(
      (await amazonChimePlugin.requestCameraPermissions()).value,
      'Camera authorized.',
    );
    expect(
      (await amazonChimePlugin.requestMicrophonePermissions()).value,
      'Microphone authorized.',
    );
  });

  test('testErrorFromFlutterToNative', () async {
    final amazonChimePlugin = AmazonChimePlugin();
    final fakePlatform = MockErrorAmazonChimePluginPlatform();
    AmazonChimePluginPlatform.instance = fakePlatform;
    expect(
      (await amazonChimePlugin.getPlatformVersion()).error,
      AmazonChimeError.invalidResponse(),
    );
    expect(
      (await amazonChimePlugin.requestCameraPermissions()).error,
      AmazonChimeError.customError('This is camera permission error!'),
    );
    expect(
      (await amazonChimePlugin.requestMicrophonePermissions()).error,
      AmazonChimeError.unknown(),
    );
  });
}
