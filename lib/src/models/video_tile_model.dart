import 'package:flutter/foundation.dart';
import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';

final class VideoTileModel {
  final int tileId;
  final int videoStreamContentWidth;
  final int videoStreamContentHeight;
  final bool isLocalTile;
  final bool isContentShare;

  const VideoTileModel({
    required this.tileId,
    required this.videoStreamContentWidth,
    required this.videoStreamContentHeight,
    required this.isLocalTile,
    required this.isContentShare,
  });

  VideoTileModel copyWith({
    int? tileId,
    int? videoStreamContentWidth,
    int? videoStreamContentHeight,
    bool? isLocalTile,
    bool? isContentShare,
  }) {
    return VideoTileModel(
      tileId: tileId ?? this.tileId,
      videoStreamContentWidth:
          videoStreamContentWidth ?? this.videoStreamContentWidth,
      videoStreamContentHeight:
          videoStreamContentHeight ?? this.videoStreamContentHeight,
      isLocalTile: isLocalTile ?? this.isLocalTile,
      isContentShare: isContentShare ?? this.isContentShare,
    );
  }

  factory VideoTileModel.fromJson(Map<String, dynamic> json) {
    return VideoTileModel(
      tileId: json['tileId'],
      videoStreamContentWidth: json['videoStreamContentWidth'],
      videoStreamContentHeight: json['videoStreamContentHeight'],
      isLocalTile: json['isLocalTile'],
      isContentShare: json['isContentShare'],
    );
  }

  factory VideoTileModel.fromPigeonModel(TileInfo info) {
    return VideoTileModel(
      tileId: info.tileId,
      videoStreamContentWidth: info.videoStreamContentWidth.toInt(),
      videoStreamContentHeight: info.videoStreamContentHeight.toInt(),
      isLocalTile: info.isLocalTile,
      isContentShare: info.isContent,
    );
  }
}
