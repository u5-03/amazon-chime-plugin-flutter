import 'dart:io';

import 'package:amazon_chime_plugin/src/constants/platform_view_kind.dart';
import 'package:amazon_chime_plugin/src/controllers/meeting_controller.dart';
import 'package:amazon_chime_plugin/src/controllers/value/meeting_value.dart';
import 'package:amazon_chime_plugin/src/utils/debug_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

enum VideoTileKind {
  local,
  remote,
  content,
}

sealed class VideoTileParameterType {
  const VideoTileParameterType._();
  const factory VideoTileParameterType.tileId(int tileId) = TileId;
  const factory VideoTileParameterType.tileKind(VideoTileKind tileKind) =
      TileKind;
}

final class TileId extends VideoTileParameterType {
  const TileId(this.tileId) : super._();
  final int tileId;
}

final class TileKind extends VideoTileParameterType {
  const TileKind(this.tileKind) : super._();
  final VideoTileKind tileKind;
}

final class VideoTileWidget extends StatelessWidget {
  const VideoTileWidget({
    required this.controller,
    required this.parameterType,
    this.isMirror = false,
    this.isScaleToFill = true,
    super.key,
  });

  static List<Widget> displayVideoTiles(
    Orientation orientation,
    MeetingController controller,
    Size size,
  ) =>
      VideoTileWidgetExt._displayVideoTiles(
        orientation,
        controller,
        size,
      );

  final MeetingController controller;
  final VideoTileParameterType parameterType;
  final bool isMirror;
  final bool isScaleToFill;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MeetingValue>(
      valueListenable: controller.notifier,
      builder: (context, value, child) {
        final contentAttendeeId = value.contentAttendeeId;
        final localAttendeeId = value.localAttendeeId;
        final remoteAttendeeId = value.remoteAttendeeId;
        final attendees = value.attendees;

        final tileId = attendees[contentAttendeeId]?.videoTile?.tileId;
        switch (parameterType) {
          case TileKind(tileKind: final tileKind):
            int? tileIdParameter;
            switch (tileKind) {
              case VideoTileKind.local:
                tileIdParameter = attendees[localAttendeeId]?.videoTile?.tileId;
              case VideoTileKind.remote:
                tileIdParameter =
                    attendees[remoteAttendeeId]?.videoTile?.tileId;
              case VideoTileKind.content:
                tileIdParameter = tileId;
            }
            if (tileIdParameter == null) {
              debugLog('tileIdParameter is null');
              return const SizedBox();
            }
            if (tileKind == VideoTileKind.content) {
              return contentVideoTileWidget(
                tileId: tileIdParameter,
              );
            } else {
              return contentVideoTileWidget(tileId: tileIdParameter);
            }
          case TileId(tileId: final tileId):
            return contentVideoTileWidget(tileId: tileId);
        }
      },
    );
  }
}

extension on VideoTileWidget {
  Widget contentVideoTileWidget({required int tileId}) {
    Widget videoTile;
    if (Platform.isIOS) {
      videoTile = _iosVideoTile(
        tileId: tileId,
        isMirror: isMirror,
        isScaleToFill: isScaleToFill,
      );
    } else if (Platform.isAndroid) {
      videoTile = _androidVideoTile(
        tileId: tileId,
        isMirror: isMirror,
        isScaleToFill: isScaleToFill,
      );
    } else {
      videoTile = const Text('Unrecognized Platform.');
    }

    return GestureDetector(
      onDoubleTap: () {
        // TODO: implement
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ScreenShare(paramsVT: paramsVT),
        //   ),
      },
      child: videoTile,
    );
  }

  Widget _iosVideoTile({
    required int tileId,
    bool isMirror = false,
    bool isScaleToFill = true,
  }) {
    return UiKitView(
      viewType: PlatformViewKind.videoTile.rawValue,
      creationParams: {
        'tileId': tileId,
        'isMirror': isMirror,
        'isScaleToFill': isScaleToFill,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  Widget _androidVideoTile({
    required int tileId,
    bool isMirror = false,
    bool isScaleToFill = true,
  }) {
    return PlatformViewLink(
      viewType: PlatformViewKind.videoTile.rawValue,
      surfaceFactory: (
        BuildContext context,
        PlatformViewController controller,
      ) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        final controller = PlatformViewsService.initExpensiveAndroidView(
          id: params.id,
          viewType: PlatformViewKind.videoTile.rawValue,
          layoutDirection: TextDirection.ltr,
          creationParams: {
            'tileId': tileId,
            'isMirror': isMirror,
            'isScaleToFill': isScaleToFill,
          },
          creationParamsCodec: const StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
        return controller;
      },
    );
  }
}

extension VideoTileWidgetExt on VideoTileWidget {
  static List<Widget> _displayVideoTiles(
    Orientation orientation,
    MeetingController controller,
    Size size,
  ) {
    final Widget screenShareWidget = Expanded(
      child: VideoTileWidget(
        parameterType: const VideoTileParameterType.tileKind(
          VideoTileKind.content,
        ),
        controller: controller,
      ),
    );

    final contentAttendeeId = controller.notifier.value.contentAttendeeId;
    final localAttendeeId = controller.notifier.value.localAttendeeId;
    final remoteAttendeeId = controller.notifier.value.remoteAttendeeId;
    final attendees = controller.notifier.value.attendees;

    final localVideoTile = VideoTileWidget(
      parameterType: const VideoTileParameterType.tileKind(
        VideoTileKind.local,
      ),
      controller: controller,
    );
    final remoteVideoTile = VideoTileWidget(
      parameterType: const VideoTileParameterType.tileKind(
        VideoTileKind.remote,
      ),
      controller: controller,
    );

    if (attendees.containsKey(contentAttendeeId)) {
      if (controller.notifier.value.isReceivingScreenShare) {
        return [screenShareWidget];
      }
    }
    final videoTiles = <Widget>[];

    if (attendees[localAttendeeId]?.isVideoOn ?? false) {
      if (attendees[localAttendeeId]?.videoTile != null) {
        videoTiles.add(
          SizedBox(
            width: size.width,
            height: size.height,
            child: localVideoTile,
          ),
        );
      }
    }
    if (attendees.length > 1) {
      if (attendees.containsKey(remoteAttendeeId)) {
        if ((attendees[remoteAttendeeId]?.isVideoOn ?? false) &&
            attendees[remoteAttendeeId]?.videoTile != null) {
          videoTiles.add(
            SizedBox(
              width: size.width,
              height: size.height,
              child: remoteVideoTile,
            ),
          );
        }
      }
    }

    if (videoTiles.isEmpty) {
      const Widget emptyVideos = ColoredBox(
        color: Colors.blue,
        child: Text(
          'No video detected',
          style: TextStyle(
            fontSize: 16, // ここでフォントサイズを指定します
          ),
        ),
      );
      if (orientation == Orientation.portrait) {
        videoTiles.add(
          emptyVideos,
        );
      } else {
        videoTiles.add(
          const Center(
            widthFactor: 2.5,
            child: emptyVideos,
          ),
        );
      }
    }

    return videoTiles;
  }
}
