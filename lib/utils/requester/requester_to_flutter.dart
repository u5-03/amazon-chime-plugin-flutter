import 'package:amazon_chime_plugin/features/meeting/data/meeting_controller.dart';
import 'package:amazon_chime_plugin/features/meeting/models/participant/participant_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/video_tile_model/video_tile_model.dart';
import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequesterToFlutterImp implements RequesterToFlutter {
  RequesterToFlutterImp(this.meetingController);
  final MeetingController meetingController;
  static WidgetRef? ref;

  @override
  void audioSessionDidDrop() {
    // TODO: implement audioSessionDidDrop
    throw UnimplementedError();
  }

  @override
  void audioSessionDidStop() {
    meetingController.resetMeetingValues();
  }

  @override
  void joined(ParticipantInfo info) {
    final attendeeIdToAdd = info.attendeeId;
    final attendeeIdArray = attendeeIdToAdd.split('#');
    final isAttendeeContent = attendeeIdArray.length == 2;
    if (isAttendeeContent) {
      logger.info('Content detected');
      // meetingController
      RequesterToFlutterImp.ref!.read(meetingControllerProvider.notifier)
        ..updateContentParticipantId(attendeeIdToAdd)
        ..updateParticipant(
          participantId: info.attendeeId,
          externalUserId: info.externalUserId,
        );
      logger.info('Content added to the meeting');
    }

    logger.info('Remote participant detected');
    RequesterToFlutterImp.ref!
        .read(meetingControllerProvider.notifier)
        .updateRemoteParticipantId(attendeeIdToAdd);
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
    RequesterToFlutterImp.ref!
        .read(meetingControllerProvider.notifier)
        .updateParticipant(
          participantId: attendeeId,
          isVideoOn: true,
          videoTile: videoTile,
        );
    if (videoTile.isContentShare) {
      RequesterToFlutterImp.ref!
          .read(meetingControllerProvider.notifier)
          .isReceivingScreenShare = true;
    }
  }

  @override
  void videoTileRemoved(TileInfo info) {
    final participantId = info.attendeeId;
    final videoTile = VideoTileModel.fromPigeonModel(info);

    if (videoTile.isContentShare) {
      final targetParticipantId =
          meetingController.state.contentParticipantId ?? '';
      meetingController
        ..toggleVideoStatus(
          participantId: targetParticipantId,
        )
        ..isReceivingScreenShare = false;
    } else {
      meetingController.switchVideoStatus(
        participantId: participantId,
        isVideoOn: false,
      );
    }
  }
}

extension RequesterToFlutterImpExt on RequesterToFlutterImp {
  void _attendeeDidLeave(
    ParticipantInfo info, {
    required bool didDrop,
  }) {
    final participant = ParticipantModel.fromPigeonModel(info);
    final participantIdToDelete = participant.participantId;
    meetingController.removeParticipant(participantIdToDelete);
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
    meetingController.updateParticipant(
      participantId: info.attendeeId,
      muteStatus: mute,
    );
    if (mute) {
      logger.info(
        '${info.attendeeId} has been muted',
      );
    } else {
      logger.info(
        '${info.attendeeId} has been unmuted',
      );
    }
  }
}
