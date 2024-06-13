import 'package:amazon_chime_plugin/src/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/src/models/join_info_model.dart';
import 'package:amazon_chime_plugin/src/native/native_interface.dart';
import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';
import 'package:flutter/services.dart';

final class NativeImpl implements NativeInterface {
  final RequesterToNative requester = RequesterToNative();

  @override
  Future<String> getPlatformVersion() {
    return _runCatching(requester.getPlatformVersion);
  }

  @override
  Future<String> getActiveAudioDevice() {
    return _runCatching(requester.getActiveAudioDevice);
  }

  @override
  Future<void> joinMeeting(JoinInfoModel info) {
    return _runCatching(() => requester.join(info.asJoinParameter));
  }

  @override
  Future<List<String?>> listAudioDevices() {
    return _runCatching(requester.listAudioDevices);
  }

  @override
  Future<void> mute() {
    return _runCatching(requester.mute);
  }

  @override
  Future<void> startLocalVideo() {
    return _runCatching(requester.startLocalVideo);
  }

  @override
  Future<void> stop() {
    return _runCatching(requester.stop);
  }

  @override
  Future<void> stopLocalVideo() {
    return _runCatching(requester.stopLocalVideo);
  }

  @override
  Future<void> startRemoteVideo() {
    return _runCatching(requester.startRemoteVideo);
  }

  @override
  Future<void> stopRemoteVideo() {
    return _runCatching(requester.stopRemoteVideo);
  }

  @override
  Future<void> switchLocalCamera() {
    return _runCatching(requester.switchCamera);
  }

  @override
  Future<void> unmute() {
    return _runCatching(requester.unmute);
  }

  @override
  Future<String> updateCurrentDevice(String deviceLabel) {
    return _runCatching(() => requester.updateCurrentDevice(deviceLabel));
  }

  @override
  Future<int> createTileTexture(int tileId) {
    return _runCatching(() => requester.createTileTexture(tileId));
  }

  @override
  Future<int> disposeTileTexture(int tileId) {
    return _runCatching(() => requester.disposeTileTexture(tileId));
  }
}

extension NativeImplExt on NativeImpl {
  Future<S> _runCatching<S>(
    Future<S> Function() action,
  ) async {
    try {
      return await action();
    } on PlatformException catch (exception) {
      final errorType = AmazonChimeErrorTypeExt.init(exception.code);
      switch (errorType) {
        case AmazonChimeErrorType.invalidResponse:
          throw AmazonChimeError.invalidResponse();
        case AmazonChimeErrorType.customError:
          throw AmazonChimeError.customError(exception.message ?? '');
        case AmazonChimeErrorType.responseMessage:
          throw AmazonChimeError.responseMessage(exception.message ?? '');
        case AmazonChimeErrorType.unknown:
          throw AmazonChimeError.unknown();
      }
    }
  }
}
