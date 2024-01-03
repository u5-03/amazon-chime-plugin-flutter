import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';

class JoinInfoModel {
  final MeetingModel meeting;
  final AttendeeInfoModel attendeeInfo;

  JoinInfoModel({required this.meeting, required this.attendeeInfo});

  JoinInfoModel copyWith({
    MeetingModel? meeting,
    AttendeeInfoModel? attendeeInfo,
  }) {
    return JoinInfoModel(
      meeting: meeting ?? this.meeting,
      attendeeInfo: attendeeInfo ?? this.attendeeInfo,
    );
  }

  factory JoinInfoModel.fromJson(Map<String, dynamic> json) {
    return JoinInfoModel(
      meeting: MeetingModel.fromJson(json['meeting']),
      attendeeInfo: AttendeeInfoModel.fromJson(json['attendeeInfo']),
    );
  }

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

final class MeetingModel {
  final String meetingId;
  final String externalMeetingId;
  final String mediaRegion;
  final MediaPlacementModel mediaPlacement;

  MeetingModel({
    required this.meetingId,
    required this.externalMeetingId,
    required this.mediaRegion,
    required this.mediaPlacement,
  });

  MeetingModel copyWith({
    String? meetingId,
    String? externalMeetingId,
    String? mediaRegion,
    MediaPlacementModel? mediaPlacement,
  }) {
    return MeetingModel(
      meetingId: meetingId ?? this.meetingId,
      externalMeetingId: externalMeetingId ?? this.externalMeetingId,
      mediaRegion: mediaRegion ?? this.mediaRegion,
      mediaPlacement: mediaPlacement ?? this.mediaPlacement,
    );
  }

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    return MeetingModel(
      meetingId: json['meetingId'],
      externalMeetingId: json['externalMeetingId'],
      mediaRegion: json['mediaRegion'],
      mediaPlacement: MediaPlacementModel.fromJson(json['mediaPlacement']),
    );
  }
}

final class MediaPlacementModel {
  final String audioHostUrl;
  final String audioFallbackUrl;
  final String signalingUrl;
  final String turnControllerUrl;

  MediaPlacementModel({
    required this.audioHostUrl,
    required this.audioFallbackUrl,
    required this.signalingUrl,
    required this.turnControllerUrl,
  });

  MediaPlacementModel copyWith({
    String? audioHostUrl,
    String? audioFallbackUrl,
    String? signalingUrl,
    String? turnControllerUrl,
  }) {
    return MediaPlacementModel(
      audioHostUrl: audioHostUrl ?? this.audioHostUrl,
      audioFallbackUrl: audioFallbackUrl ?? this.audioFallbackUrl,
      signalingUrl: signalingUrl ?? this.signalingUrl,
      turnControllerUrl: turnControllerUrl ?? this.turnControllerUrl,
    );
  }

  factory MediaPlacementModel.fromJson(Map<String, dynamic> json) {
    return MediaPlacementModel(
      audioHostUrl: json['audioHostUrl'],
      audioFallbackUrl: json['audioFallbackUrl'],
      signalingUrl: json['signalingUrl'],
      turnControllerUrl: json['turnControllerUrl'],
    );
  }
}

final class AttendeeInfoModel {
  final String externalUserId;
  final String attendeeId;
  final String joinToken;

  AttendeeInfoModel({
    required this.externalUserId,
    required this.attendeeId,
    required this.joinToken,
  });

  AttendeeInfoModel copyWith({
    String? externalUserId,
    String? attendeeId,
    String? joinToken,
  }) {
    return AttendeeInfoModel(
      externalUserId: externalUserId ?? this.externalUserId,
      attendeeId: attendeeId ?? this.attendeeId,
      joinToken: joinToken ?? this.joinToken,
    );
  }

  factory AttendeeInfoModel.fromJson(Map<String, dynamic> json) {
    return AttendeeInfoModel(
      externalUserId: json['externalUserId'],
      attendeeId: json['attendeeId'],
      joinToken: json['joinToken'],
    );
  }
}
