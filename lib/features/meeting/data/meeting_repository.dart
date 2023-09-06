import 'package:amazon_chime_plugin/api/api.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/participant/participant_model.dart';
import 'package:amazon_chime_plugin/interfaces/audio_devices_interface.dart';
import 'package:amazon_chime_plugin/utils/internet_connection.dart';
import 'package:amazon_chime_plugin/utils/logger.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_requester.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_repository.g.dart';

@riverpod
MeetingRepository meetingRepository(MeetingRepositoryRef ref) =>
    MeetingRepository();

final class MeetingRepository implements AudioDevicesInterface {
  MeetingRepository();

  String? meetingId;

  JoinInfoModel? meetingData;

  String? localParticipantId;
  String? remoteParticipantId;
  String? contentParticipantId;
  // AttendeeId is the key
  Map<String, ParticipantModel> _participants = {};
  Map<String, ParticipantModel> get participants => _participants;

  String? selectedAudioDevice;
  List<String> deviceList = [];
  Orientation orientation = Orientation.portrait;

  // AttendeeId is the key
  // Map<String, Attendee> currAttendees = {};

  bool isReceivingScreenShare = false;
  bool isMeetingActive = false;
  final chimePlugin = AmazonChimeRequester();
  final api = Api();

  void updateParticipant({
    required String participantId,
    required ParticipantModel participant,
  }) {
    final tmpParticipants = _participants;
    tmpParticipants[participantId] = participant;
    _participants = tmpParticipants;
  }

  void clearParticipant() {
    _participants = {};
  }

  Future<Result<void, AmazonChimeError>> joinMeetingWithAPI(
    String meetingId,
    String attendeeName,
    ApiConfig config,
  ) async {
    final result = await api.join(
      meetingId,
      attendeeName,
      config,
    );
    switch (result) {
      case Success(value: final value):
        print('value: $value');
        return joinMeeting(value);
      case Failure(exception: final exception):
        print('exception: $exception');
        return Failure(exception);
    }
  }

  Future<Result<void, AmazonChimeError>> joinMeeting(JoinInfoModel info) async {
    final microphonePermissionResult =
        await chimePlugin.requestMicrophonePermissions();
    final cameraPermissionResult = await chimePlugin.requestCameraPermissions();

    if (microphonePermissionResult.isFailure ||
        cameraPermissionResult.isFailure) {
      return Failure(
        AmazonChimeError.customError(
          'Camera and Microphone Permission is required',
        ),
      );
    }

    if (!await isInternetConnectionAvailable) {
      return Failure(
        AmazonChimeError.customError(
          'Internet connection is required',
        ),
      );
    }

    _initializeMeetingData(info);

    final parameter = info.asJoinParameter;
    final result = await chimePlugin.join(parameter);
    switch (result) {
      case Success():
        _initializeLocalAttendee();
        await _listAudioDevices();
        await _initialAudioSelection();
        // ignore: void_checks
        return const Success(());
      case Failure(exception: final exception):
        return Failure(exception);
    }
  }

  //
  // ————————————————————————— Initializers —————————————————————————
  //

  void _initializeMeetingData(JoinInfoModel meetData) {
    isMeetingActive = true;
    meetingData = meetData;
    meetingId = meetData.meeting.externalMeetingId;
  }

  void _initializeLocalAttendee() {
    final meetingData = this.meetingData;
    if (meetingData == null) {
      logger.severe('meeting data is null');
      return;
    }
    final localParticipantId = meetingData.attendeeInfo.attendeeId;
    this.localParticipantId = localParticipantId;
    // if (localParticipantId == null) {
    //   logger.severe('localParticipantId is null');
    //   return;
    // }
    final participant = ParticipantModel(
      participantId: localParticipantId,
      externalUserId: meetingData.attendeeInfo.externalUserId,
    );
    participants[localParticipantId] = participant;
  }
  // //
  // // ————————————————————————— Interface Methods —————————————————————————
  // //

  // @override
  // void attendeeDidJoin(Attendee attendee) {
  //   final String? attendeeIdToAdd = attendee.attendeeId;
  //   if (_isAttendeeContent(attendeeIdToAdd)) {
  //     logger.info('Content detected');
  //     contentAttendeeId = attendeeIdToAdd;
  //     if (contentAttendeeId != null) {
  //       currAttendees[contentAttendeeId!] = attendee;
  //       logger.info('Content added to the meeting');
  //     }
  //     notifyListeners();
  //     return;
  //   }

  //   if (attendeeIdToAdd != localAttendeeId) {
  //     remoteAttendeeId = attendeeIdToAdd;
  //     if (remoteAttendeeId == null) {
  //       logger.severe(Response.null_remote_attendee);
  //       return;
  //     }
  //     currAttendees[remoteAttendeeId!] = attendee;
  //     logger.info(
  //         '${formatExternalUserId(currAttendees[remoteAttendeeId]?.externalUserId)} has joined the meeting.',);
  //     notifyListeners();
  //   }
  // }

  // // Used for both leave and drop callbacks
  // @override
  // void attendeeDidLeave(Attendee attendee, {required bool didDrop}) {
  //   final attIdToDelete = attendee.attendeeId;
  //   currAttendees.remove(attIdToDelete);
  //   if (didDrop) {
  //     logger.info(
  //         '${formatExternalUserId(attendee.externalUserId)} has dropped from the meeting',);
  //   } else {
  //     logger.info(
  //         '${formatExternalUserId(attendee.externalUserId)} has left the meeting',);
  //   }
  //   notifyListeners();
  // }

