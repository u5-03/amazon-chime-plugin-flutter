// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_tile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoTileModel _$VideoTileModelFromJson(Map<String, dynamic> json) {
  return _VideoTileModel.fromJson(json);
}

/// @nodoc
mixin _$VideoTileModel {
  int get tileId => throw _privateConstructorUsedError;
  int get videoStreamContentWidth => throw _privateConstructorUsedError;
  int get videoStreamContentHeight => throw _privateConstructorUsedError;
  bool get isLocalTile => throw _privateConstructorUsedError;
  bool get isContentShare => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoTileModelCopyWith<VideoTileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoTileModelCopyWith<$Res> {
  factory $VideoTileModelCopyWith(
          VideoTileModel value, $Res Function(VideoTileModel) then) =
      _$VideoTileModelCopyWithImpl<$Res, VideoTileModel>;
  @useResult
  $Res call(
      {int tileId,
      int videoStreamContentWidth,
      int videoStreamContentHeight,
      bool isLocalTile,
      bool isContentShare});
}

/// @nodoc
class _$VideoTileModelCopyWithImpl<$Res, $Val extends VideoTileModel>
    implements $VideoTileModelCopyWith<$Res> {
  _$VideoTileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tileId = null,
    Object? videoStreamContentWidth = null,
    Object? videoStreamContentHeight = null,
    Object? isLocalTile = null,
    Object? isContentShare = null,
  }) {
    return _then(_value.copyWith(
      tileId: null == tileId
          ? _value.tileId
          : tileId // ignore: cast_nullable_to_non_nullable
              as int,
      videoStreamContentWidth: null == videoStreamContentWidth
          ? _value.videoStreamContentWidth
          : videoStreamContentWidth // ignore: cast_nullable_to_non_nullable
              as int,
      videoStreamContentHeight: null == videoStreamContentHeight
          ? _value.videoStreamContentHeight
          : videoStreamContentHeight // ignore: cast_nullable_to_non_nullable
              as int,
      isLocalTile: null == isLocalTile
          ? _value.isLocalTile
          : isLocalTile // ignore: cast_nullable_to_non_nullable
              as bool,
      isContentShare: null == isContentShare
          ? _value.isContentShare
          : isContentShare // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoTileModelImplCopyWith<$Res>
    implements $VideoTileModelCopyWith<$Res> {
  factory _$$VideoTileModelImplCopyWith(_$VideoTileModelImpl value,
          $Res Function(_$VideoTileModelImpl) then) =
      __$$VideoTileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int tileId,
      int videoStreamContentWidth,
      int videoStreamContentHeight,
      bool isLocalTile,
      bool isContentShare});
}

/// @nodoc
class __$$VideoTileModelImplCopyWithImpl<$Res>
    extends _$VideoTileModelCopyWithImpl<$Res, _$VideoTileModelImpl>
    implements _$$VideoTileModelImplCopyWith<$Res> {
  __$$VideoTileModelImplCopyWithImpl(
      _$VideoTileModelImpl _value, $Res Function(_$VideoTileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tileId = null,
    Object? videoStreamContentWidth = null,
    Object? videoStreamContentHeight = null,
    Object? isLocalTile = null,
    Object? isContentShare = null,
  }) {
    return _then(_$VideoTileModelImpl(
      tileId: null == tileId
          ? _value.tileId
          : tileId // ignore: cast_nullable_to_non_nullable
              as int,
      videoStreamContentWidth: null == videoStreamContentWidth
          ? _value.videoStreamContentWidth
          : videoStreamContentWidth // ignore: cast_nullable_to_non_nullable
              as int,
      videoStreamContentHeight: null == videoStreamContentHeight
          ? _value.videoStreamContentHeight
          : videoStreamContentHeight // ignore: cast_nullable_to_non_nullable
              as int,
      isLocalTile: null == isLocalTile
          ? _value.isLocalTile
          : isLocalTile // ignore: cast_nullable_to_non_nullable
              as bool,
      isContentShare: null == isContentShare
          ? _value.isContentShare
          : isContentShare // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoTileModelImpl implements _VideoTileModel {
  const _$VideoTileModelImpl(
      {required this.tileId,
      required this.videoStreamContentWidth,
      required this.videoStreamContentHeight,
      required this.isLocalTile,
      required this.isContentShare});

  factory _$VideoTileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoTileModelImplFromJson(json);

  @override
  final int tileId;
  @override
  final int videoStreamContentWidth;
  @override
  final int videoStreamContentHeight;
  @override
  final bool isLocalTile;
  @override
  final bool isContentShare;

  @override
  String toString() {
    return 'VideoTileModel(tileId: $tileId, videoStreamContentWidth: $videoStreamContentWidth, videoStreamContentHeight: $videoStreamContentHeight, isLocalTile: $isLocalTile, isContentShare: $isContentShare)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoTileModelImpl &&
            (identical(other.tileId, tileId) || other.tileId == tileId) &&
            (identical(
                    other.videoStreamContentWidth, videoStreamContentWidth) ||
                other.videoStreamContentWidth == videoStreamContentWidth) &&
            (identical(
                    other.videoStreamContentHeight, videoStreamContentHeight) ||
                other.videoStreamContentHeight == videoStreamContentHeight) &&
            (identical(other.isLocalTile, isLocalTile) ||
                other.isLocalTile == isLocalTile) &&
            (identical(other.isContentShare, isContentShare) ||
                other.isContentShare == isContentShare));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tileId, videoStreamContentWidth,
      videoStreamContentHeight, isLocalTile, isContentShare);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoTileModelImplCopyWith<_$VideoTileModelImpl> get copyWith =>
      __$$VideoTileModelImplCopyWithImpl<_$VideoTileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoTileModelImplToJson(
      this,
    );
  }
}

abstract class _VideoTileModel implements VideoTileModel {
  const factory _VideoTileModel(
      {required final int tileId,
      required final int videoStreamContentWidth,
      required final int videoStreamContentHeight,
      required final bool isLocalTile,
      required final bool isContentShare}) = _$VideoTileModelImpl;

  factory _VideoTileModel.fromJson(Map<String, dynamic> json) =
      _$VideoTileModelImpl.fromJson;

  @override
  int get tileId;
  @override
  int get videoStreamContentWidth;
  @override
  int get videoStreamContentHeight;
  @override
  bool get isLocalTile;
  @override
  bool get isContentShare;
  @override
  @JsonKey(ignore: true)
  _$$VideoTileModelImplCopyWith<_$VideoTileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
