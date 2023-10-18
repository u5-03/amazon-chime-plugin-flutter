import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/extensions/list.dart';
import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_plugin_platform_interface.dart';
import 'package:amazon_chime_plugin/utils/requester/requester_to_flutter.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// An implementation of AmazonChimePluginRequesterPlatform that uses method channels.
final class MethodChannelAmazonChimeRequester
    extends AmazonChimeRequesterPlatform {
  MethodChannelAmazonChimeRequester() : super() {
    RequesterToFlutter.setup(
      // RequesterToFlutterImp(container.read(meetingControllerProvider.notifier)),
      RequesterToFlutterImp(),
    );
  }
  final container = ProviderContainer();

  @visibleForTesting
  final methodChannel = const MethodChannel('amazon_chime_plugin');
  final RequesterToNative requester = RequesterToNative();

  @override
  Future<Result<String, AmazonChimeError>> getPlatformVersion() async {
    return _runCatching(() async {
      final version = await requester.getPlatformVersion();
      return version;
    });
  }

  @override
  Future<Result<String, AmazonChimeError>> initialAudioSelection() async {
    return _runCatching(() async {
      final response = await requester.initialAudioSelection();
      return response;
    });
  }

  @override
  Future<Result<List<String>, AmazonChimeError>> listAudioDevices() async {
    return _runCatching(() async {
      final response = await requester.listAudioDevices();
      return Future.value(response.nonNullable);
    });
  }

  @override
  Future<Result<String, AmazonChimeError>> updateCurrentDevice(
    String deviceLabel,
  ) async {
    return _runCatching(() async {
      final response = await requester.updateCurrentDevice(deviceLabel);
      return response;
    });
  }

  @override
  Future<Result<void, AmazonChimeError>> startLocalVideo() async {
    return _runCatching(() async {
      final response = await requester.startLocalVideo();
      return response;
    });
  }

  @override
  Future<Result<void, AmazonChimeError>> stopLocalVideo() async {
    return _runCatching(() async {
      final response = await requester.stopLocalVideo();
      return response;
    });
  }

  @override
  Future<Result<void, AmazonChimeError>> join(
    JoinParameter parameter,
  ) async {
    return _runCatching(() async {
      final response = await requester.join(parameter);
      return response;
    });
  }

  @override
  Future<Result<void, AmazonChimeError>> stop() async {
    return _runCatching(() async {
      return requester.stop();
    });
  }

  @override
  Future<Result<void, AmazonChimeError>> mute() async {
    return _runCatching(() async {
      return requester.mute();
    });
  }

  @override
  Future<Result<void, AmazonChimeError>> unmute() async {
    return _runCatching(() async {
      return requester.unmute();
    });
  }
}

extension MethodChannelAmazonChimePluginExt
    on MethodChannelAmazonChimeRequester {
  Future<Result<S, AmazonChimeError>> _runCatching<S>(
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
        case AmazonChimeErrorType.responseMessage:
          return Failure(AmazonChimeError.responseMessage(e.message ?? ''));
        case AmazonChimeErrorType.unknown:
          return Failure(AmazonChimeError.unknown());
      }
    }
  }
}
