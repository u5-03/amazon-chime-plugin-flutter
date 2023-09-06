import 'package:amazon_chime_plugin/features/meeting/components/video_tile/video_tile_widget.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenShareWidget extends ConsumerWidget {
  const ScreenShareWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Widget contentTile = VideoTileWidget(tileKind: VideoTileKind.content);
    Widget body;

    if (!ref.read(meetingRepositoryProvider).isReceivingScreenShare) {
      body = GestureDetector(
        onDoubleTap: () => Navigator.popAndPushNamed(context, '/meeting'),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Screenshare is no longer active.'),
            ),
            Center(
              child: Text(
                'Double tap to go back to meeting.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    } else {
      body = Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onDoubleTap: () =>
                    Navigator.popAndPushNamed(context, '/meeting'),
                child: contentTile,
              ),
            ),
          ),
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        await Navigator.popAndPushNamed(context, '/meeting');
        return false;
      },
      child: Scaffold(
        body: body,
      ),
    );
  }
}
