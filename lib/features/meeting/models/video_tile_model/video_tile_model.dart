import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_tile_model.freezed.dart';
part 'video_tile_model.g.dart';

@freezed
class VideoTileModel with _$VideoTileModel {
  const factory VideoTileModel({
    required int tileId,
    required int videoStreamContentWidth,
    required int videoStreamContentHeight,
    required bool isLocalTile,
    required bool isContentShare,
  }) = _VideoTileModel;

  factory VideoTileModel.fromJson(Map<String, dynamic> json) =>
      _$VideoTileModelFromJson(json);

  factory VideoTileModel.fromPigeonModel(TileInfo info) => VideoTileModel(
        tileId: info.tileId,
        videoStreamContentWidth: info.videoStreamContentWidth.toInt(),
        videoStreamContentHeight: info.videoStreamContentWidth.toInt(),
        isLocalTile: info.isLocalTile,
        isContentShare: info.isContent,
      );
}
