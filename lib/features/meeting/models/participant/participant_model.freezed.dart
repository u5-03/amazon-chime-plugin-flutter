// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) {
  return _ParticipantModel.fromJson(json);
}

/// @nodoc
mixin _$ParticipantModel {
  String get participantId => throw _privateConstructorUsedError;
  String get externalUserId => throw _privateConstructorUsedError;
  bool get muteStatus => throw _privateConstructorUsedError;
  bool get isVideoOn => throw _privateConstructorUsedError;
  VideoTileModel? get videoTile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParticipantModelCopyWith<ParticipantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParticipantModelCopyWith<$Res> {
  factory $ParticipantModelCopyWith(
          ParticipantModel value, $Res Function(ParticipantModel) then) =
      _$ParticipantModelCopyWithImpl<$Res, ParticipantModel>;
  @useResult
  $Res call(
      {String participantId,
      String externalUserId,
      bool muteStatus,
      bool isVideoOn,
      VideoTileModel? videoTile});

  $VideoTileModelCopyWith<$Res>? get videoTile;
}

/// @nodoc
class _$ParticipantModelCopyWithImpl<$Res, $Val extends ParticipantModel>
    implements $ParticipantModelCopyWith<$Res> {
  _$ParticipantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? participantId = null,
    Object? externalUserId = null,
    Object? muteStatus = null,
    Object? isVideoOn = null,
    Object? videoTile = freezed,
  }) {
    return _then(_value.copyWith(
      participantId: null == participantId
          ? _value.participantId
          : participantId // ignore: cast_nullable_to_non_nullable
              as String,
      externalUserId: null == externalUserId
          ? _value.externalUserId
          : externalUserId // ignore: cast_nullable_to_non_nullable
              as String,
      muteStatus: null == muteStatus
          ? _value.muteStatus
          : muteStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideoOn: null == isVideoOn
          ? _value.isVideoOn
          : isVideoOn // ignore: cast_nullable_to_non_nullable
              as bool,
      videoTile: freezed == videoTile
          ? _value.videoTile
          : videoTile // ignore: cast_nullable_to_non_nullable
              as VideoTileModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VideoTileModelCopyWith<$Res>? get videoTile {
    if (_value.videoTile == null) {
      return null;
    }

    return $VideoTileModelCopyWith<$Res>(_value.videoTile!, (value) {
      return _then(_value.copyWith(videoTile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ParticipantModelImplCopyWith<$Res>
    implements $ParticipantModelCopyWith<$Res> {
  factory _$$ParticipantModelImplCopyWith(_$ParticipantModelImpl value,
          $Res Function(_$ParticipantModelImpl) then) =
      __$$ParticipantModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String participantId,
      String externalUserId,
      bool muteStatus,
      bool isVideoOn,
      VideoTileModel? videoTile});

  @override
  $VideoTileModelCopyWith<$Res>? get videoTile;
}

/// @nodoc
class __$$ParticipantModelImplCopyWithImpl<$Res>
    extends _$ParticipantModelCopyWithImpl<$Res, _$ParticipantModelImpl>
    implements _$$ParticipantModelImplCopyWith<$Res> {
  __$$ParticipantModelImplCopyWithImpl(_$ParticipantModelImpl _value,
      $Res Function(_$ParticipantModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? participantId = null,
    Object? externalUserId = null,
    Object? muteStatus = null,
    Object? isVideoOn = null,
    Object? videoTile = freezed,
  }) {
    return _then(_$ParticipantModelImpl(
      participantId: null == participantId
          ? _value.participantId
          : participantId // ignore: cast_nullable_to_non_nullable
              as String,
      externalUserId: null == externalUserId
          ? _value.externalUserId
          : externalUserId // ignore: cast_nullable_to_non_nullable
              as String,
      muteStatus: null == muteStatus
          ? _value.muteStatus
          : muteStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideoOn: null == isVideoOn
          ? _value.isVideoOn
          : isVideoOn // ignore: cast_nullable_to_non_nullable
              as bool,
      videoTile: freezed == videoTile
          ? _value.videoTile
          : videoTile // ignore: cast_nullable_to_non_nullable
              as VideoTileModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParticipantModelImpl implements _ParticipantModel {
  const _$ParticipantModelImpl(
      {required this.participantId,
      required this.externalUserId,
      this.muteStatus = false,
      this.isVideoOn = false,
      this.videoTile});

  factory _$ParticipantModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParticipantModelImplFromJson(json);

  @override
  final String participantId;
  @override
  final String externalUserId;
  @override
  @JsonKey()
  final bool muteStatus;
  @override
  @JsonKey()
  final bool isVideoOn;
  @override
  final VideoTileModel? videoTile;

  @override
  String toString() {
    return 'ParticipantModel(participantId: $participantId, externalUserId: $externalUserId, muteStatus: $muteStatus, isVideoOn: $isVideoOn, videoTile: $videoTile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParticipantModelImpl &&
            (identical(other.participantId, participantId) ||
                other.participantId == participantId) &&
            (identical(other.externalUserId, externalUserId) ||
                other.externalUserId == externalUserId) &&
            (identical(other.muteStatus, muteStatus) ||
                other.muteStatus == muteStatus) &&
            (identical(other.isVideoOn, isVideoOn) ||
                other.isVideoOn == isVideoOn) &&
            (identical(other.videoTile, videoTile) ||
                other.videoTile == videoTile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, participantId, externalUserId,
      muteStatus, isVideoOn, videoTile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParticipantModelImplCopyWith<_$ParticipantModelImpl> get copyWith =>
      __$$ParticipantModelImplCopyWithImpl<_$ParticipantModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParticipantModelImplToJson(
      this,
    );
  }
}

abstract class _ParticipantModel implements ParticipantModel {
  const factory _ParticipantModel(
      {required final String participantId,
      required final String externalUserId,
      final bool muteStatus,
      final bool isVideoOn,
      final VideoTileModel? videoTile}) = _$ParticipantModelImpl;

  factory _ParticipantModel.fromJson(Map<String, dynamic> json) =
      _$ParticipantModelImpl.fromJson;

  @override
  String get participantId;
  @override
  String get externalUserId;
  @override
  bool get muteStatus;
  @override
  bool get isVideoOn;
  @override
  VideoTileModel? get videoTile;
  @override
  @JsonKey(ignore: true)
  _$$ParticipantModelImplCopyWith<_$ParticipantModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
