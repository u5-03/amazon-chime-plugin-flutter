import 'package:amazon_chime_plugin/amazon_chime_plugin_platform_interface.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [AmazonChimePluginPlatform] that uses method channels.
class MethodChannelAmazonChimePlugin extends AmazonChimePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('amazon_chime_plugin');
  final RequesterToNative requester = RequesterToNative();

  @override
  Future<Result<String, AmazonChimeError>> getPlatformVersion() async {
    return runCatching(() async {
      final version =
          await requester.sendMessage(MethodType.getPlatformVersion);
      return version.data;
    });
  }

  @override
  Future<Result<String, AmazonChimeError>>
      requestMicrophonePermissions() async {
    return runCatching(() async {
      final response =
          await requester.sendMessage(MethodType.requestMicrophonePermissions);
      return response.data;
    });
  }

  @override
  Future<Result<String, AmazonChimeError>> requestCameraPermissions() async {
    return runCatching(() async {
      final response =
          await requester.sendMessage(MethodType.requestCameraPermissions);
      return response.data;
    });
  }

  Future<Result<S, AmazonChimeError>> runCatching<S>(
    Future<S> Function() action,
  ) async {
    try {
      final value = await action();
      return Success(value);
    } on PlatformException catch (e) {
      final errorType = AmazonChimeErrorTypeExt.init(e.code);
      switch (errorType) {
        case AmazonChimeErrorType.invalidResponse:
          return Failure(AmazonChimeError.invalidResponse());
        case AmazonChimeErrorType.customError:
          return Failure(AmazonChimeError.customError(e.message ?? ''));
        case AmazonChimeErrorType.unknown:
          return Failure(AmazonChimeError.unknown());
      }
    }
  }
}
