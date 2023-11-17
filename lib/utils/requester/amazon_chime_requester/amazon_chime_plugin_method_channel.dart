import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/extensions/list.dart';
import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_plugin_platform_interface.dart';
import 'package:amazon_chime_plugin/utils/requester/requester_to_flutter.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of AmazonChimePluginRequesterPlatform that uses method channels.
final class MethodChannelAmazonChimeRequester
    extends AmazonChimeRequesterPlatform {
  MethodChannelAmazonChimeRequester() : super() {
    RequesterToFlutter.setup(
      // RequesterToFlutterImp(container.read(meetingControllerProvider.notifier)),
      RequesterToFlutterImp(),
    );
  }

  @visibleForTesting
  final methodChannel = const MethodChannel('amazon_chime_plugin');
  final RequesterToNative requester = RequesterToNative();

  @override
  Future<Result<String>> getPlatformVersion() async {
    return _runCatching(() async {
      final version = await requester.getPlatformVersion();
      return version;
    });
  }

  @override
  Future<Result<String>> initialAudioSelection() async {
    return _runCatching(() async {
      final response = await requester.initialAudioSelection();
      return response;
    });
  }

  @override
  Future<Result<List<String>>> listAudioDevices() async {
    return _runCatching(() async {
      final response = await requester.listAudioDevices();
      return Future.value(response.nonNullable);
    });
  }

  @override
  Future<Result<String>> updateCurrentDevice(
    String deviceLabel,
  ) async {
    return _runCatching(() async {
      final response = await requester.updateCurrentDevice(deviceLabel);
      return response;
    });
  }

  @override
  Future<Result<void>> startLocalVideo() async {
    return _runCatching(() async {
      final response = await requester.startLocalVideo();
      return response;
    });
  }

  @override
  Future<Result<void>> stopLocalVideo() async {
    return _runCatching(() async {
      final response = await requester.stopLocalVideo();
      return response;
    });
  }

  @override
  Future<Result<void>> join(
    JoinParameter parameter,
  ) async {
    return _runCatching(() async {
      final response = await requester.join(parameter);
      return response;
    });
  }

  @override
  Future<Result<void>> stop() async {
    return _runCatching(() async {
      return requester.stop();
    });
  }

  @override
  Future<Result<void>> mute() async {
    return _runCatching(() async {
      return requester.mute();
    });
  }

  @override
  Future<Result<void>> unmute() async {
    return _runCatching(() async {
      return requester.unmute();
    });
  }

  @override
  Future<Result<void>> switchLocalCamera() async {
    return _runCatching(() async {
      return requester.switchCamera();
    });
  }
}

extension MethodChannelAmazonChimePluginExt
    on MethodChannelAmazonChimeRequester {
  Future<Result<S>> _runCatching<S>(
    Future<S> Function() action,
  ) async {
    try {
      final value = await action();
      return Result.success(value);
    } on PlatformException catch (e) {
      final errorType = AmazonChimeErrorTypeExt.init(e.code);
      switch (errorType) {
        case AmazonChimeErrorType.invalidResponse:
          return Result.failure(AmazonChimeError.invalidResponse());
        case AmazonChimeErrorType.customError:
          return Result.failure(AmazonChimeError.customError(e.message ?? ''));
        case AmazonChimeErrorType.responseMessage:
          return Result.failure(
            AmazonChimeError.responseMessage(e.message ?? ''),
          );
        case AmazonChimeErrorType.unknown:
          return Result.failure(AmazonChimeError.unknown());
      }
    }
  }
}
