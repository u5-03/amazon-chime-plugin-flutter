// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_info_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JoinInfoParentAPIModel _$JoinInfoParentAPIModelFromJson(
    Map<String, dynamic> json) {
  return _JoinInfoParentAPIModel.fromJson(json);
}

/// @nodoc
mixin _$JoinInfoParentAPIModel {
  JoinInfoAPIModel get joinInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinInfoParentAPIModelCopyWith<JoinInfoParentAPIModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinInfoParentAPIModelCopyWith<$Res> {
  factory $JoinInfoParentAPIModelCopyWith(JoinInfoParentAPIModel value,
          $Res Function(JoinInfoParentAPIModel) then) =
      _$JoinInfoParentAPIModelCopyWithImpl<$Res, JoinInfoParentAPIModel>;
  @useResult
  $Res call({JoinInfoAPIModel joinInfo});

  $JoinInfoAPIModelCopyWith<$Res> get joinInfo;
}

/// @nodoc
class _$JoinInfoParentAPIModelCopyWithImpl<$Res,
        $Val extends JoinInfoParentAPIModel>
    implements $JoinInfoParentAPIModelCopyWith<$Res> {
  _$JoinInfoParentAPIModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? joinInfo = null,
  }) {
    return _then(_value.copyWith(
      joinInfo: null == joinInfo
          ? _value.joinInfo
          : joinInfo // ignore: cast_nullable_to_non_nullable
              as JoinInfoAPIModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JoinInfoAPIModelCopyWith<$Res> get joinInfo {
    return $JoinInfoAPIModelCopyWith<$Res>(_value.joinInfo, (value) {
      return _then(_value.copyWith(joinInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JoinInfoParentAPIModelImplCopyWith<$Res>
    implements $JoinInfoParentAPIModelCopyWith<$Res> {
  factory _$$JoinInfoParentAPIModelImplCopyWith(
          _$JoinInfoParentAPIModelImpl value,
          $Res Function(_$JoinInfoParentAPIModelImpl) then) =
      __$$JoinInfoParentAPIModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({JoinInfoAPIModel joinInfo});

  @override
  $JoinInfoAPIModelCopyWith<$Res> get joinInfo;
}

/// @nodoc
class __$$JoinInfoParentAPIModelImplCopyWithImpl<$Res>
    extends _$JoinInfoParentAPIModelCopyWithImpl<$Res,
        _$JoinInfoParentAPIModelImpl>
    implements _$$JoinInfoParentAPIModelImplCopyWith<$Res> {
  __$$JoinInfoParentAPIModelImplCopyWithImpl(
      _$JoinInfoParentAPIModelImpl _value,
      $Res Function(_$JoinInfoParentAPIModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? joinInfo = null,
  }) {
    return _then(_$JoinInfoParentAPIModelImpl(
      joinInfo: null == joinInfo
          ? _value.joinInfo
          : joinInfo // ignore: cast_nullable_to_non_nullable
              as JoinInfoAPIModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$JoinInfoParentAPIModelImpl implements _JoinInfoParentAPIModel {
  const _$JoinInfoParentAPIModelImpl({required this.joinInfo});

  factory _$JoinInfoParentAPIModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinInfoParentAPIModelImplFromJson(json);

  @override
  final JoinInfoAPIModel joinInfo;

  @override
  String toString() {
    return 'JoinInfoParentAPIModel(joinInfo: $joinInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinInfoParentAPIModelImpl &&
            (identical(other.joinInfo, joinInfo) ||
                other.joinInfo == joinInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, joinInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinInfoParentAPIModelImplCopyWith<_$JoinInfoParentAPIModelImpl>
      get copyWith => __$$JoinInfoParentAPIModelImplCopyWithImpl<
          _$JoinInfoParentAPIModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinInfoParentAPIModelImplToJson(
      this,
    );
  }
}

abstract class _JoinInfoParentAPIModel implements JoinInfoParentAPIModel {
  const factory _JoinInfoParentAPIModel(
          {required final JoinInfoAPIModel joinInfo}) =
      _$JoinInfoParentAPIModelImpl;

  factory _JoinInfoParentAPIModel.fromJson(Map<String, dynamic> json) =
      _$JoinInfoParentAPIModelImpl.fromJson;

  @override
  JoinInfoAPIModel get joinInfo;
  @override
  @JsonKey(ignore: true)
  _$$JoinInfoParentAPIModelImplCopyWith<_$JoinInfoParentAPIModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

JoinInfoAPIModel _$JoinInfoAPIModelFromJson(Map<String, dynamic> json) {
  return _JoinInfoAPIModel.fromJson(json);
}

/// @nodoc
mixin _$JoinInfoAPIModel {
  MeetingWrapperModel get meeting => throw _privateConstructorUsedError;
  AttendeeWrapperModel get attendee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinInfoAPIModelCopyWith<JoinInfoAPIModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinInfoAPIModelCopyWith<$Res> {
  factory $JoinInfoAPIModelCopyWith(
          JoinInfoAPIModel value, $Res Function(JoinInfoAPIModel) then) =
      _$JoinInfoAPIModelCopyWithImpl<$Res, JoinInfoAPIModel>;
  @useResult
  $Res call({MeetingWrapperModel meeting, AttendeeWrapperModel attendee});

  $MeetingWrapperModelCopyWith<$Res> get meeting;
  $AttendeeWrapperModelCopyWith<$Res> get attendee;
}

/// @nodoc
class _$JoinInfoAPIModelCopyWithImpl<$Res, $Val extends JoinInfoAPIModel>
    implements $JoinInfoAPIModelCopyWith<$Res> {
  _$JoinInfoAPIModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meeting = null,
    Object? attendee = null,
  }) {
    return _then(_value.copyWith(
      meeting: null == meeting
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as MeetingWrapperModel,
      attendee: null == attendee
          ? _value.attendee
          : attendee // ignore: cast_nullable_to_non_nullable
              as AttendeeWrapperModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MeetingWrapperModelCopyWith<$Res> get meeting {
    return $MeetingWrapperModelCopyWith<$Res>(_value.meeting, (value) {
      return _then(_value.copyWith(meeting: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AttendeeWrapperModelCopyWith<$Res> get attendee {
    return $AttendeeWrapperModelCopyWith<$Res>(_value.attendee, (value) {
      return _then(_value.copyWith(attendee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JoinInfoAPIModelImplCopyWith<$Res>
    implements $JoinInfoAPIModelCopyWith<$Res> {
  factory _$$JoinInfoAPIModelImplCopyWith(_$JoinInfoAPIModelImpl value,
          $Res Function(_$JoinInfoAPIModelImpl) then) =
      __$$JoinInfoAPIModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MeetingWrapperModel meeting, AttendeeWrapperModel attendee});

  @override
  $MeetingWrapperModelCopyWith<$Res> get meeting;
  @override
  $AttendeeWrapperModelCopyWith<$Res> get attendee;
}

/// @nodoc
class __$$JoinInfoAPIModelImplCopyWithImpl<$Res>
    extends _$JoinInfoAPIModelCopyWithImpl<$Res, _$JoinInfoAPIModelImpl>
    implements _$$JoinInfoAPIModelImplCopyWith<$Res> {
  __$$JoinInfoAPIModelImplCopyWithImpl(_$JoinInfoAPIModelImpl _value,
      $Res Function(_$JoinInfoAPIModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meeting = null,
    Object? attendee = null,
  }) {
    return _then(_$JoinInfoAPIModelImpl(
      meeting: null == meeting
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as MeetingWrapperModel,
      attendee: null == attendee
          ? _value.attendee
          : attendee // ignore: cast_nullable_to_non_nullable
              as AttendeeWrapperModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$JoinInfoAPIModelImpl implements _JoinInfoAPIModel {
  const _$JoinInfoAPIModelImpl({required this.meeting, required this.attendee});

  factory _$JoinInfoAPIModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinInfoAPIModelImplFromJson(json);

  @override
  final MeetingWrapperModel meeting;
  @override
  final AttendeeWrapperModel attendee;

  @override
  String toString() {
    return 'JoinInfoAPIModel(meeting: $meeting, attendee: $attendee)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinInfoAPIModelImpl &&
            (identical(other.meeting, meeting) || other.meeting == meeting) &&
            (identical(other.attendee, attendee) ||
                other.attendee == attendee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, meeting, attendee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinInfoAPIModelImplCopyWith<_$JoinInfoAPIModelImpl> get copyWith =>
      __$$JoinInfoAPIModelImplCopyWithImpl<_$JoinInfoAPIModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinInfoAPIModelImplToJson(
      this,
    );
  }
}

abstract class _JoinInfoAPIModel implements JoinInfoAPIModel {
  const factory _JoinInfoAPIModel(
      {required final MeetingWrapperModel meeting,
      required final AttendeeWrapperModel attendee}) = _$JoinInfoAPIModelImpl;

  factory _JoinInfoAPIModel.fromJson(Map<String, dynamic> json) =
      _$JoinInfoAPIModelImpl.fromJson;

  @override
  MeetingWrapperModel get meeting;
  @override
  AttendeeWrapperModel get attendee;
  @override
  @JsonKey(ignore: true)
  _$$JoinInfoAPIModelImplCopyWith<_$JoinInfoAPIModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MeetingWrapperModel _$MeetingWrapperModelFromJson(Map<String, dynamic> json) {
  return _MeetingWrapperModel.fromJson(json);
}

/// @nodoc
mixin _$MeetingWrapperModel {
  MeetingAPIModel get meeting => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetingWrapperModelCopyWith<MeetingWrapperModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingWrapperModelCopyWith<$Res> {
  factory $MeetingWrapperModelCopyWith(
          MeetingWrapperModel value, $Res Function(MeetingWrapperModel) then) =
      _$MeetingWrapperModelCopyWithImpl<$Res, MeetingWrapperModel>;
  @useResult
  $Res call({MeetingAPIModel meeting});

  $MeetingAPIModelCopyWith<$Res> get meeting;
}

/// @nodoc
class _$MeetingWrapperModelCopyWithImpl<$Res, $Val extends MeetingWrapperModel>
    implements $MeetingWrapperModelCopyWith<$Res> {
  _$MeetingWrapperModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meeting = null,
  }) {
    return _then(_value.copyWith(
      meeting: null == meeting
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as MeetingAPIModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MeetingAPIModelCopyWith<$Res> get meeting {
    return $MeetingAPIModelCopyWith<$Res>(_value.meeting, (value) {
      return _then(_value.copyWith(meeting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MeetingWrapperModelImplCopyWith<$Res>
    implements $MeetingWrapperModelCopyWith<$Res> {
  factory _$$MeetingWrapperModelImplCopyWith(_$MeetingWrapperModelImpl value,
          $Res Function(_$MeetingWrapperModelImpl) then) =
      __$$MeetingWrapperModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MeetingAPIModel meeting});

  @override
  $MeetingAPIModelCopyWith<$Res> get meeting;
}

/// @nodoc
class __$$MeetingWrapperModelImplCopyWithImpl<$Res>
    extends _$MeetingWrapperModelCopyWithImpl<$Res, _$MeetingWrapperModelImpl>
    implements _$$MeetingWrapperModelImplCopyWith<$Res> {
  __$$MeetingWrapperModelImplCopyWithImpl(_$MeetingWrapperModelImpl _value,
      $Res Function(_$MeetingWrapperModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meeting = null,
  }) {
    return _then(_$MeetingWrapperModelImpl(
      meeting: null == meeting
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as MeetingAPIModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$MeetingWrapperModelImpl implements _MeetingWrapperModel {
  const _$MeetingWrapperModelImpl({required this.meeting});

  factory _$MeetingWrapperModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetingWrapperModelImplFromJson(json);

  @override
  final MeetingAPIModel meeting;

  @override
  String toString() {
    return 'MeetingWrapperModel(meeting: $meeting)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingWrapperModelImpl &&
            (identical(other.meeting, meeting) || other.meeting == meeting));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, meeting);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetingWrapperModelImplCopyWith<_$MeetingWrapperModelImpl> get copyWith =>
      __$$MeetingWrapperModelImplCopyWithImpl<_$MeetingWrapperModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingWrapperModelImplToJson(
      this,
    );
  }
}

abstract class _MeetingWrapperModel implements MeetingWrapperModel {
  const factory _MeetingWrapperModel({required final MeetingAPIModel meeting}) =
      _$MeetingWrapperModelImpl;

  factory _MeetingWrapperModel.fromJson(Map<String, dynamic> json) =
      _$MeetingWrapperModelImpl.fromJson;

  @override
  MeetingAPIModel get meeting;
  @override
  @JsonKey(ignore: true)
  _$$MeetingWrapperModelImplCopyWith<_$MeetingWrapperModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MeetingAPIModel _$MeetingAPIModelFromJson(Map<String, dynamic> json) {
  return _MeetingAPIModel.fromJson(json);
}

/// @nodoc
mixin _$MeetingAPIModel {
  String get meetingId => throw _privateConstructorUsedError;
  String get externalMeetingId => throw _privateConstructorUsedError;
  String get mediaRegion => throw _privateConstructorUsedError;
  MediaPlacementAPIModel get mediaPlacement =>
      throw _privateConstructorUsedError;
  List<dynamic> get tenantIds => throw _privateConstructorUsedError;
  String get meetingArn => throw _privateConstructorUsedError;
  String? get meetingHostId => throw _privateConstructorUsedError;
  String? get primaryMeetingId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetingAPIModelCopyWith<MeetingAPIModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingAPIModelCopyWith<$Res> {
  factory $MeetingAPIModelCopyWith(
          MeetingAPIModel value, $Res Function(MeetingAPIModel) then) =
      _$MeetingAPIModelCopyWithImpl<$Res, MeetingAPIModel>;
  @useResult
  $Res call(
      {String meetingId,
      String externalMeetingId,
      String mediaRegion,
      MediaPlacementAPIModel mediaPlacement,
      List<dynamic> tenantIds,
      String meetingArn,
      String? meetingHostId,
      String? primaryMeetingId});

  $MediaPlacementAPIModelCopyWith<$Res> get mediaPlacement;
}

/// @nodoc
class _$MeetingAPIModelCopyWithImpl<$Res, $Val extends MeetingAPIModel>
    implements $MeetingAPIModelCopyWith<$Res> {
  _$MeetingAPIModelCopyWithImpl(this._value, this._then);

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
    Object? tenantIds = null,
    Object? meetingArn = null,
    Object? meetingHostId = freezed,
    Object? primaryMeetingId = freezed,
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
              as MediaPlacementAPIModel,
      tenantIds: null == tenantIds
          ? _value.tenantIds
          : tenantIds // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      meetingArn: null == meetingArn
          ? _value.meetingArn
          : meetingArn // ignore: cast_nullable_to_non_nullable
              as String,
      meetingHostId: freezed == meetingHostId
          ? _value.meetingHostId
          : meetingHostId // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryMeetingId: freezed == primaryMeetingId
          ? _value.primaryMeetingId
          : primaryMeetingId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MediaPlacementAPIModelCopyWith<$Res> get mediaPlacement {
    return $MediaPlacementAPIModelCopyWith<$Res>(_value.mediaPlacement,
        (value) {
      return _then(_value.copyWith(mediaPlacement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MeetingAPIModelImplCopyWith<$Res>
    implements $MeetingAPIModelCopyWith<$Res> {
  factory _$$MeetingAPIModelImplCopyWith(_$MeetingAPIModelImpl value,
          $Res Function(_$MeetingAPIModelImpl) then) =
      __$$MeetingAPIModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String meetingId,
      String externalMeetingId,
      String mediaRegion,
      MediaPlacementAPIModel mediaPlacement,
      List<dynamic> tenantIds,
      String meetingArn,
      String? meetingHostId,
      String? primaryMeetingId});

  @override
  $MediaPlacementAPIModelCopyWith<$Res> get mediaPlacement;
}

/// @nodoc
class __$$MeetingAPIModelImplCopyWithImpl<$Res>
    extends _$MeetingAPIModelCopyWithImpl<$Res, _$MeetingAPIModelImpl>
    implements _$$MeetingAPIModelImplCopyWith<$Res> {
  __$$MeetingAPIModelImplCopyWithImpl(
      _$MeetingAPIModelImpl _value, $Res Function(_$MeetingAPIModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? externalMeetingId = null,
    Object? mediaRegion = null,
    Object? mediaPlacement = null,
    Object? tenantIds = null,
    Object? meetingArn = null,
    Object? meetingHostId = freezed,
    Object? primaryMeetingId = freezed,
  }) {
    return _then(_$MeetingAPIModelImpl(
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
              as MediaPlacementAPIModel,
      tenantIds: null == tenantIds
          ? _value._tenantIds
          : tenantIds // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      meetingArn: null == meetingArn
          ? _value.meetingArn
          : meetingArn // ignore: cast_nullable_to_non_nullable
              as String,
      meetingHostId: freezed == meetingHostId
          ? _value.meetingHostId
          : meetingHostId // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryMeetingId: freezed == primaryMeetingId
          ? _value.primaryMeetingId
          : primaryMeetingId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$MeetingAPIModelImpl implements _MeetingAPIModel {
  const _$MeetingAPIModelImpl(
      {required this.meetingId,
      required this.externalMeetingId,
      required this.mediaRegion,
      required this.mediaPlacement,
      required final List<dynamic> tenantIds,
      required this.meetingArn,
      this.meetingHostId,
      this.primaryMeetingId})
      : _tenantIds = tenantIds;

  factory _$MeetingAPIModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetingAPIModelImplFromJson(json);

  @override
  final String meetingId;
  @override
  final String externalMeetingId;
  @override
  final String mediaRegion;
  @override
  final MediaPlacementAPIModel mediaPlacement;
  final List<dynamic> _tenantIds;
  @override
  List<dynamic> get tenantIds {
    if (_tenantIds is EqualUnmodifiableListView) return _tenantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tenantIds);
  }

  @override
  final String meetingArn;
  @override
  final String? meetingHostId;
  @override
  final String? primaryMeetingId;

  @override
  String toString() {
    return 'MeetingAPIModel(meetingId: $meetingId, externalMeetingId: $externalMeetingId, mediaRegion: $mediaRegion, mediaPlacement: $mediaPlacement, tenantIds: $tenantIds, meetingArn: $meetingArn, meetingHostId: $meetingHostId, primaryMeetingId: $primaryMeetingId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingAPIModelImpl &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.externalMeetingId, externalMeetingId) ||
                other.externalMeetingId == externalMeetingId) &&
            (identical(other.mediaRegion, mediaRegion) ||
                other.mediaRegion == mediaRegion) &&
            (identical(other.mediaPlacement, mediaPlacement) ||
                other.mediaPlacement == mediaPlacement) &&
            const DeepCollectionEquality()
                .equals(other._tenantIds, _tenantIds) &&
            (identical(other.meetingArn, meetingArn) ||
                other.meetingArn == meetingArn) &&
            (identical(other.meetingHostId, meetingHostId) ||
                other.meetingHostId == meetingHostId) &&
            (identical(other.primaryMeetingId, primaryMeetingId) ||
                other.primaryMeetingId == primaryMeetingId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      meetingId,
      externalMeetingId,
      mediaRegion,
      mediaPlacement,
      const DeepCollectionEquality().hash(_tenantIds),
      meetingArn,
      meetingHostId,
      primaryMeetingId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetingAPIModelImplCopyWith<_$MeetingAPIModelImpl> get copyWith =>
      __$$MeetingAPIModelImplCopyWithImpl<_$MeetingAPIModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingAPIModelImplToJson(
      this,
    );
  }
}

abstract class _MeetingAPIModel implements MeetingAPIModel {
  const factory _MeetingAPIModel(
      {required final String meetingId,
      required final String externalMeetingId,
      required final String mediaRegion,
      required final MediaPlacementAPIModel mediaPlacement,
      required final List<dynamic> tenantIds,
      required final String meetingArn,
      final String? meetingHostId,
      final String? primaryMeetingId}) = _$MeetingAPIModelImpl;

  factory _MeetingAPIModel.fromJson(Map<String, dynamic> json) =
      _$MeetingAPIModelImpl.fromJson;

  @override
  String get meetingId;
  @override
  String get externalMeetingId;
  @override
  String get mediaRegion;
  @override
  MediaPlacementAPIModel get mediaPlacement;
  @override
  List<dynamic> get tenantIds;
  @override
  String get meetingArn;
  @override
  String? get meetingHostId;
  @override
  String? get primaryMeetingId;
  @override
  @JsonKey(ignore: true)
  _$$MeetingAPIModelImplCopyWith<_$MeetingAPIModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MediaPlacementAPIModel _$MediaPlacementAPIModelFromJson(
    Map<String, dynamic> json) {
  return _MediaPlacementAPIModel.fromJson(json);
}

/// @nodoc
mixin _$MediaPlacementAPIModel {
  String get audioHostUrl => throw _privateConstructorUsedError;
  String get audioFallbackUrl => throw _privateConstructorUsedError;
  String get signalingUrl => throw _privateConstructorUsedError;
  String get turnControlUrl => throw _privateConstructorUsedError;
  String get screenDataUrl => throw _privateConstructorUsedError;
  String get screenViewingUrl => throw _privateConstructorUsedError;
  String get screenSharingUrl => throw _privateConstructorUsedError;
  String get eventIngestionUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaPlacementAPIModelCopyWith<MediaPlacementAPIModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaPlacementAPIModelCopyWith<$Res> {
  factory $MediaPlacementAPIModelCopyWith(MediaPlacementAPIModel value,
          $Res Function(MediaPlacementAPIModel) then) =
      _$MediaPlacementAPIModelCopyWithImpl<$Res, MediaPlacementAPIModel>;
  @useResult
  $Res call(
      {String audioHostUrl,
      String audioFallbackUrl,
      String signalingUrl,
      String turnControlUrl,
      String screenDataUrl,
      String screenViewingUrl,
      String screenSharingUrl,
      String eventIngestionUrl});
}

/// @nodoc
class _$MediaPlacementAPIModelCopyWithImpl<$Res,
        $Val extends MediaPlacementAPIModel>
    implements $MediaPlacementAPIModelCopyWith<$Res> {
  _$MediaPlacementAPIModelCopyWithImpl(this._value, this._then);

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
    Object? turnControlUrl = null,
    Object? screenDataUrl = null,
    Object? screenViewingUrl = null,
    Object? screenSharingUrl = null,
    Object? eventIngestionUrl = null,
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
      turnControlUrl: null == turnControlUrl
          ? _value.turnControlUrl
          : turnControlUrl // ignore: cast_nullable_to_non_nullable
              as String,
      screenDataUrl: null == screenDataUrl
          ? _value.screenDataUrl
          : screenDataUrl // ignore: cast_nullable_to_non_nullable
              as String,
      screenViewingUrl: null == screenViewingUrl
          ? _value.screenViewingUrl
          : screenViewingUrl // ignore: cast_nullable_to_non_nullable
              as String,
      screenSharingUrl: null == screenSharingUrl
          ? _value.screenSharingUrl
          : screenSharingUrl // ignore: cast_nullable_to_non_nullable
              as String,
      eventIngestionUrl: null == eventIngestionUrl
          ? _value.eventIngestionUrl
          : eventIngestionUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaPlacementAPIModelImplCopyWith<$Res>
    implements $MediaPlacementAPIModelCopyWith<$Res> {
  factory _$$MediaPlacementAPIModelImplCopyWith(
          _$MediaPlacementAPIModelImpl value,
          $Res Function(_$MediaPlacementAPIModelImpl) then) =
      __$$MediaPlacementAPIModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String audioHostUrl,
      String audioFallbackUrl,
      String signalingUrl,
      String turnControlUrl,
      String screenDataUrl,
      String screenViewingUrl,
      String screenSharingUrl,
      String eventIngestionUrl});
}

/// @nodoc
class __$$MediaPlacementAPIModelImplCopyWithImpl<$Res>
    extends _$MediaPlacementAPIModelCopyWithImpl<$Res,
        _$MediaPlacementAPIModelImpl>
    implements _$$MediaPlacementAPIModelImplCopyWith<$Res> {
  __$$MediaPlacementAPIModelImplCopyWithImpl(
      _$MediaPlacementAPIModelImpl _value,
      $Res Function(_$MediaPlacementAPIModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioHostUrl = null,
    Object? audioFallbackUrl = null,
    Object? signalingUrl = null,
    Object? turnControlUrl = null,
    Object? screenDataUrl = null,
    Object? screenViewingUrl = null,
    Object? screenSharingUrl = null,
    Object? eventIngestionUrl = null,
  }) {
    return _then(_$MediaPlacementAPIModelImpl(
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
      turnControlUrl: null == turnControlUrl
          ? _value.turnControlUrl
          : turnControlUrl // ignore: cast_nullable_to_non_nullable
              as String,
      screenDataUrl: null == screenDataUrl
          ? _value.screenDataUrl
          : screenDataUrl // ignore: cast_nullable_to_non_nullable
              as String,
      screenViewingUrl: null == screenViewingUrl
          ? _value.screenViewingUrl
          : screenViewingUrl // ignore: cast_nullable_to_non_nullable
              as String,
      screenSharingUrl: null == screenSharingUrl
          ? _value.screenSharingUrl
          : screenSharingUrl // ignore: cast_nullable_to_non_nullable
              as String,
      eventIngestionUrl: null == eventIngestionUrl
          ? _value.eventIngestionUrl
          : eventIngestionUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$MediaPlacementAPIModelImpl implements _MediaPlacementAPIModel {
  const _$MediaPlacementAPIModelImpl(
      {required this.audioHostUrl,
      required this.audioFallbackUrl,
      required this.signalingUrl,
      required this.turnControlUrl,
      required this.screenDataUrl,
      required this.screenViewingUrl,
      required this.screenSharingUrl,
      required this.eventIngestionUrl});

  factory _$MediaPlacementAPIModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaPlacementAPIModelImplFromJson(json);

  @override
  final String audioHostUrl;
  @override
  final String audioFallbackUrl;
  @override
  final String signalingUrl;
  @override
  final String turnControlUrl;
  @override
  final String screenDataUrl;
  @override
  final String screenViewingUrl;
  @override
  final String screenSharingUrl;
  @override
  final String eventIngestionUrl;

  @override
  String toString() {
    return 'MediaPlacementAPIModel(audioHostUrl: $audioHostUrl, audioFallbackUrl: $audioFallbackUrl, signalingUrl: $signalingUrl, turnControlUrl: $turnControlUrl, screenDataUrl: $screenDataUrl, screenViewingUrl: $screenViewingUrl, screenSharingUrl: $screenSharingUrl, eventIngestionUrl: $eventIngestionUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaPlacementAPIModelImpl &&
            (identical(other.audioHostUrl, audioHostUrl) ||
                other.audioHostUrl == audioHostUrl) &&
            (identical(other.audioFallbackUrl, audioFallbackUrl) ||
                other.audioFallbackUrl == audioFallbackUrl) &&
            (identical(other.signalingUrl, signalingUrl) ||
                other.signalingUrl == signalingUrl) &&
            (identical(other.turnControlUrl, turnControlUrl) ||
                other.turnControlUrl == turnControlUrl) &&
            (identical(other.screenDataUrl, screenDataUrl) ||
                other.screenDataUrl == screenDataUrl) &&
            (identical(other.screenViewingUrl, screenViewingUrl) ||
                other.screenViewingUrl == screenViewingUrl) &&
            (identical(other.screenSharingUrl, screenSharingUrl) ||
                other.screenSharingUrl == screenSharingUrl) &&
            (identical(other.eventIngestionUrl, eventIngestionUrl) ||
                other.eventIngestionUrl == eventIngestionUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      audioHostUrl,
      audioFallbackUrl,
      signalingUrl,
      turnControlUrl,
      screenDataUrl,
      screenViewingUrl,
      screenSharingUrl,
      eventIngestionUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaPlacementAPIModelImplCopyWith<_$MediaPlacementAPIModelImpl>
      get copyWith => __$$MediaPlacementAPIModelImplCopyWithImpl<
          _$MediaPlacementAPIModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaPlacementAPIModelImplToJson(
      this,
    );
  }
}

abstract class _MediaPlacementAPIModel implements MediaPlacementAPIModel {
  const factory _MediaPlacementAPIModel(
      {required final String audioHostUrl,
      required final String audioFallbackUrl,
      required final String signalingUrl,
      required final String turnControlUrl,
      required final String screenDataUrl,
      required final String screenViewingUrl,
      required final String screenSharingUrl,
      required final String eventIngestionUrl}) = _$MediaPlacementAPIModelImpl;

  factory _MediaPlacementAPIModel.fromJson(Map<String, dynamic> json) =
      _$MediaPlacementAPIModelImpl.fromJson;

  @override
  String get audioHostUrl;
  @override
  String get audioFallbackUrl;
  @override
  String get signalingUrl;
  @override
  String get turnControlUrl;
  @override
  String get screenDataUrl;
  @override
  String get screenViewingUrl;
  @override
  String get screenSharingUrl;
  @override
  String get eventIngestionUrl;
  @override
  @JsonKey(ignore: true)
  _$$MediaPlacementAPIModelImplCopyWith<_$MediaPlacementAPIModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AttendeeWrapperModel _$AttendeeWrapperModelFromJson(Map<String, dynamic> json) {
  return _AttendeeWrapperModel.fromJson(json);
}

/// @nodoc
mixin _$AttendeeWrapperModel {
  AttendeeAPIModel get attendee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendeeWrapperModelCopyWith<AttendeeWrapperModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendeeWrapperModelCopyWith<$Res> {
  factory $AttendeeWrapperModelCopyWith(AttendeeWrapperModel value,
          $Res Function(AttendeeWrapperModel) then) =
      _$AttendeeWrapperModelCopyWithImpl<$Res, AttendeeWrapperModel>;
  @useResult
  $Res call({AttendeeAPIModel attendee});

  $AttendeeAPIModelCopyWith<$Res> get attendee;
}

/// @nodoc
class _$AttendeeWrapperModelCopyWithImpl<$Res,
        $Val extends AttendeeWrapperModel>
    implements $AttendeeWrapperModelCopyWith<$Res> {
  _$AttendeeWrapperModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendee = null,
  }) {
    return _then(_value.copyWith(
      attendee: null == attendee
          ? _value.attendee
          : attendee // ignore: cast_nullable_to_non_nullable
              as AttendeeAPIModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AttendeeAPIModelCopyWith<$Res> get attendee {
    return $AttendeeAPIModelCopyWith<$Res>(_value.attendee, (value) {
      return _then(_value.copyWith(attendee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AttendeeWrapperModelImplCopyWith<$Res>
    implements $AttendeeWrapperModelCopyWith<$Res> {
  factory _$$AttendeeWrapperModelImplCopyWith(_$AttendeeWrapperModelImpl value,
          $Res Function(_$AttendeeWrapperModelImpl) then) =
      __$$AttendeeWrapperModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AttendeeAPIModel attendee});

  @override
  $AttendeeAPIModelCopyWith<$Res> get attendee;
}

/// @nodoc
class __$$AttendeeWrapperModelImplCopyWithImpl<$Res>
    extends _$AttendeeWrapperModelCopyWithImpl<$Res, _$AttendeeWrapperModelImpl>
    implements _$$AttendeeWrapperModelImplCopyWith<$Res> {
  __$$AttendeeWrapperModelImplCopyWithImpl(_$AttendeeWrapperModelImpl _value,
      $Res Function(_$AttendeeWrapperModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendee = null,
  }) {
    return _then(_$AttendeeWrapperModelImpl(
      attendee: null == attendee
          ? _value.attendee
          : attendee // ignore: cast_nullable_to_non_nullable
              as AttendeeAPIModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$AttendeeWrapperModelImpl implements _AttendeeWrapperModel {
  const _$AttendeeWrapperModelImpl({required this.attendee});

  factory _$AttendeeWrapperModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendeeWrapperModelImplFromJson(json);

  @override
  final AttendeeAPIModel attendee;

  @override
  String toString() {
    return 'AttendeeWrapperModel(attendee: $attendee)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendeeWrapperModelImpl &&
            (identical(other.attendee, attendee) ||
                other.attendee == attendee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, attendee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendeeWrapperModelImplCopyWith<_$AttendeeWrapperModelImpl>
      get copyWith =>
          __$$AttendeeWrapperModelImplCopyWithImpl<_$AttendeeWrapperModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendeeWrapperModelImplToJson(
      this,
    );
  }
}

abstract class _AttendeeWrapperModel implements AttendeeWrapperModel {
  const factory _AttendeeWrapperModel(
      {required final AttendeeAPIModel attendee}) = _$AttendeeWrapperModelImpl;

  factory _AttendeeWrapperModel.fromJson(Map<String, dynamic> json) =
      _$AttendeeWrapperModelImpl.fromJson;

  @override
  AttendeeAPIModel get attendee;
  @override
  @JsonKey(ignore: true)
  _$$AttendeeWrapperModelImplCopyWith<_$AttendeeWrapperModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AttendeeAPIModel _$AttendeeAPIModelFromJson(Map<String, dynamic> json) {
  return _AttendeeAPIModel.fromJson(json);
}

/// @nodoc
mixin _$AttendeeAPIModel {
  String get externalUserId => throw _privateConstructorUsedError;
  String get attendeeId => throw _privateConstructorUsedError;
  String get joinToken => throw _privateConstructorUsedError;
  CapabilitiesAPIModel get capabilities => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendeeAPIModelCopyWith<AttendeeAPIModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendeeAPIModelCopyWith<$Res> {
  factory $AttendeeAPIModelCopyWith(
          AttendeeAPIModel value, $Res Function(AttendeeAPIModel) then) =
      _$AttendeeAPIModelCopyWithImpl<$Res, AttendeeAPIModel>;
  @useResult
  $Res call(
      {String externalUserId,
      String attendeeId,
      String joinToken,
      CapabilitiesAPIModel capabilities});

  $CapabilitiesAPIModelCopyWith<$Res> get capabilities;
}

/// @nodoc
class _$AttendeeAPIModelCopyWithImpl<$Res, $Val extends AttendeeAPIModel>
    implements $AttendeeAPIModelCopyWith<$Res> {
  _$AttendeeAPIModelCopyWithImpl(this._value, this._then);

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
    Object? capabilities = null,
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
      capabilities: null == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as CapabilitiesAPIModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CapabilitiesAPIModelCopyWith<$Res> get capabilities {
    return $CapabilitiesAPIModelCopyWith<$Res>(_value.capabilities, (value) {
      return _then(_value.copyWith(capabilities: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AttendeeAPIModelImplCopyWith<$Res>
    implements $AttendeeAPIModelCopyWith<$Res> {
  factory _$$AttendeeAPIModelImplCopyWith(_$AttendeeAPIModelImpl value,
          $Res Function(_$AttendeeAPIModelImpl) then) =
      __$$AttendeeAPIModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String externalUserId,
      String attendeeId,
      String joinToken,
      CapabilitiesAPIModel capabilities});

  @override
  $CapabilitiesAPIModelCopyWith<$Res> get capabilities;
}

/// @nodoc
class __$$AttendeeAPIModelImplCopyWithImpl<$Res>
    extends _$AttendeeAPIModelCopyWithImpl<$Res, _$AttendeeAPIModelImpl>
    implements _$$AttendeeAPIModelImplCopyWith<$Res> {
  __$$AttendeeAPIModelImplCopyWithImpl(_$AttendeeAPIModelImpl _value,
      $Res Function(_$AttendeeAPIModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalUserId = null,
    Object? attendeeId = null,
    Object? joinToken = null,
    Object? capabilities = null,
  }) {
    return _then(_$AttendeeAPIModelImpl(
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
      capabilities: null == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as CapabilitiesAPIModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$AttendeeAPIModelImpl implements _AttendeeAPIModel {
  const _$AttendeeAPIModelImpl(
      {required this.externalUserId,
      required this.attendeeId,
      required this.joinToken,
      required this.capabilities});

  factory _$AttendeeAPIModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendeeAPIModelImplFromJson(json);

  @override
  final String externalUserId;
  @override
  final String attendeeId;
  @override
  final String joinToken;
  @override
  final CapabilitiesAPIModel capabilities;

  @override
  String toString() {
    return 'AttendeeAPIModel(externalUserId: $externalUserId, attendeeId: $attendeeId, joinToken: $joinToken, capabilities: $capabilities)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendeeAPIModelImpl &&
            (identical(other.externalUserId, externalUserId) ||
                other.externalUserId == externalUserId) &&
            (identical(other.attendeeId, attendeeId) ||
                other.attendeeId == attendeeId) &&
            (identical(other.joinToken, joinToken) ||
                other.joinToken == joinToken) &&
            (identical(other.capabilities, capabilities) ||
                other.capabilities == capabilities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, externalUserId, attendeeId, joinToken, capabilities);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendeeAPIModelImplCopyWith<_$AttendeeAPIModelImpl> get copyWith =>
      __$$AttendeeAPIModelImplCopyWithImpl<_$AttendeeAPIModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendeeAPIModelImplToJson(
      this,
    );
  }
}

abstract class _AttendeeAPIModel implements AttendeeAPIModel {
  const factory _AttendeeAPIModel(
          {required final String externalUserId,
          required final String attendeeId,
          required final String joinToken,
          required final CapabilitiesAPIModel capabilities}) =
      _$AttendeeAPIModelImpl;

  factory _AttendeeAPIModel.fromJson(Map<String, dynamic> json) =
      _$AttendeeAPIModelImpl.fromJson;

  @override
  String get externalUserId;
  @override
  String get attendeeId;
  @override
  String get joinToken;
  @override
  CapabilitiesAPIModel get capabilities;
  @override
  @JsonKey(ignore: true)
  _$$AttendeeAPIModelImplCopyWith<_$AttendeeAPIModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CapabilitiesAPIModel _$CapabilitiesAPIModelFromJson(Map<String, dynamic> json) {
  return _CapabilitiesAPIModel.fromJson(json);
}

/// @nodoc
mixin _$CapabilitiesAPIModel {
  String get audio => throw _privateConstructorUsedError;
  String get video => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CapabilitiesAPIModelCopyWith<CapabilitiesAPIModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapabilitiesAPIModelCopyWith<$Res> {
  factory $CapabilitiesAPIModelCopyWith(CapabilitiesAPIModel value,
          $Res Function(CapabilitiesAPIModel) then) =
      _$CapabilitiesAPIModelCopyWithImpl<$Res, CapabilitiesAPIModel>;
  @useResult
  $Res call({String audio, String video, String content});
}

/// @nodoc
class _$CapabilitiesAPIModelCopyWithImpl<$Res,
        $Val extends CapabilitiesAPIModel>
    implements $CapabilitiesAPIModelCopyWith<$Res> {
  _$CapabilitiesAPIModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audio = null,
    Object? video = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      audio: null == audio
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as String,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CapabilitiesAPIModelImplCopyWith<$Res>
    implements $CapabilitiesAPIModelCopyWith<$Res> {
  factory _$$CapabilitiesAPIModelImplCopyWith(_$CapabilitiesAPIModelImpl value,
          $Res Function(_$CapabilitiesAPIModelImpl) then) =
      __$$CapabilitiesAPIModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String audio, String video, String content});
}

/// @nodoc
class __$$CapabilitiesAPIModelImplCopyWithImpl<$Res>
    extends _$CapabilitiesAPIModelCopyWithImpl<$Res, _$CapabilitiesAPIModelImpl>
    implements _$$CapabilitiesAPIModelImplCopyWith<$Res> {
  __$$CapabilitiesAPIModelImplCopyWithImpl(_$CapabilitiesAPIModelImpl _value,
      $Res Function(_$CapabilitiesAPIModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audio = null,
    Object? video = null,
    Object? content = null,
  }) {
    return _then(_$CapabilitiesAPIModelImpl(
      audio: null == audio
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as String,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$CapabilitiesAPIModelImpl implements _CapabilitiesAPIModel {
  const _$CapabilitiesAPIModelImpl(
      {required this.audio, required this.video, required this.content});

  factory _$CapabilitiesAPIModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CapabilitiesAPIModelImplFromJson(json);

  @override
  final String audio;
  @override
  final String video;
  @override
  final String content;

  @override
  String toString() {
    return 'CapabilitiesAPIModel(audio: $audio, video: $video, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapabilitiesAPIModelImpl &&
            (identical(other.audio, audio) || other.audio == audio) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, audio, video, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CapabilitiesAPIModelImplCopyWith<_$CapabilitiesAPIModelImpl>
      get copyWith =>
          __$$CapabilitiesAPIModelImplCopyWithImpl<_$CapabilitiesAPIModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CapabilitiesAPIModelImplToJson(
      this,
    );
  }
}

abstract class _CapabilitiesAPIModel implements CapabilitiesAPIModel {
  const factory _CapabilitiesAPIModel(
      {required final String audio,
      required final String video,
      required final String content}) = _$CapabilitiesAPIModelImpl;

  factory _CapabilitiesAPIModel.fromJson(Map<String, dynamic> json) =
      _$CapabilitiesAPIModelImpl.fromJson;

  @override
  String get audio;
  @override
  String get video;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$CapabilitiesAPIModelImplCopyWith<_$CapabilitiesAPIModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
