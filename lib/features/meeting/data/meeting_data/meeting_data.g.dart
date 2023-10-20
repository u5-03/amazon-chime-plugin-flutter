// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeetingDataImpl _$$MeetingDataImplFromJson(Map<String, dynamic> json) =>
    _$MeetingDataImpl(
      meetingId: json['meetingId'] as String?,
      meetingData: json['meetingData'] == null
          ? null
          : JoinInfoModel.fromJson(json['meetingData'] as Map<String, dynamic>),
      localParticipantId: json['localParticipantId'] as String?,
      remoteParticipantId: json['remoteParticipantId'] as String?,
      contentParticipantId: json['contentParticipantId'] as String?,
      participants: (json['participants'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, ParticipantModel.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      selectedAudioDevice: json['selectedAudioDevice'] as String?,
      deviceList: (json['deviceList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      orientation:
          $enumDecodeNullable(_$OrientationEnumMap, json['orientation']) ??
              Orientation.portrait,
      isReceivingScreenShare: json['isReceivingScreenShare'] as bool? ?? false,
      isMeetingActive: json['isMeetingActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$MeetingDataImplToJson(_$MeetingDataImpl instance) =>
    <String, dynamic>{
      'meetingId': instance.meetingId,
      'meetingData': instance.meetingData,
      'localParticipantId': instance.localParticipantId,
      'remoteParticipantId': instance.remoteParticipantId,
      'contentParticipantId': instance.contentParticipantId,
      'participants': instance.participants,
      'selectedAudioDevice': instance.selectedAudioDevice,
      'deviceList': instance.deviceList,
      'orientation': _$OrientationEnumMap[instance.orientation]!,
      'isReceivingScreenShare': instance.isReceivingScreenShare,
      'isMeetingActive': instance.isMeetingActive,
    };

const _$OrientationEnumMap = {
  Orientation.portrait: 'portrait',
  Orientation.landscape: 'landscape',
};
