// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParticipantModelImpl _$$ParticipantModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ParticipantModelImpl(
      participantId: json['participantId'] as String,
      externalUserId: json['externalUserId'] as String,
      muteStatus: json['muteStatus'] as bool? ?? false,
      isVideoOn: json['isVideoOn'] as bool? ?? false,
      videoTile: json['videoTile'] == null
          ? null
          : VideoTileModel.fromJson(json['videoTile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ParticipantModelImplToJson(
        _$ParticipantModelImpl instance) =>
    <String, dynamic>{
      'participantId': instance.participantId,
      'externalUserId': instance.externalUserId,
      'muteStatus': instance.muteStatus,
      'isVideoOn': instance.isVideoOn,
      'videoTile': instance.videoTile,
    };
