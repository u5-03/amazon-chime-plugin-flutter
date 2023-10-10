// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MeetingData _$MeetingDataFromJson(Map<String, dynamic> json) {
  return _MeetingData.fromJson(json);
}

/// @nodoc
mixin _$MeetingData {
  String? get meetingId => throw _privateConstructorUsedError;
  JoinInfoModel? get meetingData => throw _privateConstructorUsedError;
  String? get localParticipantId => throw _privateConstructorUsedError;
  String? get remoteParticipantId => throw _privateConstructorUsedError;
  String? get contentParticipantId => throw _privateConstructorUsedError;
  Map<String, ParticipantModel> get participants =>
      throw _privateConstructorUsedError;
  String? get selectedAudioDevice => throw _privateConstructorUsedError;
  List<String> get deviceList => throw _privateConstructorUsedError;
  Orientation get orientation => throw _privateConstructorUsedError;
  bool get isReceivingScreenShare => throw _privateConstructorUsedError;
  bool get isMeetingActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetingDataCopyWith<MeetingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingDataCopyWith<$Res> {
  factory $MeetingDataCopyWith(
          MeetingData value, $Res Function(MeetingData) then) =
      _$MeetingDataCopyWithImpl<$Res, MeetingData>;
  @useResult
  $Res call(
      {String? meetingId,
      JoinInfoModel? meetingData,
      String? localParticipantId,
      String? remoteParticipantId,
      String? contentParticipantId,
      Map<String, ParticipantModel> participants,
      String? selectedAudioDevice,
      List<String> deviceList,
      Orientation orientation,
      bool isReceivingScreenShare,
      bool isMeetingActive});

  $JoinInfoModelCopyWith<$Res>? get meetingData;
}

/// @nodoc
class _$MeetingDataCopyWithImpl<$Res, $Val extends MeetingData>
    implements $MeetingDataCopyWith<$Res> {
  _$MeetingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = freezed,
    Object? meetingData = freezed,
    Object? localParticipantId = freezed,
    Object? remoteParticipantId = freezed,
    Object? contentParticipantId = freezed,
    Object? participants = null,
    Object? selectedAudioDevice = freezed,
    Object? deviceList = null,
    Object? orientation = null,
    Object? isReceivingScreenShare = null,
    Object? isMeetingActive = null,
  }) {
    return _then(_value.copyWith(
      meetingId: freezed == meetingId
          ? _value.meetingId
          : meetingId // ignore: cast_nullable_to_non_nullable
              as String?,
      meetingData: freezed == meetingData
          ? _value.meetingData
          : meetingData // ignore: cast_nullable_to_non_nullable
              as JoinInfoModel?,
      localParticipantId: freezed == localParticipantId
          ? _value.localParticipantId
          : localParticipantId // ignore: cast_nullable_to_non_nullable
              as String?,
      remoteParticipantId: freezed == remoteParticipantId
          ? _value.remoteParticipantId
          : remoteParticipantId // ignore: cast_nullable_to_non_nullable
              as String?,
      contentParticipantId: freezed == contentParticipantId
          ? _value.contentParticipantId
          : contentParticipantId // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as Map<String, ParticipantModel>,
      selectedAudioDevice: freezed == selectedAudioDevice
          ? _value.selectedAudioDevice
          : selectedAudioDevice // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceList: null == deviceList
          ? _value.deviceList
          : deviceList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      orientation: null == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
      isReceivingScreenShare: null == isReceivingScreenShare
          ? _value.isReceivingScreenShare
          : isReceivingScreenShare // ignore: cast_nullable_to_non_nullable
              as bool,
      isMeetingActive: null == isMeetingActive
          ? _value.isMeetingActive
          : isMeetingActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JoinInfoModelCopyWith<$Res>? get meetingData {
    if (_value.meetingData == null) {
      return null;
    }

    return $JoinInfoModelCopyWith<$Res>(_value.meetingData!, (value) {
      return _then(_value.copyWith(meetingData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MeetingDataCopyWith<$Res>
    implements $MeetingDataCopyWith<$Res> {
  factory _$$_MeetingDataCopyWith(
          _$_MeetingData value, $Res Function(_$_MeetingData) then) =
      __$$_MeetingDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? meetingId,
      JoinInfoModel? meetingData,
      String? localParticipantId,
      String? remoteParticipantId,
      String? contentParticipantId,
      Map<String, ParticipantModel> participants,
      String? selectedAudioDevice,
      List<String> deviceList,
      Orientation orientation,
      bool isReceivingScreenShare,
      bool isMeetingActive});

  @override
  $JoinInfoModelCopyWith<$Res>? get meetingData;
}

/// @nodoc
class __$$_MeetingDataCopyWithImpl<$Res>
    extends _$MeetingDataCopyWithImpl<$Res, _$_MeetingData>
    implements _$$_MeetingDataCopyWith<$Res> {
  __$$_MeetingDataCopyWithImpl(
      _$_MeetingData _value, $Res Function(_$_MeetingData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = freezed,
    Object? meetingData = freezed,
    Object? localParticipantId = freezed,
    Object? remoteParticipantId = freezed,
    Object? contentParticipantId = freezed,
    Object? participants = null,
    Object? selectedAudioDevice = freezed,
    Object? deviceList = null,
    Object? orientation = null,
    Object? isReceivingScreenShare = null,
    Object? isMeetingActive = null,
  }) {
    return _then(_$_MeetingData(
      meetingId: freezed == meetingId
          ? _value.meetingId
          : meetingId // ignore: cast_nullable_to_non_nullable
              as String?,
      meetingData: freezed == meetingData
          ? _value.meetingData
          : meetingData // ignore: cast_nullable_to_non_nullable
              as JoinInfoModel?,
      localParticipantId: freezed == localParticipantId
          ? _value.localParticipantId
          : localParticipantId // ignore: cast_nullable_to_non_nullable
              as String?,
      remoteParticipantId: freezed == remoteParticipantId
          ? _value.remoteParticipantId
          : remoteParticipantId // ignore: cast_nullable_to_non_nullable
              as String?,
      contentParticipantId: freezed == contentParticipantId
          ? _value.contentParticipantId
          : contentParticipantId // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as Map<String, ParticipantModel>,
      selectedAudioDevice: freezed == selectedAudioDevice
          ? _value.selectedAudioDevice
          : selectedAudioDevice // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceList: null == deviceList
          ? _value._deviceList
          : deviceList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      orientation: null == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
      isReceivingScreenShare: null == isReceivingScreenShare
          ? _value.isReceivingScreenShare
          : isReceivingScreenShare // ignore: cast_nullable_to_non_nullable
              as bool,
      isMeetingActive: null == isMeetingActive
          ? _value.isMeetingActive
          : isMeetingActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MeetingData implements _MeetingData {
  const _$_MeetingData(
      {this.meetingId,
      this.meetingData,
      this.localParticipantId,
      this.remoteParticipantId,
      this.contentParticipantId,
      final Map<String, ParticipantModel> participants = const {},
      this.selectedAudioDevice,
      final List<String> deviceList = const [],
      this.orientation = Orientation.portrait,
      this.isReceivingScreenShare = false,
      this.isMeetingActive = false})
      : _participants = participants,
        _deviceList = deviceList;

  factory _$_MeetingData.fromJson(Map<String, dynamic> json) =>
      _$$_MeetingDataFromJson(json);

  @override
  final String? meetingId;
  @override
  final JoinInfoModel? meetingData;
  @override
  final String? localParticipantId;
  @override
  final String? remoteParticipantId;
  @override
  final String? contentParticipantId;
  final Map<String, ParticipantModel> _participants;
  @override
  @JsonKey()
  Map<String, ParticipantModel> get participants {
    if (_participants is EqualUnmodifiableMapView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_participants);
  }

  @override
  final String? selectedAudioDevice;
  final List<String> _deviceList;
  @override
  @JsonKey()
  List<String> get deviceList {
    if (_deviceList is EqualUnmodifiableListView) return _deviceList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceList);
  }

  @override
  @JsonKey()
  final Orientation orientation;
  @override
  @JsonKey()
  final bool isReceivingScreenShare;
  @override
  @JsonKey()
  final bool isMeetingActive;

  @override
  String toString() {
    return 'MeetingData(meetingId: $meetingId, meetingData: $meetingData, localParticipantId: $localParticipantId, remoteParticipantId: $remoteParticipantId, contentParticipantId: $contentParticipantId, participants: $participants, selectedAudioDevice: $selectedAudioDevice, deviceList: $deviceList, orientation: $orientation, isReceivingScreenShare: $isReceivingScreenShare, isMeetingActive: $isMeetingActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MeetingData &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.meetingData, meetingData) ||
                other.meetingData == meetingData) &&
            (identical(other.localParticipantId, localParticipantId) ||
                other.localParticipantId == localParticipantId) &&
            (identical(other.remoteParticipantId, remoteParticipantId) ||
                other.remoteParticipantId == remoteParticipantId) &&
            (identical(other.contentParticipantId, contentParticipantId) ||
                other.contentParticipantId == contentParticipantId) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.selectedAudioDevice, selectedAudioDevice) ||
                other.selectedAudioDevice == selectedAudioDevice) &&
            const DeepCollectionEquality()
                .equals(other._deviceList, _deviceList) &&
            (identical(other.orientation, orientation) ||
                other.orientation == orientation) &&
            (identical(other.isReceivingScreenShare, isReceivingScreenShare) ||
                other.isReceivingScreenShare == isReceivingScreenShare) &&
            (identical(other.isMeetingActive, isMeetingActive) ||
                other.isMeetingActive == isMeetingActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      meetingId,
      meetingData,
      localParticipantId,
      remoteParticipantId,
      contentParticipantId,
      const DeepCollectionEquality().hash(_participants),
      selectedAudioDevice,
      const DeepCollectionEquality().hash(_deviceList),
      orientation,
      isReceivingScreenShare,
      isMeetingActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MeetingDataCopyWith<_$_MeetingData> get copyWith =>
      __$$_MeetingDataCopyWithImpl<_$_MeetingData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MeetingDataToJson(
      this,
    );
  }
}

abstract class _MeetingData implements MeetingData {
  const factory _MeetingData(
      {final String? meetingId,
      final JoinInfoModel? meetingData,
      final String? localParticipantId,
      final String? remoteParticipantId,
      final String? contentParticipantId,
      final Map<String, ParticipantModel> participants,
      final String? selectedAudioDevice,
      final List<String> deviceList,
      final Orientation orientation,
      final bool isReceivingScreenShare,
      final bool isMeetingActive}) = _$_MeetingData;

  factory _MeetingData.fromJson(Map<String, dynamic> json) =
      _$_MeetingData.fromJson;

  @override
  String? get meetingId;
  @override
  JoinInfoModel? get meetingData;
  @override
  String? get localParticipantId;
  @override
  String? get remoteParticipantId;
  @override
  String? get contentParticipantId;
  @override
  Map<String, ParticipantModel> get participants;
  @override
  String? get selectedAudioDevice;
  @override
  List<String> get deviceList;
  @override
  Orientation get orientation;
  @override
  bool get isReceivingScreenShare;
  @override
  bool get isMeetingActive;
  @override
  @JsonKey(ignore: true)
  _$$_MeetingDataCopyWith<_$_MeetingData> get copyWith =>
      throw _privateConstructorUsedError;
}
