import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_info_model.freezed.dart';
part 'join_info_model.g.dart';

@freezed
class JoinInfoModel with _$JoinInfoModel {
  const factory JoinInfoModel({
    required MeetingModel meeting,
    required AttendeeInfoModel attendeeInfo,
  }) = _JoinInfoModel;

  factory JoinInfoModel.fromJson(Map<String, dynamic> json) =>
      _$JoinInfoModelFromJson(json);
}

@freezed
class MeetingModel with _$MeetingModel {
  const factory MeetingModel({
    required String meetingId,
    required String externalMeetingId,
    required String mediaRegion,
    required MediaPlacementModel mediaPlacement,
  }) = _MeetingModel;

  factory MeetingModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingModelFromJson(json);
}

@freezed
class MediaPlacementModel with _$MediaPlacementModel {
  const factory MediaPlacementModel({
    required String audioHostUrl,
    required String audioFallbackUrl,
    required String signalingUrl,
    required String turnControllerUrl,
  }) = _MediaPlacementModel;

  factory MediaPlacementModel.fromJson(Map<String, dynamic> json) =>
      _$MediaPlacementModelFromJson(json);
}

@freezed
class AttendeeInfoModel with _$AttendeeInfoModel {
  const factory AttendeeInfoModel({
    required String externalUserId,
    required String attendeeId,
    required String joinToken,
  }) = _AttendeeInfoModel;

  factory AttendeeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AttendeeInfoModelFromJson(json);
}

extension JoinInfoModelExt on JoinInfoModel {
  JoinParameter get asJoinParameter => JoinParameter(
        meetingId: meeting.meetingId,
        externalMeetingId: meeting.externalMeetingId,
        mediaRegion: meeting.mediaRegion,
        audioHostUrl: meeting.mediaPlacement.audioHostUrl,
        audioFallbackUrl: meeting.mediaPlacement.audioFallbackUrl,
        signalingUrl: meeting.mediaPlacement.signalingUrl,
        turnControlUrl: meeting.mediaPlacement.turnControllerUrl,
        externalUserId: attendeeInfo.externalUserId,
        attendeeId: attendeeInfo.attendeeId,
        joinToken: attendeeInfo.joinToken,
      );
}
