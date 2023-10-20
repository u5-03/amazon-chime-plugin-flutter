import 'package:amazon_chime_plugin/features/meeting/data/meeting_controller.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/participant/participant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_data.freezed.dart';
part 'meeting_data.g.dart';

final localParticipantIdProvider = StateProvider<String?>(
  (ref) => ref.watch(
    meetingControllerProvider.select((value) => value.localParticipantId),
  ),
);

final remoteParticipantId = StateProvider<String?>(
  (ref) => ref.watch(
    meetingControllerProvider.select((value) => value.remoteParticipantId),
  ),
);

@freezed
class MeetingData with _$MeetingData {
  // final _meetingData = MeetingData();

  const factory MeetingData({
    String? meetingId,
    JoinInfoModel? meetingData,
    String? localParticipantId,
    String? remoteParticipantId,
    String? contentParticipantId,
    @Default({}) Map<String, ParticipantModel> participants,
    String? selectedAudioDevice,
    @Default([]) List<String> deviceList,
    @Default(Orientation.portrait) Orientation orientation,
    @Default(false) bool isReceivingScreenShare,
    @Default(false) bool isMeetingActive,
  }) = _MeetingData;

  factory MeetingData.fromJson(Map<String, dynamic> json) =>
      _$MeetingDataFromJson(json);

  // String? meetingId;

  // JoinInfoModel? meetingData;

  // String? localParticipantId;
  // String? remoteParticipantId;
  // String? contentParticipantId;
  // // AttendeeId is the key
  // Map<String, ParticipantModel> participants = {};

  // String? selectedAudioDevice;
  // List<String> deviceList = [];
  // Orientation orientation = Orientation.portrait;
  // String tmpValue = StringExt.randomLength;

  // AttendeeId is the key
  // Map<String, Attendee> currAttendees = {};

  // @override
  // MeetingData build() {
  //   return _meetingData;
  // }
}

extension MeetingDataExt on MeetingData {
  List<ParticipantModel> get participantsList => participants.values.toList();
  ParticipantModel? get localParticipantModel =>
      participants[localParticipantId];
  ParticipantModel? get contentParticipantModel =>
      participants[contentParticipantId];
}
