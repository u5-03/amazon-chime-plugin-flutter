// import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
// import 'package:amazon_chime_plugin/amazon_chime_plugin_method_channel.dart';
// import 'package:amazon_chime_plugin/amazon_chime_plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // final initialPlatform = AmazonChimePlatform.instance;

  // test('$MethodChannelAmazonChimePlugin is the default instance', () {
  //   expect(initialPlatform, isInstanceOf<MethodChannelAmazonChimePlugin>());
  // });

  test('testFromFlutterToNative', () async {
    // final amazonChimePlugin = AmazonChimePlugin();
    // final fakePlatform = MockAmazonChimePluginPlatform();
    // AmazonChimePlatform.instance = fakePlatform;

    // expect((await amazonnative.getPlatformVersion()).value, '42');
    // expect(
    //   (await amazonnative.requestCameraPermissions()).value,
    //   'Camera authorized.',
    // );
    // expect(
    //   (await amazonnative.requestMicrophonePermissions()).value,
    //   'Microphone authorized.',
    // );
  });

  test('testErrorFromFlutterToNative', () async {
    // final amazonChimePlugin = AmazonChimePlugin();
    // final fakePlatform = MockErrorAmazonChimePluginPlatform();
    // AmazonChimePlatform.instance = fakePlatform;
    // expect(
    //   (await amazonnative.getPlatformVersion()).error,
    //   AmazonChimeError.invalidResponse(),
    // );
    // expect(
    //   (await amazonnative.requestCameraPermissions()).error,
    //   AmazonChimeError.customError('This is camera permission error!'),
    // );
    // expect(
    //   (await amazonnative.requestMicrophonePermissions()).error,
    //   AmazonChimeError.unknown(),
    // );
  });
}
