import 'package:amazon_chime_plugin/src/controllers/value/meeting_value.dart';
import 'package:amazon_chime_plugin/src/extensions/attendee_info.dart';
import 'package:amazon_chime_plugin/src/models/attendee_model.dart';
import 'package:amazon_chime_plugin/src/models/join_info_model.dart';
import 'package:amazon_chime_plugin/src/models/video_tile_model.dart';
import 'package:amazon_chime_plugin/src/native/native_interface.dart';
import 'package:amazon_chime_plugin/src/native/requester_to_flutter/requester_to_flutter_callbacks.dart';
import 'package:amazon_chime_plugin/src/native/requester_to_flutter/requester_to_flutter_impl.dart';
import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';
import 'package:flutter/material.dart';

final class MeetingNotifier extends ValueNotifier<MeetingValue> {
  MeetingNotifier({
    required this.native,
  }) : super(MeetingValue.empty()) {
    RequesterToFlutter.setup(
      RequesterToFlutterImp(
        callbacks: RequesterToFlutterCallbacks(
          audioSessionDidStop: () {
            callbacks.audioSessionDidStop?.call();
            resetMeetingValues();
          },
          audioSessionDidDrop: () {
            callbacks.audioSessionDidDrop?.call();
          },
          connectionDidRecover: () {
            callbacks.connectionDidRecover?.call();
          },
          connectionDidBecomePoor: () {
            callbacks.connectionDidBecomePoor?.call();
          },
          audioSessionDidCancelReconnect: () {
            callbacks.audioSessionDidCancelReconnect?.call();
          },
          videoSessionDidStartConnecting: () {
            callbacks.videoSessionDidStartConnecting?.call();
          },
          audioSessionDidStartConnecting: (isReconnecting) {
            callbacks.audioSessionDidStartConnecting?.call(isReconnecting);
          },
          audioSessionDidStart: (isReconnecting) {
            callbacks.audioSessionDidStart?.call(isReconnecting);
          },
          cameraSendAvailabilityDidChange: (isAvailable) {
            callbacks.cameraSendAvailabilityDidChange?.call(isAvailable);
          },
          remoteVideoSourcesDidBecomeAvailable: (sources) {
            callbacks.remoteVideoSourcesDidBecomeAvailable?.call(sources);
          },
          remoteVideoSourcesDidBecomeUnavailable: (sources) {
            callbacks.remoteVideoSourcesDidBecomeUnavailable?.call(sources);
          },
          joined: (info) => didJoinParticipant(info),
          dropped: (info) => _attendeeDidLeave(info, didDrop: true),
          left: (info) => _attendeeDidLeave(info, didDrop: false),
          muted: (info) => _changedMuteStatus(info, mute: true),
          unmuted: (info) => _changedMuteStatus(info, mute: false),
          videoTileAdded: (info) {
            final attendeeId = info.attendeeId;
            final videoTile = VideoTileModel.fromPigeonModel(info);
            updateAttendee(
                attendeeId: attendeeId, videoTile: videoTile, isVideoOn: true);
            if (videoTile.isContentShare) {
              value = value.copyWith(isReceivingScreenShare: true);
            }
          },
          videoTileRemoved: (info) {
            final videoTile = VideoTileModel.fromPigeonModel(info);
            updateAttendee(
              attendeeId: info.attendeeId,
              isVideoOn: false,
            );
            if (videoTile.isContentShare) {
              value = value.copyWith(isReceivingScreenShare: false);
            }
          },
          didChangedAudioDevice: (deviceLabel) {
            updateAudioDeviceLabel(deviceLabel);
            callbacks.didChangedAudioDevice?.call(deviceLabel);
          },
        ),
      ),
    );
  }

  final NativeInterface native;
  RequesterToFlutterCallbacks callbacks = RequesterToFlutterCallbacks();

  void updateContentAttendeeId(String contentAttendeeId) {
    value = value.copyWith(contentAttendeeId: contentAttendeeId);
  }

  void updateRemoteAttendeeId(String remoteAttendeeId) {
    value = value.copyWith(remoteAttendeeId: remoteAttendeeId);
  }

  void updateLocalVideoEnabled({required bool isLocalVideoEnabled}) {
    value = value.copyWith(isLocalVideoEnabled: isLocalVideoEnabled);
  }

  void addAttendee({required AttendeeModel attendee}) {
    final attendees = {...value.attendees};
    attendees[attendee.attendeeId] = attendee;
    value = value.copyWith(attendees: attendees);
  }

  void updateAttendee({
    required String attendeeId,
    String? externalUserId,
    bool? muteStatus,
    bool? isVideoOn,
    VideoTileModel? videoTile,
  }) {
    final attendees = {...value.attendees};
    final attendee = attendees[attendeeId];
    if (attendee != null) {
      attendees[attendeeId] = attendee.copyWith(
        externalUserId: externalUserId ?? attendee.externalUserId,
        muteStatus: muteStatus ?? attendee.muteStatus,
        isVideoOn: isVideoOn ?? attendee.isVideoOn,
        videoTile: videoTile ?? attendee.videoTile,
      );
      value = value.copyWith(attendees: attendees);
    } else {
      addAttendee(
        attendee: AttendeeModel(
          attendeeId: attendeeId,
          externalUserId: externalUserId ?? '',
          muteStatus: muteStatus ?? false,
          isVideoOn: isVideoOn ?? false,
          videoTile: videoTile,
        ),
      );
    }
  }

