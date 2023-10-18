// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_ParticipantModel _$$_ParticipantModelFromJson(Map<String, dynamic> json) =>
    _$_ParticipantModel(
      participantId: json['participantId'] as String,
      externalUserId: json['externalUserId'] as String,
      muteStatus: json['muteStatus'] as bool? ?? false,
      isVideoOn: json['isVideoOn'] as bool? ?? false,
      videoTile: json['videoTile'] == null
          ? null
          : VideoTileModel.fromJson(json['videoTile'] as Map<String, dynamic>),
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_ParticipantModelToJson(_$_ParticipantModel instance) =>
    <String, dynamic>{
      'participantId': instance.participantId,
      'externalUserId': instance.externalUserId,
      'muteStatus': instance.muteStatus,
      'isVideoOn': instance.isVideoOn,
      'videoTile': instance.videoTile,
    };
