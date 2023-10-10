import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_info_api_model.freezed.dart';
part 'join_info_api_model.g.dart';

@freezed
class JoinInfoParentAPIModel with _$JoinInfoParentAPIModel {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory JoinInfoParentAPIModel({
    required JoinInfoAPIModel joinInfo,
  }) = _JoinInfoParentAPIModel;

  factory JoinInfoParentAPIModel.fromJson(Map<String, dynamic> json) =>
      _$JoinInfoParentAPIModelFromJson(json);
}

@freezed
class JoinInfoAPIModel with _$JoinInfoAPIModel {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory JoinInfoAPIModel({
    required MeetingWrapperModel meeting,
    required AttendeeWrapperModel attendee,
  }) = _JoinInfoAPIModel;

  factory JoinInfoAPIModel.fromJson(Map<String, dynamic> json) =>
      _$JoinInfoAPIModelFromJson(json);
}

@freezed
class MeetingWrapperModel with _$MeetingWrapperModel {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory MeetingWrapperModel({
    required MeetingAPIModel meeting,
  }) = _MeetingWrapperModel;

  factory MeetingWrapperModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingWrapperModelFromJson(json);
}

@freezed
class MeetingAPIModel with _$MeetingAPIModel {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory MeetingAPIModel({
    required String meetingId,
    required String externalMeetingId,
    required String mediaRegion,
    required MediaPlacementAPIModel mediaPlacement,
    required List<dynamic> tenantIds,
    required String meetingArn,
    String? meetingHostId,
    String? primaryMeetingId,
  }) = _MeetingAPIModel;

  factory MeetingAPIModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingAPIModelFromJson(json);
}

@freezed
class MediaPlacementAPIModel with _$MediaPlacementAPIModel {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory MediaPlacementAPIModel({
    required String audioHostUrl,
    required String audioFallbackUrl,
    required String signalingUrl,
    required String turnControlUrl,
    required String screenDataUrl,
    required String screenViewingUrl,
    required String screenSharingUrl,
    required String eventIngestionUrl,
  }) = _MediaPlacementAPIModel;

  factory MediaPlacementAPIModel.fromJson(Map<String, dynamic> json) =>
      _$MediaPlacementAPIModelFromJson(json);
}

@freezed
class AttendeeWrapperModel with _$AttendeeWrapperModel {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory AttendeeWrapperModel({
    required AttendeeAPIModel attendee,
  }) = _AttendeeWrapperModel;

  factory AttendeeWrapperModel.fromJson(Map<String, dynamic> json) =>
      _$AttendeeWrapperModelFromJson(json);
}

@freezed
class AttendeeAPIModel with _$AttendeeAPIModel {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory AttendeeAPIModel({
    required String externalUserId,
    required String attendeeId,
    required String joinToken,
    required CapabilitiesAPIModel capabilities,
  }) = _AttendeeAPIModel;

  factory AttendeeAPIModel.fromJson(Map<String, dynamic> json) =>
      _$AttendeeAPIModelFromJson(json);
}

@freezed
class CapabilitiesAPIModel with _$CapabilitiesAPIModel {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory CapabilitiesAPIModel({
    required String audio,
    required String video,
    required String content,
  }) = _CapabilitiesAPIModel;

  factory CapabilitiesAPIModel.fromJson(Map<String, dynamic> json) =>
      _$CapabilitiesAPIModelFromJson(json);
}

extension JoinInfoAPIModelExt on JoinInfoAPIModel {
  JoinParameter get asJoinParameter => JoinParameter(
        meetingId: meeting.meeting.meetingId,
        externalMeetingId: meeting.meeting.externalMeetingId,
        mediaRegion: meeting.meeting.mediaRegion,
        audioHostUrl: meeting.meeting.mediaPlacement.audioHostUrl,
        audioFallbackUrl: meeting.meeting.mediaPlacement.audioFallbackUrl,
        signalingUrl: meeting.meeting.mediaPlacement.signalingUrl,
        turnControlUrl: meeting.meeting.mediaPlacement.turnControlUrl,
        externalUserId: attendee.attendee.externalUserId,
        attendeeId: attendee.attendee.attendeeId,
        joinToken: attendee.attendee.joinToken,
      );

  JoinInfoModel get asJoinInfoModel => JoinInfoModel(
        meeting: MeetingModel(
          meetingId: meeting.meeting.meetingId,
          externalMeetingId: meeting.meeting.externalMeetingId,
          mediaRegion: meeting.meeting.mediaRegion,
          mediaPlacement: MediaPlacementModel(
            audioFallbackUrl: meeting.meeting.mediaPlacement.audioFallbackUrl,
            audioHostUrl: meeting.meeting.mediaPlacement.audioHostUrl,
            turnControllerUrl: meeting.meeting.mediaPlacement.turnControlUrl,
            signalingUrl: meeting.meeting.mediaPlacement.signalingUrl,
          ),
        ),
        attendeeInfo: AttendeeInfoModel(
          externalUserId: attendee.attendee.externalUserId,
          attendeeId: attendee.attendee.attendeeId,
          joinToken: attendee.attendee.joinToken,
        ),
      );
}
