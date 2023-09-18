import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/participant/participant_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/video_tile_model/video_tile_model.dart';
import 'package:amazon_chime_plugin/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_data.g.dart';

@riverpod
final class MeetingData extends _$MeetingData {
  String? meetingId;

  JoinInfoModel? meetingData;

  String? localParticipantId;
  String? remoteParticipantId;
  String? contentParticipantId;
  // AttendeeId is the key
  Map<String, ParticipantModel> participants = {};

  String? selectedAudioDevice;
  List<String> deviceList = [];
  Orientation orientation = Orientation.portrait;

  // AttendeeId is the key
  // Map<String, Attendee> currAttendees = {};

  bool isReceivingScreenShare = false;
  bool isMeetingActive = false;

  @override
  MeetingData build() {
    return this;
  }

  void updateParticipant({
    required String participantId,
    String? externalUserId,
    bool? muteStatus,
    bool? isVideoOn,
    VideoTileModel? videoTile,
  }) {
    final participant = participants[participantId];
    if (participant == null) {
      logger.severe('Participant not found');
      participants[participantId] = ParticipantModel(
        participantId: participantId,
        externalUserId: externalUserId ?? '',
        muteStatus: muteStatus ?? false,
        isVideoOn: isVideoOn ?? false,
        videoTile: videoTile ?? null,
      );
      print('updateParticipant: ${participants[participantId]}');
    } else {
      participants[participantId] = participant.copyWith(
        participantId: participantId,
        externalUserId: externalUserId ?? participant.externalUserId,
        muteStatus: muteStatus ?? participant.muteStatus,
        isVideoOn: isVideoOn ?? participant.isVideoOn,
        videoTile: videoTile ?? participant.videoTile,
      );
      print('updateParticipant: ${participants[participantId]}');
    }
  }

  void clearParticipant() {
    participants = {};
  }

  void resetMeetingValues() {
    meetingId = null;
    meetingData = null;
    localParticipantId = null;
    remoteParticipantId = null;
    contentParticipantId = null;
    selectedAudioDevice = null;
    deviceList = [];
    clearParticipant();
    isReceivingScreenShare = false;
    isMeetingActive = false;
    logger.info('Meeting values reset');
  }
}
