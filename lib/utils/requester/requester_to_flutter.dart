import 'package:amazon_chime_plugin/features/meeting/data/meeting_repository.dart';
import 'package:amazon_chime_plugin/features/meeting/models/participant/participant_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/video_tile_model/video_tile_model.dart';
import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/utils/logger.dart';

class RequesterToFlutterImp implements RequesterToFlutter {
  RequesterToFlutterImp(this.meetingRepository);
  final MeetingRepository meetingRepository;

  @override
  void audioSessionDidDrop() {
    // TODO: implement audioSessionDidDrop
    throw UnimplementedError();
  }

  @override
  void audioSessionDidStop() {
    meetingRepository.resetMeetingValues();
  }

  @override
  void joined(ParticipantInfo info) {
    final attendeeIdToAdd = info.attendeeId;
    final attendeeIdArray = attendeeIdToAdd.split('#');
    final contentParticipantId = meetingRepository.contentParticipantId;
    final localParticipantId = meetingRepository.localParticipantId;
    final remoteParticipantId = meetingRepository.remoteParticipantId;
    final participants = meetingRepository.participants;
    final isAttendeeContent = attendeeIdArray.length == 2;
    final participant = ParticipantModel(
      externalUserId: info.externalUserId,
      participantId: info.attendeeId,
    );
    if (isAttendeeContent) {
      logger.info('Content detected');
      meetingRepository.contentParticipantId = attendeeIdToAdd;
      if (contentParticipantId != null) {
        participants[contentParticipantId] = participant;
        logger.info('Content added to the meeting');
      }
    }

    if (attendeeIdToAdd != localParticipantId) {
      meetingRepository.remoteParticipantId = attendeeIdToAdd;
      if (remoteParticipantId != null) {
        meetingRepository.participants[remoteParticipantId] = participant;
        logger.info(
          '${participant.formattedExternalUserId} has joined the meeting.',
        );
      } else {
        logger.severe('Remote participant id is null');
      }
    }
  }

  @override
  void dropped(ParticipantInfo info) {
    _attendeeDidLeave(info, didDrop: true);
  }

  @override
  void left(ParticipantInfo info) {
    _attendeeDidLeave(info, didDrop: false);
  }

  @override
  void muted(ParticipantInfo info) {
    _changeMuteStatus(info, mute: true);
  }

  @override
  void unmuted(ParticipantInfo info) {
    _changeMuteStatus(info, mute: false);
  }

  @override
  void videoTileAdded(TileInfo info) {
    final attendeeId = info.attendeeId;
    final videoTile = VideoTileModel.fromPigeonModel(info);
    final participants = meetingRepository.participants;
    final participant = participants[attendeeId];
    if (participant == null) {
      print('Participant not found for attendeeId: $attendeeId');
      return;
    }
    meetingRepository.updateParticipant(
      participantId: attendeeId,
      participant: participant.copyWith(
        isVideoOn: true,
        videoTile: videoTile,
      ),
    );
    if (videoTile.isContentShare) {
      meetingRepository.isReceivingScreenShare = true;
    }
    print('participants: $participants');
    return;
  }

  @override
  void videoTileRemoved(TileInfo info) {
    final participantId = info.attendeeId;
    final videoTile = VideoTileModel.fromPigeonModel(info);
    final participants = meetingRepository.participants;

    final String targetParticipantId;
    final bool updatedIsVideoOn;

    if (videoTile.isContentShare) {
      targetParticipantId = meetingRepository.contentParticipantId ?? '';
      updatedIsVideoOn = participants[targetParticipantId]?.isVideoOn ?? false;

      meetingRepository.isReceivingScreenShare = false;
    } else {
      targetParticipantId = participantId;
      updatedIsVideoOn = false;
    }

    final participant = participants[targetParticipantId];
    if (participant == null) {
      print('Participant not found for attendeeId: $participantId');
      return;
    }
    meetingRepository.participants[targetParticipantId] = participant.copyWith(
      muteStatus: participant.muteStatus,
      isVideoOn: updatedIsVideoOn,
    );
  }
}

extension RequesterToFlutterImpExt on RequesterToFlutterImp {
  void _attendeeDidLeave(
    ParticipantInfo info, {
    required bool didDrop,
  }) {
    final participant = ParticipantModel.fromPigeonModel(info);
    final participantIdToDelete = participant.participantId;
    this.meetingRepository.participants.remove(participantIdToDelete);
    if (didDrop) {
      logger.info(
        '${participant.formattedExternalUserId} has dropped from the meeting',
      );
    } else {
      logger.info(
        '${participant.formattedExternalUserId} has left the meeting',
      );
    }
  }

  void _changeMuteStatus(ParticipantInfo info, {required bool mute}) {
    final participants = this.meetingRepository.participants;
    final participantToChangeStatus = participants[info.attendeeId];
    final participant = ParticipantModel(
      externalUserId: info.externalUserId,
      participantId: info.attendeeId,
      muteStatus: participantToChangeStatus?.muteStatus ?? false,
      isVideoOn: participantToChangeStatus?.isVideoOn ?? false,
    );
    participants[info.attendeeId] = participant;
    if (mute) {
      logger.info(
        '${participant.formattedExternalUserId} has been muted',
      );
    } else {
      logger.info(
        '${participant.formattedExternalUserId} has been unmuted',
      );
    }
  }
}
