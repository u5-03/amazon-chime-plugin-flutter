// Autogenerated from Pigeon (v12.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

List<Object?> wrapResponse({
  Object? result,
  PlatformException? error,
  bool empty = false,
}) {
  if (empty) {
    return <Object?>[];
  }
  if (error == null) {
    return <Object?>[result];
  }
  return <Object?>[error.code, error.message, error.details];
}

enum MethodType {
  getPlatformVersion,
  requestMicrophonePermissions,
  requestCameraPermissions,
  initialAudioSelection,
  listAudioDevices,
  updateAudioDevice,
  localVideoOn,
  localVideoOff,
  join,
  mute,
  unmute,
  stop,
  videoTileAdd,
  videoTileRemove,
  audioSessionDidDrop,
  audioSessionDidStop,
}

enum AmazonChimeErrorType {
  unknown,
  invalidResponse,
  responseMessage,
  customError,
}

class JoinParameter {
  JoinParameter({
    required this.meetingId,
    required this.externalMeetingId,
    required this.mediaRegion,
    required this.audioHostUrl,
    required this.audioFallbackUrl,
    required this.signalingUrl,
    required this.turnControlUrl,
    required this.externalUserId,
    required this.attendeeId,
    required this.joinToken,
  });

  String meetingId;

  String externalMeetingId;

  String mediaRegion;

  String audioHostUrl;

  String audioFallbackUrl;

  String signalingUrl;

  String turnControlUrl;

  String externalUserId;

  String attendeeId;

  String joinToken;

  Object encode() {
    return <Object?>[
      meetingId,
      externalMeetingId,
      mediaRegion,
      audioHostUrl,
      audioFallbackUrl,
      signalingUrl,
      turnControlUrl,
      externalUserId,
      attendeeId,
      joinToken,
    ];
  }

  // ignore: prefer_constructors_over_static_methods
  static JoinParameter decode(Object result) {
    result as List<Object?>;
    return JoinParameter(
      meetingId: result[0]! as String,
      externalMeetingId: result[1]! as String,
      mediaRegion: result[2]! as String,
      audioHostUrl: result[3]! as String,
      audioFallbackUrl: result[4]! as String,
      signalingUrl: result[5]! as String,
      turnControlUrl: result[6]! as String,
      externalUserId: result[7]! as String,
      attendeeId: result[8]! as String,
      joinToken: result[9]! as String,
    );
  }
}

class ParticipantInfo {
  ParticipantInfo({
    required this.attendeeId,
    required this.externalUserId,
  });

  String attendeeId;

  String externalUserId;

  Object encode() {
    return <Object?>[
      attendeeId,
      externalUserId,
    ];
  }

  // ignore: prefer_constructors_over_static_methods
  static ParticipantInfo decode(Object result) {
    result as List<Object?>;
    return ParticipantInfo(
      attendeeId: result[0]! as String,
      externalUserId: result[1]! as String,
    );
  }
}

class TileInfo {
  TileInfo({
    required this.tileId,
    required this.attendeeId,
    required this.videoStreamContentWidth,
    required this.videoStreamContentHeight,
    required this.isLocalTile,
    required this.isContent,
  });

  int tileId;

  String attendeeId;

  double videoStreamContentWidth;

  double videoStreamContentHeight;

  bool isLocalTile;

  bool isContent;

  Object encode() {
    return <Object?>[
      tileId,
      attendeeId,
      videoStreamContentWidth,
      videoStreamContentHeight,
      isLocalTile,
      isContent,
    ];
  }

  // ignore: prefer_constructors_over_static_methods
  static TileInfo decode(Object result) {
    result as List<Object?>;
    return TileInfo(
      tileId: result[0]! as int,
      attendeeId: result[1]! as String,
      videoStreamContentWidth: result[2]! as double,
      videoStreamContentHeight: result[3]! as double,
      isLocalTile: result[4]! as bool,
      isContent: result[5]! as bool,
    );
  }
}