  void removeAttendee(String attendeeId) {
    final attendees = {
      ...value.attendees..remove(attendeeId),
    };
    value = value.copyWith(attendees: attendees);
  }

  void clearAttendee() {
    value = value.copyWith(attendees: {});
  }

  void toggleVideoStatus({
    required String attendeeId,
  }) {
    final attendees = {...value.attendees};
    final attendee = attendees[attendeeId];
    if (attendee == null) {
      return;
    }
    updateAttendee(
      attendeeId: attendeeId,
      isVideoOn: !attendee.isVideoOn,
    );
  }

  void initializeMeetingData(JoinInfoModel meetData) {
    value = value.copyWith(
      isMeetingActive: true,
      meetingData: meetData,
      meetingId: meetData.meeting.meetingId,
    );
  }

  void toggleFrontCamera() {
    value = value.copyWith(isFrontCamera: !value.isFrontCamera);
  }

  void initializeLocalAttendee() {
    final meetingData = value.meetingData;
    if (meetingData == null) {
      return;
    }
    final localAttendeeId = value.meetingData?.attendeeInfo.attendeeId;
    final externalUserId = value.meetingData?.attendeeInfo.externalUserId;
    if (localAttendeeId == null || externalUserId == null) {
      return;
    }
    value = value.copyWith(localAttendeeId: localAttendeeId);
    updateAttendee(
      attendeeId: localAttendeeId,
      externalUserId: externalUserId,
    );
  }

  void updateAudioDeviceLabel(String label) {
    value = value.copyWith(selectedAudioDevice: label);
  }

  void resetMeetingValues() {
    value = const MeetingValue();
  }
}

extension MeetingNotifierExt on MeetingNotifier {
  Future<void> switchMuteStatus({required bool toBeMute}) async {
    final attendees = {...value.attendees};
    final localAttendeeId = value.localAttendeeId;
    final attendee = attendees[localAttendeeId];
    if (attendee == null || localAttendeeId == null) {
      return;
    }
    if (toBeMute) {
      await native.mute();
    } else {
      await native.unmute();
    }
    updateAttendee(
      attendeeId: localAttendeeId,
      muteStatus: toBeMute,
    );
  }

  Future<void> switchLocalVideoTileStatus({required bool isVideoOn}) async {
    final localAttendeeId = value.localAttendeeId;
    if (localAttendeeId == null) {
      return;
    }

    if (isVideoOn) {
      await native.startLocalVideo();
    } else {
      await native.stopLocalVideo();
    }
    updateAttendee(
      attendeeId: localAttendeeId,
      isVideoOn: isVideoOn,
    );
  }

  Future<void> toggleLocalVideoTileStatus() async {
    final localAttendeeId = value.localAttendeeId;
    final attendees = {...value.attendees};
    final participant = attendees[localAttendeeId];
    if (participant == null || localAttendeeId == null) {
      return;
    }
    await switchLocalVideoTileStatus(isVideoOn: !participant.isVideoOn);
  }

  Future<void> stopMeeting() async {
    await native.stop();
  }

  bool get isReceivingScreenShare => value.isReceivingScreenShare;
  set isReceivingScreenShare(bool isReceivingScreenShare) {
    value = value.copyWith(isReceivingScreenShare: isReceivingScreenShare);
  }

  void switchVideoStatus({
    required String attendeeId,
    required bool isVideoOn,
  }) {
    final attendees = {...value.attendees};
    final participant = attendees[attendeeId];
    if (participant == null) {
      return;
    }
    updateAttendee(
      attendeeId: attendeeId,
      isVideoOn: isVideoOn,
    );
  }

  void didJoinParticipant(AttendeeInfo info) {
    final localAttendeeId = value.localAttendeeId;
    final attendeeIdToAdd = info.attendeeId;

    if (info.isContentShare) {
      updateContentAttendeeId(attendeeIdToAdd);
      updateAttendee(
        attendeeId: info.attendeeId,
        externalUserId: info.externalUserId,
      );
    } else if (localAttendeeId == null) {
      value = value.copyWith(localAttendeeId: localAttendeeId);
    } else if (attendeeIdToAdd != localAttendeeId) {
      updateRemoteAttendeeId(attendeeIdToAdd);
      updateAttendee(
        attendeeId: attendeeIdToAdd,
        externalUserId: info.externalUserId,
      );
    }
  }

  void switchLocalCamera() {
    () async {
      await native.switchLocalCamera();
    }();
  }
}

extension on MeetingNotifier {
  void _attendeeDidLeave(
    AttendeeInfo info, {
    required bool didDrop,
  }) {
    final participant = AttendeeModel.fromPigeonModel(info);
    final attendeeIdToDelete = participant.attendeeId;
    removeAttendee(attendeeIdToDelete);
  }

  void _changedMuteStatus(AttendeeInfo info, {required bool mute}) {
    updateAttendee(
      attendeeId: info.attendeeId,
      muteStatus: mute,
    );
  }
}
