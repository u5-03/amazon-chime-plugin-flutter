import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';

final class JoinInfoParentAPIModel {
  final JoinInfoAPIModel joinInfo;

  JoinInfoParentAPIModel({required this.joinInfo});

  JoinInfoParentAPIModel copyWith({
    JoinInfoAPIModel? joinInfo,
  }) {
    return JoinInfoParentAPIModel(
      joinInfo: joinInfo ?? this.joinInfo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'JoinInfo': joinInfo.toJson(),
    };
  }

  factory JoinInfoParentAPIModel.fromJson(Map<String, dynamic> json) {
    return JoinInfoParentAPIModel(
      joinInfo: JoinInfoAPIModel.fromJson(json['JoinInfo']),
    );
  }
}

final class JoinInfoAPIModel {
  final MeetingWrapperModel meeting;
  final AttendeeWrapperModel attendee;

  JoinInfoAPIModel({required this.meeting, required this.attendee});

  JoinInfoAPIModel copyWith({
    MeetingWrapperModel? meeting,
    AttendeeWrapperModel? attendee,
  }) {
    return JoinInfoAPIModel(
      meeting: meeting ?? this.meeting,
      attendee: attendee ?? this.attendee,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Meeting': meeting.toJson(),
      'Attendee': attendee.toJson(),
    };
  }

  factory JoinInfoAPIModel.fromJson(Map<String, dynamic> json) {
    return JoinInfoAPIModel(
      meeting: MeetingWrapperModel.fromJson(json['Meeting']),
      attendee: AttendeeWrapperModel.fromJson(json['Attendee']),
    );
  }
}

final class MeetingWrapperModel {
  final MeetingAPIModel meeting;

  MeetingWrapperModel({required this.meeting});

  MeetingWrapperModel copyWith({
    MeetingAPIModel? meeting,
  }) {
    return MeetingWrapperModel(
      meeting: meeting ?? this.meeting,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Meeting': meeting.toJson(),
    };
  }

  factory MeetingWrapperModel.fromJson(Map<String, dynamic> json) {
    return MeetingWrapperModel(
      meeting: MeetingAPIModel.fromJson(json['Meeting']),
    );
  }
}

final class MeetingAPIModel {
  final String meetingId;
  final String externalMeetingId;
  final String mediaRegion;
  final MediaPlacementAPIModel mediaPlacement;
  final List<dynamic> tenantIds;
  final String meetingArn;
  final String? meetingHostId;
  final String? primaryMeetingId;

  MeetingAPIModel({
    required this.meetingId,
    required this.externalMeetingId,
    required this.mediaRegion,
    required this.mediaPlacement,
    required this.tenantIds,
    required this.meetingArn,
    this.meetingHostId,
    this.primaryMeetingId,
  });

  MeetingAPIModel copyWith({
    String? meetingId,
    String? externalMeetingId,
    String? mediaRegion,
    MediaPlacementAPIModel? mediaPlacement,
    List<dynamic>? tenantIds,
    String? meetingArn,
    String? meetingHostId,
    String? primaryMeetingId,
  }) {
    return MeetingAPIModel(
      meetingId: meetingId ?? this.meetingId,
      externalMeetingId: externalMeetingId ?? this.externalMeetingId,
      mediaRegion: mediaRegion ?? this.mediaRegion,
      mediaPlacement: mediaPlacement ?? this.mediaPlacement,
      tenantIds: tenantIds ?? this.tenantIds,
      meetingArn: meetingArn ?? this.meetingArn,
      meetingHostId: meetingHostId ?? this.meetingHostId,
      primaryMeetingId: primaryMeetingId ?? this.primaryMeetingId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MeetingId': meetingId,
      'ExternalMeetingId': externalMeetingId,
      'MediaRegion': mediaRegion,
      'MediaPlacement': mediaPlacement.toJson(),
      'TenantIds': tenantIds,
      'MeetingArn': meetingArn,
      'MeetingHostId': meetingHostId,
      'PrimaryMeetingId': primaryMeetingId,
    };
  }

  factory MeetingAPIModel.fromJson(Map<String, dynamic> json) {
    return MeetingAPIModel(
      meetingId: json['MeetingId'],
      externalMeetingId: json['ExternalMeetingId'],
      mediaRegion: json['MediaRegion'],
      mediaPlacement: MediaPlacementAPIModel.fromJson(json['MediaPlacement']),
      tenantIds: List<dynamic>.from(json['TenantIds']),
      meetingArn: json['MeetingArn'],
      meetingHostId: json['MeetingHostId'],
      primaryMeetingId: json['PrimaryMeetingId'],
    );
  }
}

final class MediaPlacementAPIModel {
  final String audioHostUrl;
  final String audioFallbackUrl;
  final String signalingUrl;
  final String turnControlUrl;
  final String screenDataUrl;
  final String screenViewingUrl;
  final String screenSharingUrl;
  final String eventIngestionUrl;

