// ignore_for_file: one_member_abstracts

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/generated/message_data.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/dena/amazon/chime/flutter/amazon_chime_plugin/Generated/MessageData.g.kt',
    kotlinOptions: KotlinOptions(),
    swiftOut: 'ios/Classes/Generated/MessageData.g.swift',
    swiftOptions: SwiftOptions(),
    copyrightHeader: 'lib/pigeon/generated/copyright.txt',
    dartPackageName: 'amazon_chime_plugin',
  ),
)
enum MethodType {
  getPlatformVersion,
  requestMicrophonePermissions,
  requestCameraPermissions,
}

class StringData {
  StringData({required this.result, required this.data});
  bool result;
  String data;
}

enum AmazonChimeErrorType {
  unknown,
  invalidResponse,
  customError,
}

@HostApi() // Flutter -> Native
abstract class RequesterToNative {
  @async
  StringData sendMessage(MethodType type);
}

@FlutterApi() // Native -> Flutter
abstract class RequesterToFlutter {
  // TODO: 実装
}
