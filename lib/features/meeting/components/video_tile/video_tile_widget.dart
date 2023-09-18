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

class VideoTileWidget extends ConsumerWidget {
  const VideoTileWidget({
    required this.tileKind,
    super.key,
  });

  final VideoTileKind tileKind;

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: 200,
        height: 230,
        child: GestureDetector(
          onDoubleTap: () {
            // TODO: implement
            print('Show ScreenShare screen');
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ScreenShare(paramsVT: paramsVT),
            //   ),
          },
          child: videoTile,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget paddingChildWidget(int tileId) {
      if (Platform.isIOS) {
        return _iosVideoTile(tileId: tileId);
      } else if (Platform.isAndroid) {
        return _androidVideoTile(tileId: tileId);
      } else {
        return const Text('Unrecognized Platform.');
      }
    }

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
        tileIdParameter = participants[remoteParticipantId]?.videoTile?.tileId;
      case VideoTileKind.content:
        tileIdParameter = tileId;
    }
    if (tileIdParameter == null) {
      return Container(
        color: Colors.blue,
        child: const Text('tileIdParameter is null'),
      );
    }
    if (tileKind == VideoTileKind.content) {
      return contentVideoTileWidget(
        tileId: tileIdParameter,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          width: 200,
          height: 230,
          child: paddingChildWidget(tileIdParameter),
        ),
      );
    }
  }

  static List<Widget> displayVideoTiles(
    Orientation orientation,
    MeetingData meetingData,
  ) {
    const Widget screenShareWidget = Expanded(
      child: VideoTileWidget(
        tileKind: VideoTileKind.content,
      ),
    );
    const localVideoTile = VideoTileWidget(tileKind: VideoTileKind.local);
    const remoteVideoTile = VideoTileWidget(tileKind: VideoTileKind.remote);

    final contentParticipantId = meetingData.contentParticipantId;
    final localParticipantId = meetingData.localParticipantId;
    final remoteParticipantId = meetingData.remoteParticipantId;
    final participants = meetingData.participants;

    if (participants.containsKey(contentParticipantId)) {
      if (meetingData.isReceivingScreenShare) {
        return [screenShareWidget];
      }
    }
    print('DisplayVideoTiles: $participants');
    final videoTiles = <Widget>[];

    if (participants[localParticipantId]?.isVideoOn ?? false) {
      if (participants[localParticipantId]?.videoTile != null) {
        videoTiles.add(localVideoTile);
      }
    }
    if (participants.length > 1) {
      if (participants.containsKey(remoteParticipantId)) {
        if ((participants[remoteParticipantId]?.isVideoOn ?? false) &&
            participants[remoteParticipantId]?.videoTile != null) {
          videoTiles.add(const Expanded(child: remoteVideoTile));
        }
      }
    }

    if (videoTiles.isEmpty) {
      final Widget emptyVideos = Container(
        color: Colors.blue,
        child: const Text(
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
          Center(
            widthFactor: 2.5,
            child: emptyVideos,
          ),
        );
      }
    }

    return videoTiles;
  }
}