class _RequesterToNativeCodec extends StandardMessageCodec {
  const _RequesterToNativeCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is JoinParameter) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return JoinParameter.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class RequesterToNative {
  /// Constructor for [RequesterToNative].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  RequesterToNative({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _RequesterToNativeCodec();

  Future<String> getPlatformVersion() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.getPlatformVersion',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<String> initialAudioSelection() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.initialAudioSelection',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<List<String?>> listAudioDevices() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.listAudioDevices',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as List<Object?>?)!.cast<String?>();
    }
  }

  Future<String> updateCurrentDevice(String arg_deviceLabel) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.updateCurrentDevice',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_deviceLabel]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<void> startLocalVideo() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.startLocalVideo',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> stopLocalVideo() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.stopLocalVideo',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> join(JoinParameter arg_parameter) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.join',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_parameter]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> stop() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.stop',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> mute() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.mute',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> unmute() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.unmute',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}

class _RequesterToFlutterCodec extends StandardMessageCodec {
  const _RequesterToFlutterCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is ParticipantInfo) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is TileInfo) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return ParticipantInfo.decode(readValue(buffer)!);
      case 129:
        return TileInfo.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class RequesterToFlutter {
  static const MessageCodec<Object?> codec = _RequesterToFlutterCodec();

  void audioSessionDidDrop();

  void audioSessionDidStop();

  void joined(ParticipantInfo info);

  void left(ParticipantInfo info);

  void dropped(ParticipantInfo info);

  void muted(ParticipantInfo info);

  void unmuted(ParticipantInfo info);

  void videoTileAdded(TileInfo info);

  void videoTileRemoved(TileInfo info);

  static void setup(
    RequesterToFlutter? api, {
    BinaryMessenger? binaryMessenger,
  }) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.audioSessionDidDrop',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          try {
            api.audioSessionDidDrop();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
              error: PlatformException(code: 'error', message: e.toString()),
            );
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.audioSessionDidStop',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          try {
            api.audioSessionDidStop();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
              error: PlatformException(code: 'error', message: e.toString()),
            );
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.joined',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.joined was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final ParticipantInfo? arg_info = (args[0] as ParticipantInfo?);
          assert(
            arg_info != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.joined was null, expected non-null ParticipantInfo.',
          );
          try {
            api.joined(arg_info!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
              error: PlatformException(
                code: 'error',
                message: e.toString(),
              ),
            );
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.left',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.left was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final ParticipantInfo? arg_info = (args[0] as ParticipantInfo?);
          assert(
            arg_info != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.left was null, expected non-null ParticipantInfo.',
          );
          try {
            api.left(arg_info!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
              error: PlatformException(code: 'error', message: e.toString()),
            );
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.dropped',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.dropped was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final ParticipantInfo? arg_info = (args[0] as ParticipantInfo?);
          assert(
            arg_info != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.dropped was null, expected non-null ParticipantInfo.',
          );
          try {
            api.dropped(arg_info!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
              error: PlatformException(code: 'error', message: e.toString()),
            );
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.muted',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.muted was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final ParticipantInfo? arg_info = (args[0] as ParticipantInfo?);
          assert(
            arg_info != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.muted was null, expected non-null ParticipantInfo.',
          );
          try {
            api.muted(arg_info!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
              error: PlatformException(code: 'error', message: e.toString()),
            );
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.unmuted',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.unmuted was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final ParticipantInfo? arg_info = (args[0] as ParticipantInfo?);
          assert(
            arg_info != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.unmuted was null, expected non-null ParticipantInfo.',
          );
          try {
            api.unmuted(arg_info!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
              error: PlatformException(code: 'error', message: e.toString()),
            );
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileAdded',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileAdded was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final TileInfo? arg_info = (args[0] as TileInfo?);
          assert(
            arg_info != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileAdded was null, expected non-null TileInfo.',
          );
          try {
            api.videoTileAdded(arg_info!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
              error: PlatformException(code: 'error', message: e.toString()),
            );
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileRemoved',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileRemoved was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final TileInfo? arg_info = (args[0] as TileInfo?);
          assert(
            arg_info != null,
            'Argument for dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileRemoved was null, expected non-null TileInfo.',
          );
          try {
            api.videoTileRemoved(arg_info!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
              error: PlatformException(code: 'error', message: e.toString()),
            );
          }
        });
      }
    }
  }
}
