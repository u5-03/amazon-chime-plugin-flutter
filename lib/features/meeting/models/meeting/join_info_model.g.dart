// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JoinInfoModelImpl _$$JoinInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$JoinInfoModelImpl(
      meeting: MeetingModel.fromJson(json['meeting'] as Map<String, dynamic>),
      attendeeInfo: AttendeeInfoModel.fromJson(
          json['attendeeInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$JoinInfoModelImplToJson(_$JoinInfoModelImpl instance) =>
    <String, dynamic>{
      'meeting': instance.meeting,
      'attendeeInfo': instance.attendeeInfo,
    };

_$MeetingModelImpl _$$MeetingModelImplFromJson(Map<String, dynamic> json) =>
    _$MeetingModelImpl(
      meetingId: json['meetingId'] as String,
      externalMeetingId: json['externalMeetingId'] as String,
      mediaRegion: json['mediaRegion'] as String,
      mediaPlacement: MediaPlacementModel.fromJson(
          json['mediaPlacement'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MeetingModelImplToJson(_$MeetingModelImpl instance) =>
    <String, dynamic>{
      'meetingId': instance.meetingId,
      'externalMeetingId': instance.externalMeetingId,
      'mediaRegion': instance.mediaRegion,
      'mediaPlacement': instance.mediaPlacement,
    };

_$MediaPlacementModelImpl _$$MediaPlacementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MediaPlacementModelImpl(
      audioHostUrl: json['audioHostUrl'] as String,
      audioFallbackUrl: json['audioFallbackUrl'] as String,
      signalingUrl: json['signalingUrl'] as String,
      turnControllerUrl: json['turnControllerUrl'] as String,
    );

Map<String, dynamic> _$$MediaPlacementModelImplToJson(
        _$MediaPlacementModelImpl instance) =>
    <String, dynamic>{
      'audioHostUrl': instance.audioHostUrl,
      'audioFallbackUrl': instance.audioFallbackUrl,
      'signalingUrl': instance.signalingUrl,
      'turnControllerUrl': instance.turnControllerUrl,
    };

_$AttendeeInfoModelImpl _$$AttendeeInfoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendeeInfoModelImpl(
      externalUserId: json['externalUserId'] as String,
      attendeeId: json['attendeeId'] as String,
      joinToken: json['joinToken'] as String,
    );

Map<String, dynamic> _$$AttendeeInfoModelImplToJson(
        _$AttendeeInfoModelImpl instance) =>
    <String, dynamic>{
      'externalUserId': instance.externalUserId,
      'attendeeId': instance.attendeeId,
      'joinToken': instance.joinToken,
    };
