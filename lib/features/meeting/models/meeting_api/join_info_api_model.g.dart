// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_info_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JoinInfoParentAPIModel _$$_JoinInfoParentAPIModelFromJson(
        Map<String, dynamic> json) =>
    _$_JoinInfoParentAPIModel(
      joinInfo:
          JoinInfoAPIModel.fromJson(json['JoinInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_JoinInfoParentAPIModelToJson(
        _$_JoinInfoParentAPIModel instance) =>
    <String, dynamic>{
      'JoinInfo': instance.joinInfo,
    };

_$_JoinInfoAPIModel _$$_JoinInfoAPIModelFromJson(Map<String, dynamic> json) =>
    _$_JoinInfoAPIModel(
      meeting:
          MeetingWrapperModel.fromJson(json['Meeting'] as Map<String, dynamic>),
      attendee: AttendeeWrapperModel.fromJson(
          json['Attendee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_JoinInfoAPIModelToJson(_$_JoinInfoAPIModel instance) =>
    <String, dynamic>{
      'Meeting': instance.meeting,
      'Attendee': instance.attendee,
    };

_$_MeetingWrapperModel _$$_MeetingWrapperModelFromJson(
        Map<String, dynamic> json) =>
    _$_MeetingWrapperModel(
      meeting:
          MeetingAPIModel.fromJson(json['Meeting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MeetingWrapperModelToJson(
        _$_MeetingWrapperModel instance) =>
    <String, dynamic>{
      'Meeting': instance.meeting,
    };

_$_MeetingAPIModel _$$_MeetingAPIModelFromJson(Map<String, dynamic> json) =>
    _$_MeetingAPIModel(
      meetingId: json['MeetingId'] as String,
      externalMeetingId: json['ExternalMeetingId'] as String,
      mediaRegion: json['MediaRegion'] as String,
      mediaPlacement: MediaPlacementAPIModel.fromJson(
          json['MediaPlacement'] as Map<String, dynamic>),
      tenantIds: json['TenantIds'] as List<dynamic>,
      meetingArn: json['MeetingArn'] as String,
      meetingHostId: json['MeetingHostId'] as String?,
      primaryMeetingId: json['PrimaryMeetingId'] as String?,
    );

Map<String, dynamic> _$$_MeetingAPIModelToJson(_$_MeetingAPIModel instance) =>
    <String, dynamic>{
      'MeetingId': instance.meetingId,
      'ExternalMeetingId': instance.externalMeetingId,
      'MediaRegion': instance.mediaRegion,
      'MediaPlacement': instance.mediaPlacement,
      'TenantIds': instance.tenantIds,
      'MeetingArn': instance.meetingArn,
      'MeetingHostId': instance.meetingHostId,
      'PrimaryMeetingId': instance.primaryMeetingId,
    };

_$_MediaPlacementAPIModel _$$_MediaPlacementAPIModelFromJson(
        Map<String, dynamic> json) =>
    _$_MediaPlacementAPIModel(
      audioHostUrl: json['AudioHostUrl'] as String,
      audioFallbackUrl: json['AudioFallbackUrl'] as String,
      signalingUrl: json['SignalingUrl'] as String,
      turnControlUrl: json['TurnControlUrl'] as String,
      screenDataUrl: json['ScreenDataUrl'] as String,
      screenViewingUrl: json['ScreenViewingUrl'] as String,
      screenSharingUrl: json['ScreenSharingUrl'] as String,
      eventIngestionUrl: json['EventIngestionUrl'] as String,
    );

Map<String, dynamic> _$$_MediaPlacementAPIModelToJson(
        _$_MediaPlacementAPIModel instance) =>
    <String, dynamic>{
      'AudioHostUrl': instance.audioHostUrl,
      'AudioFallbackUrl': instance.audioFallbackUrl,
      'SignalingUrl': instance.signalingUrl,
      'TurnControlUrl': instance.turnControlUrl,
      'ScreenDataUrl': instance.screenDataUrl,
      'ScreenViewingUrl': instance.screenViewingUrl,
      'ScreenSharingUrl': instance.screenSharingUrl,
      'EventIngestionUrl': instance.eventIngestionUrl,
    };

_$_AttendeeWrapperModel _$$_AttendeeWrapperModelFromJson(
        Map<String, dynamic> json) =>
    _$_AttendeeWrapperModel(
      attendee:
          AttendeeAPIModel.fromJson(json['Attendee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AttendeeWrapperModelToJson(
        _$_AttendeeWrapperModel instance) =>
    <String, dynamic>{
      'Attendee': instance.attendee,
    };

_$_AttendeeAPIModel _$$_AttendeeAPIModelFromJson(Map<String, dynamic> json) =>
    _$_AttendeeAPIModel(
      externalUserId: json['ExternalUserId'] as String,
      attendeeId: json['AttendeeId'] as String,
      joinToken: json['JoinToken'] as String,
      capabilities: CapabilitiesAPIModel.fromJson(
          json['Capabilities'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AttendeeAPIModelToJson(_$_AttendeeAPIModel instance) =>
    <String, dynamic>{
      'ExternalUserId': instance.externalUserId,
      'AttendeeId': instance.attendeeId,
      'JoinToken': instance.joinToken,
      'Capabilities': instance.capabilities,
    };

_$_CapabilitiesAPIModel _$$_CapabilitiesAPIModelFromJson(
        Map<String, dynamic> json) =>
    _$_CapabilitiesAPIModel(
      audio: json['Audio'] as String,
      video: json['Video'] as String,
      content: json['Content'] as String,
    );

Map<String, dynamic> _$$_CapabilitiesAPIModelToJson(
        _$_CapabilitiesAPIModel instance) =>
    <String, dynamic>{
      'Audio': instance.audio,
      'Video': instance.video,
      'Content': instance.content,
    };
