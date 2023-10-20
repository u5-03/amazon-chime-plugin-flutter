import 'dart:io';

import 'package:amazon_chime_plugin/constants/platform_view_kind.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_controller.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_data/meeting_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum VideoTileKind {
  local,
  remote,
  content,
}

final class VideoTileWidget extends ConsumerWidget {
  factory VideoTileWidget.tileId(int tileId) =>
      VideoTileWidget._(tileId: tileId);
  factory VideoTileWidget.tileKind(VideoTileKind tileKind) =>
      VideoTileWidget._(tileKind: tileKind);

  const VideoTileWidget._({this.tileKind, this.tileId});

  final VideoTileKind? tileKind;
  final int? tileId;

  Widget _iosVideoTile({required int tileId}) {
    return UiKitView(
      viewType: PlatformViewKind.videoTile.rawValue,
      creationParams: tileId,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  Widget _androidVideoTile({required int tileId}) {
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
          creationParams: tileId,
          creationParamsCodec: const StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
        return controller;
      },
    );
  }

  Widget contentVideoTileWidget({required int tileId}) {
    Widget videoTile;
    if (Platform.isIOS) {
      videoTile = _iosVideoTile(tileId: tileId);
    } else if (Platform.isAndroid) {
      videoTile = _androidVideoTile(tileId: tileId);
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileKind = this.tileKind;
    final tileId = this.tileId;
    if (tileKind != null) {
      final meetingData = ref.watch(meetingControllerProvider);
      final contentParticipantId = meetingData.contentParticipantId;
      final localParticipantId = meetingData.localParticipantId;
      final remoteParticipantId = meetingData.remoteParticipantId;
      final participants = meetingData.participants;

      final tileId = participants[contentParticipantId]?.videoTile?.tileId;

      int? tileIdParameter;
      switch (tileKind) {
        case VideoTileKind.local:
          tileIdParameter = participants[localParticipantId]?.videoTile?.tileId;
        case VideoTileKind.remote:
          tileIdParameter =
              participants[remoteParticipantId]?.videoTile?.tileId;
        case VideoTileKind.content:
          tileIdParameter = tileId;
      }
      if (tileIdParameter == null) {
        return const ColoredBox(
          color: Colors.blue,
          child: Text('tileIdParameter is null'),
        );
      }
      if (tileKind == VideoTileKind.content) {
        return contentVideoTileWidget(
          tileId: tileIdParameter,
        );
      } else {
        return contentVideoTileWidget(tileId: tileIdParameter);
      }
    } else if (tileId != null) {
      return contentVideoTileWidget(tileId: tileId);
    } else {
      throw Exception('Invalid tileKind or tileId.');
    }
  }

  static List<Widget> displayVideoTiles(
    Orientation orientation,
    MeetingData meetingData,
    Size size,
  ) {
    final Widget screenShareWidget = Expanded(
      child: VideoTileWidget.tileKind(VideoTileKind.content),
    );

    final contentParticipantId = meetingData.contentParticipantId;
    final localParticipantId = meetingData.localParticipantId;
    final remoteParticipantId = meetingData.remoteParticipantId;
    final participants = meetingData.participants;

    final localVideoTile = VideoTileWidget.tileKind(VideoTileKind.local);
    final remoteVideoTile = VideoTileWidget.tileKind(VideoTileKind.remote);

    if (participants.containsKey(contentParticipantId)) {
      if (meetingData.isReceivingScreenShare) {
        return [screenShareWidget];
      }
    }
    final videoTiles = <Widget>[];

    if (participants[localParticipantId]?.isVideoOn ?? false) {
      if (participants[localParticipantId]?.videoTile != null) {
        videoTiles.add(
          SizedBox(
            width: size.width,
            height: size.height,
            child: localVideoTile,
          ),
        );
      }
    }
    if (participants.length > 1) {
      if (participants.containsKey(remoteParticipantId)) {
        if ((participants[remoteParticipantId]?.isVideoOn ?? false) &&
            participants[remoteParticipantId]?.videoTile != null) {
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