  // @override
  // void attendeeDidMute(Attendee attendee) {
  //   _changeMuteStatus(attendee, mute: true);
  // }

  // @override
  // void attendeeDidUnmute(Attendee attendee) {
  //   _changeMuteStatus(attendee, mute: false);
  // }

  // @override
  // void videoTileDidAdd(String attendeeId, VideoTile videoTile) {
  //   currAttendees[attendeeId]?.videoTile = videoTile;
  //   if (videoTile.isContentShare) {
  //     isReceivingScreenShare = true;
  //     notifyListeners();
  //     return;
  //   }
  //   currAttendees[attendeeId]?.isVideoOn = true;
  //   notifyListeners();
  // }

  // @override
  // void videoTileDidRemove(String attendeeId, VideoTile videoTile) {
  //   if (videoTile.isContentShare) {
  //     currAttendees[contentAttendeeId]?.videoTile = null;
  //     isReceivingScreenShare = false;
  //   } else {
  //     currAttendees[attendeeId]?.videoTile = null;
  //     currAttendees[attendeeId]?.isVideoOn = false;
  //   }
  //   notifyListeners();
  // }

  // MARK: - AudioDevicesInterface
  @override
  Future<void> _initialAudioSelection() async {
    // final device = await methodChannelProvider
    //     ?.callMethod(MethodCallOption.initialAudioSelection);
    // if (device == null) {
    //   logger.severe(Response.nullInitialAudioDevice);
    //   return;
    // }
    // logger.info('Initial audio device selection: ${device.arguments}');
    // selectedAudioDevice = device.arguments;
  }

  @override
  Future<void> _listAudioDevices() async {
    // final devices = await methodChannelProvider
    //     ?.callMethod(MethodCallOption.listAudioDevices);

    // if (devices == null) {
    //   logger.severe(Response.nullAudioDeviceList);
    //   return;
    // }
    // final deviceIterable = devices.arguments.map((device) => device.toString());

    // final devList = List<String>.from(deviceIterable.toList());
    // logger.shout('Devices available: $devList');
    // deviceList = devList;
  }

  @override
  Future<void> updateCurrentAudioDevice(String deviceLabel) async {
    // final updateDeviceResponse = await methodChannelProvider?.callMethod(
    //   MethodCallOption.updateAudioDevice,
    //   deviceLabel,
    // );

    // if (updateDeviceResponse == null) {
    //   logger.severe(Response.nullAudioDeviceUpdate);
    //   return;
    // }

    // if (updateDeviceResponse.result) {
    //   logger.info('${updateDeviceResponse.arguments} to: $deviceLabel');
    //   selectedAudioDevice = deviceLabel;
    // } else {
    //   logger.severe('${updateDeviceResponse.arguments}');
    // }
  }

  // @override
  // void audioSessionDidStop() {
  //   logger.info('Audio session stopped by AudioVideoObserver.');
  //   _resetMeetingValues();
  // }

  // //
  // // —————————————————————————— Methods ——————————————————————————————————————
  // //

  // void _changeMuteStatus(Attendee attendee, {required bool mute}) {
  //   final attIdToggleMute = attendee.attendeeId;
  //   currAttendees[attIdToggleMute]?.muteStatus = mute;
  //   if (mute) {
  //     logger.info('${formatExternalUserId(attendee.externalUserId)} has been muted');
  //   } else {
  //     logger.info(
  //         '${formatExternalUserId(attendee.externalUserId)} has been unmuted',);
  //   }
  //   notifyListeners();
  // }

  Future<void> sendLocalMuteToggle() async {
    final localParticipantId = this.localParticipantId;
    final participant = participants[localParticipantId];
    if (participant == null || localParticipantId == null) {
      logger.severe('Local attendee not found');
      return;
    }
    final formatExternalUserId =
        participants[localParticipantId]?.formattedExternalUserId;
    if (participant.muteStatus) {
      final result = await chimePlugin.unmute();
      switch (result) {
        case Success():
          logger.info('$formatExternalUserId successfully unmuted');
        case Failure(exception: final exception):
          logger.info(
            '$formatExternalUserId unmuted failed ${exception.message}',
          );
      }
    } else {
      final result = await chimePlugin.mute();
      switch (result) {
        case Success():
          logger.info('$formatExternalUserId successfully muted');
        case Failure(exception: final exception):
          logger.info(
            '$formatExternalUserId muted failed, ${exception.message}}',
          );
      }
    }
    updateParticipant(
      participantId: localParticipantId,
      participant: participant.copyWith(muteStatus: !participant.muteStatus),
    );
  }

  Future<void> sendLocalVideoTileOn() async {
    final localParticipantId = this.localParticipantId;
    final participant = participants[localParticipantId];
    if (participant == null || localParticipantId == null) {
      logger.severe('Local attendee not found');
      return;
    }

    if (participant.isVideoOn) {
      await chimePlugin.stopLocalVideo();
    } else {
      await chimePlugin.startLocalVideo();
    }
    updateParticipant(
      participantId: localParticipantId,
      participant: participant.copyWith(isVideoOn: !participant.isVideoOn),
    );
  }

  Future<void> stopMeeting() async {
    final result = await chimePlugin.stop();
    switch (result) {
      case Success():
        print('Success');
      case Failure(exception: final exception):
        print(exception.message);
    }
  }

  // //
  // // —————————————————————————— Helpers ——————————————————————————————————————
  // //

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
