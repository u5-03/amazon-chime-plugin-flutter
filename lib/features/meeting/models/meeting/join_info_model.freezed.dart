// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JoinInfoModel _$JoinInfoModelFromJson(Map<String, dynamic> json) {
  return _JoinInfoModel.fromJson(json);
}

/// @nodoc
mixin _$JoinInfoModel {
  MeetingModel get meeting => throw _privateConstructorUsedError;
  AttendeeInfoModel get attendeeInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinInfoModelCopyWith<JoinInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinInfoModelCopyWith<$Res> {
  factory $JoinInfoModelCopyWith(
          JoinInfoModel value, $Res Function(JoinInfoModel) then) =
      _$JoinInfoModelCopyWithImpl<$Res, JoinInfoModel>;
  @useResult
  $Res call({MeetingModel meeting, AttendeeInfoModel attendeeInfo});

  $MeetingModelCopyWith<$Res> get meeting;
  $AttendeeInfoModelCopyWith<$Res> get attendeeInfo;
}

/// @nodoc
class _$JoinInfoModelCopyWithImpl<$Res, $Val extends JoinInfoModel>
    implements $JoinInfoModelCopyWith<$Res> {
  _$JoinInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meeting = null,
    Object? attendeeInfo = null,
  }) {
    return _then(_value.copyWith(
      meeting: null == meeting
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as MeetingModel,
      attendeeInfo: null == attendeeInfo
          ? _value.attendeeInfo
          : attendeeInfo // ignore: cast_nullable_to_non_nullable
              as AttendeeInfoModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MeetingModelCopyWith<$Res> get meeting {
    return $MeetingModelCopyWith<$Res>(_value.meeting, (value) {
      return _then(_value.copyWith(meeting: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AttendeeInfoModelCopyWith<$Res> get attendeeInfo {
    return $AttendeeInfoModelCopyWith<$Res>(_value.attendeeInfo, (value) {
      return _then(_value.copyWith(attendeeInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_JoinInfoModelCopyWith<$Res>
    implements $JoinInfoModelCopyWith<$Res> {
  factory _$$_JoinInfoModelCopyWith(
          _$_JoinInfoModel value, $Res Function(_$_JoinInfoModel) then) =
      __$$_JoinInfoModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MeetingModel meeting, AttendeeInfoModel attendeeInfo});

  @override
  $MeetingModelCopyWith<$Res> get meeting;
  @override
  $AttendeeInfoModelCopyWith<$Res> get attendeeInfo;
}

/// @nodoc
class __$$_JoinInfoModelCopyWithImpl<$Res>
    extends _$JoinInfoModelCopyWithImpl<$Res, _$_JoinInfoModel>
    implements _$$_JoinInfoModelCopyWith<$Res> {
  __$$_JoinInfoModelCopyWithImpl(
      _$_JoinInfoModel _value, $Res Function(_$_JoinInfoModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meeting = null,
    Object? attendeeInfo = null,
  }) {
    return _then(_$_JoinInfoModel(
      meeting: null == meeting
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as MeetingModel,
      attendeeInfo: null == attendeeInfo
          ? _value.attendeeInfo
          : attendeeInfo // ignore: cast_nullable_to_non_nullable
              as AttendeeInfoModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JoinInfoModel implements _JoinInfoModel {
  const _$_JoinInfoModel({required this.meeting, required this.attendeeInfo});

  factory _$_JoinInfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_JoinInfoModelFromJson(json);

  @override
  final MeetingModel meeting;
  @override
  final AttendeeInfoModel attendeeInfo;

  @override
  String toString() {
    return 'JoinInfoModel(meeting: $meeting, attendeeInfo: $attendeeInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JoinInfoModel &&
            (identical(other.meeting, meeting) || other.meeting == meeting) &&
            (identical(other.attendeeInfo, attendeeInfo) ||
                other.attendeeInfo == attendeeInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, meeting, attendeeInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JoinInfoModelCopyWith<_$_JoinInfoModel> get copyWith =>
      __$$_JoinInfoModelCopyWithImpl<_$_JoinInfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JoinInfoModelToJson(
      this,
    );
  }
}

abstract class _JoinInfoModel implements JoinInfoModel {
  const factory _JoinInfoModel(
      {required final MeetingModel meeting,
      required final AttendeeInfoModel attendeeInfo}) = _$_JoinInfoModel;

  factory _JoinInfoModel.fromJson(Map<String, dynamic> json) =
      _$_JoinInfoModel.fromJson;

  @override
  MeetingModel get meeting;
  @override
  AttendeeInfoModel get attendeeInfo;
  @override
  @JsonKey(ignore: true)
  _$$_JoinInfoModelCopyWith<_$_JoinInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

MeetingModel _$MeetingModelFromJson(Map<String, dynamic> json) {
  return _MeetingModel.fromJson(json);
}

/// @nodoc
mixin _$MeetingModel {
  String get meetingId => throw _privateConstructorUsedError;
  String get externalMeetingId => throw _privateConstructorUsedError;
  String get mediaRegion => throw _privateConstructorUsedError;
  MediaPlacementModel get mediaPlacement => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetingModelCopyWith<MeetingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingModelCopyWith<$Res> {
  factory $MeetingModelCopyWith(
          MeetingModel value, $Res Function(MeetingModel) then) =
      _$MeetingModelCopyWithImpl<$Res, MeetingModel>;
  @useResult
  $Res call(
      {String meetingId,
      String externalMeetingId,
      String mediaRegion,
      MediaPlacementModel mediaPlacement});

  $MediaPlacementModelCopyWith<$Res> get mediaPlacement;
}

/// @nodoc
class _$MeetingModelCopyWithImpl<$Res, $Val extends MeetingModel>
    implements $MeetingModelCopyWith<$Res> {
  _$MeetingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? externalMeetingId = null,
    Object? mediaRegion = null,
    Object? mediaPlacement = null,
  }) {
    return _then(_value.copyWith(
      meetingId: null == meetingId
          ? _value.meetingId
          : meetingId // ignore: cast_nullable_to_non_nullable
              as String,
      externalMeetingId: null == externalMeetingId
          ? _value.externalMeetingId
          : externalMeetingId // ignore: cast_nullable_to_non_nullable
              as String,
      mediaRegion: null == mediaRegion
          ? _value.mediaRegion
          : mediaRegion // ignore: cast_nullable_to_non_nullable
              as String,
      mediaPlacement: null == mediaPlacement
          ? _value.mediaPlacement
          : mediaPlacement // ignore: cast_nullable_to_non_nullable
              as MediaPlacementModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MediaPlacementModelCopyWith<$Res> get mediaPlacement {
    return $MediaPlacementModelCopyWith<$Res>(_value.mediaPlacement, (value) {
      return _then(_value.copyWith(mediaPlacement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MeetingModelCopyWith<$Res>
    implements $MeetingModelCopyWith<$Res> {
  factory _$$_MeetingModelCopyWith(
          _$_MeetingModel value, $Res Function(_$_MeetingModel) then) =
      __$$_MeetingModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String meetingId,
      String externalMeetingId,
      String mediaRegion,
      MediaPlacementModel mediaPlacement});

  @override
  $MediaPlacementModelCopyWith<$Res> get mediaPlacement;
}

/// @nodoc
class __$$_MeetingModelCopyWithImpl<$Res>
    extends _$MeetingModelCopyWithImpl<$Res, _$_MeetingModel>
    implements _$$_MeetingModelCopyWith<$Res> {
  __$$_MeetingModelCopyWithImpl(
      _$_MeetingModel _value, $Res Function(_$_MeetingModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? externalMeetingId = null,
    Object? mediaRegion = null,
    Object? mediaPlacement = null,
  }) {
    return _then(_$_MeetingModel(
      meetingId: null == meetingId
          ? _value.meetingId
          : meetingId // ignore: cast_nullable_to_non_nullable
              as String,
      externalMeetingId: null == externalMeetingId
          ? _value.externalMeetingId
          : externalMeetingId // ignore: cast_nullable_to_non_nullable
              as String,
      mediaRegion: null == mediaRegion
          ? _value.mediaRegion
          : mediaRegion // ignore: cast_nullable_to_non_nullable
              as String,
      mediaPlacement: null == mediaPlacement
          ? _value.mediaPlacement
          : mediaPlacement // ignore: cast_nullable_to_non_nullable
              as MediaPlacementModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MeetingModel implements _MeetingModel {
  const _$_MeetingModel(
      {required this.meetingId,
      required this.externalMeetingId,
      required this.mediaRegion,
      required this.mediaPlacement});

  factory _$_MeetingModel.fromJson(Map<String, dynamic> json) =>
      _$$_MeetingModelFromJson(json);

  @override
  final String meetingId;
  @override
  final String externalMeetingId;
  @override
  final String mediaRegion;
  @override
  final MediaPlacementModel mediaPlacement;

  @override
  String toString() {
    return 'MeetingModel(meetingId: $meetingId, externalMeetingId: $externalMeetingId, mediaRegion: $mediaRegion, mediaPlacement: $mediaPlacement)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MeetingModel &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.externalMeetingId, externalMeetingId) ||
                other.externalMeetingId == externalMeetingId) &&
            (identical(other.mediaRegion, mediaRegion) ||
                other.mediaRegion == mediaRegion) &&
            (identical(other.mediaPlacement, mediaPlacement) ||
                other.mediaPlacement == mediaPlacement));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, meetingId, externalMeetingId, mediaRegion, mediaPlacement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MeetingModelCopyWith<_$_MeetingModel> get copyWith =>
      __$$_MeetingModelCopyWithImpl<_$_MeetingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MeetingModelToJson(
      this,
    );
  }
}

abstract class _MeetingModel implements MeetingModel {
  const factory _MeetingModel(
      {required final String meetingId,
      required final String externalMeetingId,
      required final String mediaRegion,
      required final MediaPlacementModel mediaPlacement}) = _$_MeetingModel;

  factory _MeetingModel.fromJson(Map<String, dynamic> json) =
      _$_MeetingModel.fromJson;

  @override
  String get meetingId;
  @override
  String get externalMeetingId;
  @override
  String get mediaRegion;
  @override
  MediaPlacementModel get mediaPlacement;
  @override
  @JsonKey(ignore: true)
  _$$_MeetingModelCopyWith<_$_MeetingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

MediaPlacementModel _$MediaPlacementModelFromJson(Map<String, dynamic> json) {
  return _MediaPlacementModel.fromJson(json);
}

/// @nodoc
mixin _$MediaPlacementModel {
  String get audioHostUrl => throw _privateConstructorUsedError;
  String get audioFallbackUrl => throw _privateConstructorUsedError;
  String get signalingUrl => throw _privateConstructorUsedError;
  String get turnControllerUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaPlacementModelCopyWith<MediaPlacementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaPlacementModelCopyWith<$Res> {
  factory $MediaPlacementModelCopyWith(
          MediaPlacementModel value, $Res Function(MediaPlacementModel) then) =
      _$MediaPlacementModelCopyWithImpl<$Res, MediaPlacementModel>;
  @useResult
  $Res call(
      {String audioHostUrl,
      String audioFallbackUrl,
      String signalingUrl,
      String turnControllerUrl});
}

/// @nodoc
class _$MediaPlacementModelCopyWithImpl<$Res, $Val extends MediaPlacementModel>
    implements $MediaPlacementModelCopyWith<$Res> {
  _$MediaPlacementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioHostUrl = null,
    Object? audioFallbackUrl = null,
    Object? signalingUrl = null,
    Object? turnControllerUrl = null,
  }) {
    return _then(_value.copyWith(
      audioHostUrl: null == audioHostUrl
          ? _value.audioHostUrl
          : audioHostUrl // ignore: cast_nullable_to_non_nullable
              as String,
      audioFallbackUrl: null == audioFallbackUrl
          ? _value.audioFallbackUrl
          : audioFallbackUrl // ignore: cast_nullable_to_non_nullable
              as String,
      signalingUrl: null == signalingUrl
          ? _value.signalingUrl
          : signalingUrl // ignore: cast_nullable_to_non_nullable
              as String,
      turnControllerUrl: null == turnControllerUrl
          ? _value.turnControllerUrl
          : turnControllerUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MediaPlacementModelCopyWith<$Res>
    implements $MediaPlacementModelCopyWith<$Res> {
  factory _$$_MediaPlacementModelCopyWith(_$_MediaPlacementModel value,
          $Res Function(_$_MediaPlacementModel) then) =
      __$$_MediaPlacementModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String audioHostUrl,
      String audioFallbackUrl,
      String signalingUrl,
      String turnControllerUrl});
}

/// @nodoc
class __$$_MediaPlacementModelCopyWithImpl<$Res>
    extends _$MediaPlacementModelCopyWithImpl<$Res, _$_MediaPlacementModel>
    implements _$$_MediaPlacementModelCopyWith<$Res> {
  __$$_MediaPlacementModelCopyWithImpl(_$_MediaPlacementModel _value,
      $Res Function(_$_MediaPlacementModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioHostUrl = null,
    Object? audioFallbackUrl = null,
    Object? signalingUrl = null,
    Object? turnControllerUrl = null,
  }) {
    return _then(_$_MediaPlacementModel(
      audioHostUrl: null == audioHostUrl
          ? _value.audioHostUrl
          : audioHostUrl // ignore: cast_nullable_to_non_nullable
              as String,
      audioFallbackUrl: null == audioFallbackUrl
          ? _value.audioFallbackUrl
          : audioFallbackUrl // ignore: cast_nullable_to_non_nullable
              as String,
      signalingUrl: null == signalingUrl
          ? _value.signalingUrl
          : signalingUrl // ignore: cast_nullable_to_non_nullable
              as String,
      turnControllerUrl: null == turnControllerUrl
          ? _value.turnControllerUrl
          : turnControllerUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MediaPlacementModel implements _MediaPlacementModel {
  const _$_MediaPlacementModel(
      {required this.audioHostUrl,
      required this.audioFallbackUrl,
      required this.signalingUrl,
      required this.turnControllerUrl});

  factory _$_MediaPlacementModel.fromJson(Map<String, dynamic> json) =>
      _$$_MediaPlacementModelFromJson(json);

  @override
  final String audioHostUrl;
  @override
  final String audioFallbackUrl;
  @override
  final String signalingUrl;
  @override
  final String turnControllerUrl;

  @override
  String toString() {
    return 'MediaPlacementModel(audioHostUrl: $audioHostUrl, audioFallbackUrl: $audioFallbackUrl, signalingUrl: $signalingUrl, turnControllerUrl: $turnControllerUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MediaPlacementModel &&
            (identical(other.audioHostUrl, audioHostUrl) ||
                other.audioHostUrl == audioHostUrl) &&
            (identical(other.audioFallbackUrl, audioFallbackUrl) ||
                other.audioFallbackUrl == audioFallbackUrl) &&
            (identical(other.signalingUrl, signalingUrl) ||
                other.signalingUrl == signalingUrl) &&
            (identical(other.turnControllerUrl, turnControllerUrl) ||
                other.turnControllerUrl == turnControllerUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, audioHostUrl, audioFallbackUrl,
      signalingUrl, turnControllerUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MediaPlacementModelCopyWith<_$_MediaPlacementModel> get copyWith =>
      __$$_MediaPlacementModelCopyWithImpl<_$_MediaPlacementModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MediaPlacementModelToJson(
      this,
    );
  }
}

abstract class _MediaPlacementModel implements MediaPlacementModel {
  const factory _MediaPlacementModel(
      {required final String audioHostUrl,
      required final String audioFallbackUrl,
      required final String signalingUrl,
      required final String turnControllerUrl}) = _$_MediaPlacementModel;

  factory _MediaPlacementModel.fromJson(Map<String, dynamic> json) =
      _$_MediaPlacementModel.fromJson;

  @override
  String get audioHostUrl;
  @override
  String get audioFallbackUrl;
  @override
  String get signalingUrl;
  @override
  String get turnControllerUrl;
  @override
  @JsonKey(ignore: true)
  _$$_MediaPlacementModelCopyWith<_$_MediaPlacementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendeeInfoModel _$AttendeeInfoModelFromJson(Map<String, dynamic> json) {
  return _AttendeeInfoModel.fromJson(json);
}

/// @nodoc
mixin _$AttendeeInfoModel {
  String get externalUserId => throw _privateConstructorUsedError;
  String get attendeeId => throw _privateConstructorUsedError;
  String get joinToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendeeInfoModelCopyWith<AttendeeInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendeeInfoModelCopyWith<$Res> {
  factory $AttendeeInfoModelCopyWith(
          AttendeeInfoModel value, $Res Function(AttendeeInfoModel) then) =
      _$AttendeeInfoModelCopyWithImpl<$Res, AttendeeInfoModel>;
  @useResult
  $Res call({String externalUserId, String attendeeId, String joinToken});
}

/// @nodoc
class _$AttendeeInfoModelCopyWithImpl<$Res, $Val extends AttendeeInfoModel>
    implements $AttendeeInfoModelCopyWith<$Res> {
  _$AttendeeInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalUserId = null,
    Object? attendeeId = null,
    Object? joinToken = null,
  }) {
    return _then(_value.copyWith(
      externalUserId: null == externalUserId
          ? _value.externalUserId
          : externalUserId // ignore: cast_nullable_to_non_nullable
              as String,
      attendeeId: null == attendeeId
          ? _value.attendeeId
          : attendeeId // ignore: cast_nullable_to_non_nullable
              as String,
      joinToken: null == joinToken
          ? _value.joinToken
          : joinToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AttendeeInfoModelCopyWith<$Res>
    implements $AttendeeInfoModelCopyWith<$Res> {
  factory _$$_AttendeeInfoModelCopyWith(_$_AttendeeInfoModel value,
          $Res Function(_$_AttendeeInfoModel) then) =
      __$$_AttendeeInfoModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String externalUserId, String attendeeId, String joinToken});
}

/// @nodoc
class __$$_AttendeeInfoModelCopyWithImpl<$Res>
    extends _$AttendeeInfoModelCopyWithImpl<$Res, _$_AttendeeInfoModel>
    implements _$$_AttendeeInfoModelCopyWith<$Res> {
  __$$_AttendeeInfoModelCopyWithImpl(
      _$_AttendeeInfoModel _value, $Res Function(_$_AttendeeInfoModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalUserId = null,
    Object? attendeeId = null,
    Object? joinToken = null,
  }) {
    return _then(_$_AttendeeInfoModel(
      externalUserId: null == externalUserId
          ? _value.externalUserId
          : externalUserId // ignore: cast_nullable_to_non_nullable
              as String,
      attendeeId: null == attendeeId
          ? _value.attendeeId
          : attendeeId // ignore: cast_nullable_to_non_nullable
              as String,
      joinToken: null == joinToken
          ? _value.joinToken
          : joinToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttendeeInfoModel implements _AttendeeInfoModel {
  const _$_AttendeeInfoModel(
      {required this.externalUserId,
      required this.attendeeId,
      required this.joinToken});

  factory _$_AttendeeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_AttendeeInfoModelFromJson(json);

  @override
  final String externalUserId;
  @override
  final String attendeeId;
  @override
  final String joinToken;

  @override
  String toString() {
    return 'AttendeeInfoModel(externalUserId: $externalUserId, attendeeId: $attendeeId, joinToken: $joinToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttendeeInfoModel &&
            (identical(other.externalUserId, externalUserId) ||
                other.externalUserId == externalUserId) &&
            (identical(other.attendeeId, attendeeId) ||
                other.attendeeId == attendeeId) &&
            (identical(other.joinToken, joinToken) ||
                other.joinToken == joinToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, externalUserId, attendeeId, joinToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttendeeInfoModelCopyWith<_$_AttendeeInfoModel> get copyWith =>
      __$$_AttendeeInfoModelCopyWithImpl<_$_AttendeeInfoModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttendeeInfoModelToJson(
      this,
    );
  }
}

abstract class _AttendeeInfoModel implements AttendeeInfoModel {
  const factory _AttendeeInfoModel(
      {required final String externalUserId,
      required final String attendeeId,
      required final String joinToken}) = _$_AttendeeInfoModel;

  factory _AttendeeInfoModel.fromJson(Map<String, dynamic> json) =
      _$_AttendeeInfoModel.fromJson;

  @override
  String get externalUserId;
  @override
  String get attendeeId;
  @override
  String get joinToken;
  @override
  @JsonKey(ignore: true)
  _$$_AttendeeInfoModelCopyWith<_$_AttendeeInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
