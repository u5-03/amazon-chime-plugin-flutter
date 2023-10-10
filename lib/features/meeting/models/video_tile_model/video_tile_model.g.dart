// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_tile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoTileModel _$$_VideoTileModelFromJson(Map<String, dynamic> json) =>
    _$_VideoTileModel(
      tileId: json['tileId'] as int,
      videoStreamContentWidth: json['videoStreamContentWidth'] as int,
      videoStreamContentHeight: json['videoStreamContentHeight'] as int,
      isLocalTile: json['isLocalTile'] as bool,
      isContentShare: json['isContentShare'] as bool,
    );

Map<String, dynamic> _$$_VideoTileModelToJson(_$_VideoTileModel instance) =>
    <String, dynamic>{
      'tileId': instance.tileId,
      'videoStreamContentWidth': instance.videoStreamContentWidth,
      'videoStreamContentHeight': instance.videoStreamContentHeight,
      'isLocalTile': instance.isLocalTile,
      'isContentShare': instance.isContentShare,
    };
