import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/participant/participant_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_data.freezed.dart';
part 'meeting_data.g.dart';

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
