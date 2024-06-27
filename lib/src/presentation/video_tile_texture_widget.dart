import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
import 'package:amazon_chime_plugin/src/controllers/meeting_notifier.dart';
import 'package:amazon_chime_plugin/src/native/native_interface.dart';
import 'package:flutter/material.dart';

final class VideoTileTextureWidget extends StatefulWidget {
  const VideoTileTextureWidget({
    required this.tileId,
    required this.notifier,
    this.isMirror = false,
    super.key,
  });

  static int get _uninitializedTextureId => -1;

  final int tileId;
  final bool isMirror;
  final MeetingNotifier notifier;

  @override
  State<VideoTileTextureWidget> createState() => _VideoTileTextureWidgetState();

  static List<int> displayVideoTextureTiles(
    MeetingController controller,
  ) {
    final contentAttendeeId = controller.notifier.value.contentAttendeeId;
    final localAttendeeId = controller.notifier.value.localAttendeeId;
    final remoteAttendeeId = controller.notifier.value.remoteAttendeeId;
    final attendees = controller.notifier.value.attendees;

    if (attendees.containsKey(contentAttendeeId)) {
      final contentTileId = attendees[contentAttendeeId]?.videoTile?.tileId;
      if (controller.notifier.value.isReceivingScreenShare &&
          contentTileId != null) {
        return [contentTileId];
      }
    }
    final videoTileIdList = <int>[];
    if (attendees[localAttendeeId]?.isVideoOn ?? false) {
      final localTileId = attendees[localAttendeeId]?.videoTile?.tileId;
      if (localTileId != null) {
        videoTileIdList.add(localTileId);
      }
    }
    if (attendees.length > 1) {
      if (attendees.containsKey(remoteAttendeeId)) {
        final remoteTileId = attendees[remoteAttendeeId]?.videoTile?.tileId;
        if ((attendees[remoteAttendeeId]?.isVideoOn ?? false) &&
            remoteTileId != null) {
          videoTileIdList.add(remoteTileId);
        }
      }
    }
    return videoTileIdList;
  }
}

final class _VideoTileTextureWidgetState extends State<VideoTileTextureWidget> {
  var _textureId = VideoTileTextureWidget._uninitializedTextureId;
  // If default size is zero, Texture view process won't work
  var _bufferSize = Size.square(100);

  @override
  void initState() {
    super.initState();

    NativeInterface.defaultInstance
        .createTileTexture(widget.tileId)
        .then((textureId) {
      setState(() {
        _textureId = textureId;
      });
    });
    widget.notifier.addListener(_notifierListener);
  }

  @override
  void dispose() {
    NativeInterface.defaultInstance.disposeTileTexture(widget.tileId);
    widget.notifier.removeListener(_notifierListener);
    super.dispose();
  }

  void _notifierListener() {
    final videoBufferSize =
        widget.notifier.value.videoBufferSizes[widget.tileId];
    if (videoBufferSize != null) {
      setState(() {
        _bufferSize = videoBufferSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _textureId != VideoTileTextureWidget._uninitializedTextureId
        ? ClipRect(
            child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    height: _bufferSize.height,
                    width: _bufferSize.width,
                    child: Texture(textureId: _textureId))),
          )
        : SizedBox.shrink();
  }
}
