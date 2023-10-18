// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_JoinInfoModel _$$_JoinInfoModelFromJson(Map<String, dynamic> json) =>
    _$_JoinInfoModel(
      meeting: MeetingModel.fromJson(json['meeting'] as Map<String, dynamic>),
      attendeeInfo: AttendeeInfoModel.fromJson(
        json['attendeeInfo'] as Map<String, dynamic>,
      ),
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_JoinInfoModelToJson(_$_JoinInfoModel instance) =>
    <String, dynamic>{
      'meeting': instance.meeting,
      'attendeeInfo': instance.attendeeInfo,
    };

// ignore: non_constant_identifier_names
_$_MeetingModel _$$_MeetingModelFromJson(Map<String, dynamic> json) =>
    _$_MeetingModel(
      meetingId: json['meetingId'] as String,
      externalMeetingId: json['externalMeetingId'] as String,
      mediaRegion: json['mediaRegion'] as String,
      mediaPlacement: MediaPlacementModel.fromJson(
        json['mediaPlacement'] as Map<String, dynamic>,
      ),
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_MeetingModelToJson(_$_MeetingModel instance) =>
    <String, dynamic>{
      'meetingId': instance.meetingId,
      'externalMeetingId': instance.externalMeetingId,
      'mediaRegion': instance.mediaRegion,
      'mediaPlacement': instance.mediaPlacement,
    };

// ignore: non_constant_identifier_names
_$_MediaPlacementModel _$$_MediaPlacementModelFromJson(
  Map<String, dynamic> json,
) =>
    _$_MediaPlacementModel(
      audioHostUrl: json['audioHostUrl'] as String,
      audioFallbackUrl: json['audioFallbackUrl'] as String,
      signalingUrl: json['signalingUrl'] as String,
      turnControllerUrl: json['turnControllerUrl'] as String,
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_MediaPlacementModelToJson(
  _$_MediaPlacementModel instance,
) =>
    <String, dynamic>{
      'audioHostUrl': instance.audioHostUrl,
      'audioFallbackUrl': instance.audioFallbackUrl,
      'signalingUrl': instance.signalingUrl,
      'turnControllerUrl': instance.turnControllerUrl,
    };

// ignore: non_constant_identifier_names
_$_AttendeeInfoModel _$$_AttendeeInfoModelFromJson(Map<String, dynamic> json) =>
    _$_AttendeeInfoModel(
      externalUserId: json['externalUserId'] as String,
      attendeeId: json['attendeeId'] as String,
      joinToken: json['joinToken'] as String,
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_AttendeeInfoModelToJson(
  _$_AttendeeInfoModel instance,
) =>
    <String, dynamic>{
      'externalUserId': instance.externalUserId,
      'attendeeId': instance.attendeeId,
      'joinToken': instance.joinToken,
    };
