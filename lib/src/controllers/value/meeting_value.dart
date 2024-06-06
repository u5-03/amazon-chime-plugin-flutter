import 'package:amazon_chime_plugin/src/models/attendee_model.dart';
import 'package:amazon_chime_plugin/src/models/join_info_model.dart';
import 'package:flutter/material.dart';

final class MeetingValue {
  const MeetingValue({
    this.meetingId,
    this.meetingData,
    this.localAttendeeId,
    this.remoteAttendeeId,
    this.contentAttendeeId,
    this.attendees = const {},
    this.selectedAudioDevice,
    this.deviceList = const [],
    this.orientation = Orientation.portrait,
    this.isReceivingScreenShare = false,
    this.isMeetingActive = false,
    this.isLocalVideoEnabled = false,
    this.isFrontCamera = true,
  });

  factory MeetingValue.empty() => const MeetingValue();

  final String? meetingId;
  final JoinInfoModel? meetingData;
  final String? localAttendeeId;
  final String? remoteAttendeeId;
  final String? contentAttendeeId;
  final Map<String, AttendeeModel> attendees;
  final String? selectedAudioDevice;
  final List<String> deviceList;
  final Orientation orientation;
  final bool isReceivingScreenShare;
  final bool isMeetingActive;
  final bool isLocalVideoEnabled;
  final bool isFrontCamera;

  MeetingValue copyWith({
    String? meetingId,
    JoinInfoModel? meetingData,
    String? localAttendeeId,
    String? remoteAttendeeId,
    String? contentAttendeeId,
    Map<String, AttendeeModel>? attendees,
    String? selectedAudioDevice,
    List<String>? deviceList,
    Orientation? orientation,
    bool? isReceivingScreenShare,
    bool? isMeetingActive,
    bool? isLocalVideoEnabled,
    bool? isFrontCamera,
  }) {
    return MeetingValue(
      meetingId: meetingId ?? this.meetingId,
      meetingData: meetingData ?? this.meetingData,
      localAttendeeId: localAttendeeId ?? this.localAttendeeId,
      remoteAttendeeId: remoteAttendeeId ?? this.remoteAttendeeId,
      contentAttendeeId: contentAttendeeId ?? this.contentAttendeeId,
      attendees: attendees ?? this.attendees,
      selectedAudioDevice: selectedAudioDevice ?? this.selectedAudioDevice,
      deviceList: deviceList ?? this.deviceList,
      orientation: orientation ?? this.orientation,
      isReceivingScreenShare:
          isReceivingScreenShare ?? this.isReceivingScreenShare,
      isMeetingActive: isMeetingActive ?? this.isMeetingActive,
      isLocalVideoEnabled: isLocalVideoEnabled ?? this.isLocalVideoEnabled,
      isFrontCamera: isFrontCamera ?? this.isFrontCamera,
    );
  }
}

extension MeetingStateExt on MeetingValue {
  List<AttendeeModel> get attendeesList => attendees.values.toList();
  AttendeeModel? get localAttendeeModel => attendees[localAttendeeId];
  AttendeeModel? get contentAttendeeModel => attendees[contentAttendeeId];
}
