import 'package:amazon_chime_plugin/api/api.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/extensions/string.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_data/meeting_data.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/participant/participant_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/video_tile_model/video_tile_model.dart';
import 'package:amazon_chime_plugin/interfaces/audio_devices_interface.dart';
import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/utils/internet_connection.dart';
import 'package:amazon_chime_plugin/utils/logger.dart';
import 'package:amazon_chime_plugin/utils/permission_manager.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_requester.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'meeting_controller.g.dart';

class DataState {
  DataState({required this.data});
  String data;
}

final counterProvider = NotifierProvider<Counter, DataState>(Counter.new);

class Counter extends Notifier<DataState> {
  @override
  DataState build() {
    // Inside "build", we return the initial state of the counter.
    return DataState(data: '');
  }

  void increment() {
    state = DataState(data: StringExt.randomLength);
  }
}

final meetingControllerProvider =
    NotifierProvider<MeetingController, MeetingData>(() {
  return MeetingController(
    meetingData: const MeetingData(),
  );
});

final class MeetingController extends Notifier<MeetingData>
    implements AudioDevicesInterface {
  MeetingController({required this.meetingData});
  final chimePlugin = AmazonChimeRequester();
  final api = Api();
  MeetingData meetingData;

  // LateError (LateInitializationError: Field '_element@101511105' has not been initialized.)
  @override
  MeetingData build() {
    return meetingData;
  }

  void updateContentParticipantId(String contentParticipantId) {
    state = state.copyWith(contentParticipantId: contentParticipantId);
  }

  void updateRemoteParticipantId(String remoteParticipantId) {
    state = state.copyWith(remoteParticipantId: remoteParticipantId);
  }

  void addParticipant({required ParticipantModel participant}) {
    final participants = {...state.participants};
    participants[participant.participantId] = participant;
    state = state.copyWith(participants: participants);
  }

  void updateParticipant({
    required String participantId,
    String? externalUserId,
    bool? muteStatus,
    bool? isVideoOn,
    VideoTileModel? videoTile,
  }) {
    final participants = {...state.participants};
    final participant = participants[participantId];
    if (participant != null) {
      participants[participantId] = participant.copyWith(
        externalUserId: externalUserId ?? participant.externalUserId,
        muteStatus: muteStatus ?? participant.muteStatus,
        isVideoOn: isVideoOn ?? participant.isVideoOn,
        videoTile: videoTile ?? participant.videoTile,
      );
      state = state.copyWith(participants: participants);
    } else {
      addParticipant(
        participant: ParticipantModel(
          participantId: participantId,
          externalUserId: externalUserId ?? '',
          muteStatus: muteStatus ?? false,
          isVideoOn: isVideoOn ?? false,
          videoTile: videoTile,
        ),
      );
    }
    print('updateParticipant: $participants');
  }

  void removeParticipant(String participantId) {
    final participants = {...state.participants};
    participants.remove(participantId);
    state = state.copyWith(participants: participants);
  }

  void clearParticipant() {
    state = state.copyWith(participants: {});
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
        await PermissionManager.requestMicrophonePermissions();
    final cameraPermissionResult =
        await PermissionManager.requestCameraPermissions();
    if (!microphonePermissionResult.isGranted ||
        !cameraPermissionResult.isGranted) {
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
    state = state.copyWith(
      isMeetingActive: true,
      meetingData: meetData,
      meetingId: meetData.meeting.externalMeetingId,
    );
  }

  void _initializeLocalAttendee() {
    final meetingData = state.meetingData;
    if (meetingData == null) {
      logger.severe('meeting data is null');
      return;
    }
    final localParticipantId = state.meetingData?.attendeeInfo.attendeeId;
    final externalUserId = state.meetingData?.attendeeInfo.externalUserId;
    if (localParticipantId == null || externalUserId == null) {
      logger.severe('localParticipantId is null');
      return;
    }
    state = state.copyWith(localParticipantId: localParticipantId);
    updateParticipant(
      participantId: localParticipantId,
      externalUserId: externalUserId,
    );
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
    final participants = {...state.participants};
    final localParticipantId = state.localParticipantId;
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
      muteStatus: !participant.muteStatus,
    );
  }

  Future<void> sendLocalVideoTileOn() async {
    final localParticipantId = state.localParticipantId;
    final participants = {...state.participants};
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
      isVideoOn: !participant.isVideoOn,
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

  bool get isReceivingScreenShare => state.isReceivingScreenShare;
  set isReceivingScreenShare(bool isReceivingScreenShare) {
    state = state.copyWith(isReceivingScreenShare: isReceivingScreenShare);
  }

  void toggleVideoStatus({
    required String participantId,
  }) {
    final participants = {...state.participants};
    final participant = participants[participantId];
    if (participant == null) {
      logger.severe('Participant not found');
      return;
    }
    updateParticipant(
      participantId: participantId,
      isVideoOn: !participant.isVideoOn,
    );
  }

  void switchVideoStatus({
    required String participantId,
    required bool isVideoOn,
  }) {
    final participants = {...state.participants};
    final participant = participants[participantId];
    if (participant == null) {
      logger.severe('Participant not found');
      return;
    }
    updateParticipant(
      participantId: participantId,
      isVideoOn: isVideoOn,
    );
  }

  void didJoinParticipant(ParticipantInfo info) {
    final attendeeIdToAdd = info.attendeeId;
    final attendeeIdArray = attendeeIdToAdd.split('#');
    final localAttendeeId = state.localParticipantId;
    final isAttendeeContent = attendeeIdArray.length == 2;
    logger.info('didJoinParticipant: ${info.attendeeId}}');
    if (isAttendeeContent) {
      logger.info('Content detected');
      // meetingController
      updateContentParticipantId(attendeeIdToAdd);
      updateParticipant(
        participantId: info.attendeeId,
        externalUserId: info.externalUserId,
      );
      logger.info('Content added to the meeting');
    } else if (localAttendeeId == null) {
      state = state.copyWith(localParticipantId: localAttendeeId);
    } else if (attendeeIdToAdd != localAttendeeId) {
      updateRemoteParticipantId(attendeeIdToAdd);
      updateParticipant(
        participantId: attendeeIdToAdd,
        externalUserId: info.externalUserId,
      );
      logger.info('Remote participant detected');
    }
  }

  // //
  // // —————————————————————————— Helpers ——————————————————————————————————————
  // //

  void resetMeetingValues() {
    state = const MeetingData();
    logger.info('Meeting values reset');
  }
}
