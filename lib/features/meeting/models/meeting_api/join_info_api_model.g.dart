// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_info_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JoinInfoParentAPIModelImpl _$$JoinInfoParentAPIModelImplFromJson(
        Map<String, dynamic> json) =>
    _$JoinInfoParentAPIModelImpl(
      joinInfo:
          JoinInfoAPIModel.fromJson(json['JoinInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$JoinInfoParentAPIModelImplToJson(
        _$JoinInfoParentAPIModelImpl instance) =>
    <String, dynamic>{
      'JoinInfo': instance.joinInfo,
    };

_$JoinInfoAPIModelImpl _$$JoinInfoAPIModelImplFromJson(
        Map<String, dynamic> json) =>
    _$JoinInfoAPIModelImpl(
      meeting:
          MeetingWrapperModel.fromJson(json['Meeting'] as Map<String, dynamic>),
      attendee: AttendeeWrapperModel.fromJson(
          json['Attendee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$JoinInfoAPIModelImplToJson(
        _$JoinInfoAPIModelImpl instance) =>
    <String, dynamic>{
      'Meeting': instance.meeting,
      'Attendee': instance.attendee,
    };

_$MeetingWrapperModelImpl _$$MeetingWrapperModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MeetingWrapperModelImpl(
      meeting:
          MeetingAPIModel.fromJson(json['Meeting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MeetingWrapperModelImplToJson(
        _$MeetingWrapperModelImpl instance) =>
    <String, dynamic>{
      'Meeting': instance.meeting,
    };

_$MeetingAPIModelImpl _$$MeetingAPIModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MeetingAPIModelImpl(
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

Map<String, dynamic> _$$MeetingAPIModelImplToJson(
        _$MeetingAPIModelImpl instance) =>
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

_$MediaPlacementAPIModelImpl _$$MediaPlacementAPIModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MediaPlacementAPIModelImpl(
      audioHostUrl: json['AudioHostUrl'] as String,
      audioFallbackUrl: json['AudioFallbackUrl'] as String,
      signalingUrl: json['SignalingUrl'] as String,
      turnControlUrl: json['TurnControlUrl'] as String,
      screenDataUrl: json['ScreenDataUrl'] as String,
      screenViewingUrl: json['ScreenViewingUrl'] as String,
      screenSharingUrl: json['ScreenSharingUrl'] as String,
      eventIngestionUrl: json['EventIngestionUrl'] as String,
    );

Map<String, dynamic> _$$MediaPlacementAPIModelImplToJson(
        _$MediaPlacementAPIModelImpl instance) =>
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

_$AttendeeWrapperModelImpl _$$AttendeeWrapperModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendeeWrapperModelImpl(
      attendee:
          AttendeeAPIModel.fromJson(json['Attendee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AttendeeWrapperModelImplToJson(
        _$AttendeeWrapperModelImpl instance) =>
    <String, dynamic>{
      'Attendee': instance.attendee,
    };

_$AttendeeAPIModelImpl _$$AttendeeAPIModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendeeAPIModelImpl(
      externalUserId: json['ExternalUserId'] as String,
      attendeeId: json['AttendeeId'] as String,
      joinToken: json['JoinToken'] as String,
      capabilities: CapabilitiesAPIModel.fromJson(
          json['Capabilities'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AttendeeAPIModelImplToJson(
        _$AttendeeAPIModelImpl instance) =>
    <String, dynamic>{
      'ExternalUserId': instance.externalUserId,
      'AttendeeId': instance.attendeeId,
      'JoinToken': instance.joinToken,
      'Capabilities': instance.capabilities,
    };

_$CapabilitiesAPIModelImpl _$$CapabilitiesAPIModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CapabilitiesAPIModelImpl(
      audio: json['Audio'] as String,
      video: json['Video'] as String,
      content: json['Content'] as String,
    );

Map<String, dynamic> _$$CapabilitiesAPIModelImplToJson(
        _$CapabilitiesAPIModelImpl instance) =>
    <String, dynamic>{
      'Audio': instance.audio,
      'Video': instance.video,
      'Content': instance.content,
    };