  MediaPlacementAPIModel({
    required this.audioHostUrl,
    required this.audioFallbackUrl,
    required this.signalingUrl,
    required this.turnControlUrl,
    required this.screenDataUrl,
    required this.screenViewingUrl,
    required this.screenSharingUrl,
    required this.eventIngestionUrl,
  });

  MediaPlacementAPIModel copyWith({
    String? audioHostUrl,
    String? audioFallbackUrl,
    String? signalingUrl,
    String? turnControlUrl,
    String? screenDataUrl,
    String? screenViewingUrl,
    String? screenSharingUrl,
    String? eventIngestionUrl,
  }) {
    return MediaPlacementAPIModel(
      audioHostUrl: audioHostUrl ?? this.audioHostUrl,
      audioFallbackUrl: audioFallbackUrl ?? this.audioFallbackUrl,
      signalingUrl: signalingUrl ?? this.signalingUrl,
      turnControlUrl: turnControlUrl ?? this.turnControlUrl,
      screenDataUrl: screenDataUrl ?? this.screenDataUrl,
      screenViewingUrl: screenViewingUrl ?? this.screenViewingUrl,
      screenSharingUrl: screenSharingUrl ?? this.screenSharingUrl,
      eventIngestionUrl: eventIngestionUrl ?? this.eventIngestionUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AudioHostUrl': audioHostUrl,
      'AudioFallbackUrl': audioFallbackUrl,
      'SignalingUrl': signalingUrl,
      'TurnControlUrl': turnControlUrl,
      'ScreenDataUrl': screenDataUrl,
      'ScreenViewingUrl': screenViewingUrl,
      'ScreenSharingUrl': screenSharingUrl,
      'EventIngestionUrl': eventIngestionUrl,
    };
  }

  factory MediaPlacementAPIModel.fromJson(Map<String, dynamic> json) {
    return MediaPlacementAPIModel(
      audioHostUrl: json['AudioHostUrl'],
      audioFallbackUrl: json['AudioFallbackUrl'],
      signalingUrl: json['SignalingUrl'],
      turnControlUrl: json['TurnControlUrl'],
      screenDataUrl: json['ScreenDataUrl'],
      screenViewingUrl: json['ScreenViewingUrl'],
      screenSharingUrl: json['ScreenSharingUrl'],
      eventIngestionUrl: json['EventIngestionUrl'],
    );
  }
}

final class AttendeeWrapperModel {
  final AttendeeAPIModel attendee;

  AttendeeWrapperModel({required this.attendee});

  AttendeeWrapperModel copyWith({
    AttendeeAPIModel? attendee,
  }) {
    return AttendeeWrapperModel(
      attendee: attendee ?? this.attendee,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Attendee': attendee.toJson(),
    };
  }

  factory AttendeeWrapperModel.fromJson(Map<String, dynamic> json) {
    return AttendeeWrapperModel(
      attendee: AttendeeAPIModel.fromJson(json['Attendee']),
    );
  }
}

final class AttendeeAPIModel {
  final String externalUserId;
  final String attendeeId;
  final String joinToken;
  final CapabilitiesAPIModel capabilities;

  AttendeeAPIModel({
    required this.externalUserId,
    required this.attendeeId,
    required this.joinToken,
    required this.capabilities,
  });

  AttendeeAPIModel copyWith({
    String? externalUserId,
    String? attendeeId,
    String? joinToken,
    CapabilitiesAPIModel? capabilities,
  }) {
    return AttendeeAPIModel(
      externalUserId: externalUserId ?? this.externalUserId,
      attendeeId: attendeeId ?? this.attendeeId,
      joinToken: joinToken ?? this.joinToken,
      capabilities: capabilities ?? this.capabilities,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ExternalUserId': externalUserId,
      'AttendeeId': attendeeId,
      'JoinToken': joinToken,
      'Capabilities': capabilities.toJson(),
    };
  }

  factory AttendeeAPIModel.fromJson(Map<String, dynamic> json) {
    return AttendeeAPIModel(
      externalUserId: json['ExternalUserId'],
      attendeeId: json['AttendeeId'],
      joinToken: json['JoinToken'],
      capabilities: CapabilitiesAPIModel.fromJson(json['Capabilities']),
    );
  }
}

final class CapabilitiesAPIModel {
  final String audio;
  final String video;
  final String content;

  CapabilitiesAPIModel({
    required this.audio,
    required this.video,
    required this.content,
  });

  CapabilitiesAPIModel copyWith({
    String? audio,
    String? video,
    String? content,
  }) {
    return CapabilitiesAPIModel(
      audio: audio ?? this.audio,
      video: video ?? this.video,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Audio': audio,
      'Video': video,
      'Content': content,
    };
  }

  factory CapabilitiesAPIModel.fromJson(Map<String, dynamic> json) {
    return CapabilitiesAPIModel(
      audio: json['Audio'],
      video: json['Video'],
      content: json['Content'],
    );
  }
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
