import 'package:amazon_chime_plugin/src/native/requester_to_flutter/requester_to_flutter_callbacks.dart';
import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';

final class RequesterToFlutterImp implements RequesterToFlutter {
  RequesterToFlutterImp({required this.callbacks});

  final RequesterToFlutterCallbacks callbacks;

  @override
  void audioSessionDidDrop() {
    callbacks.audioSessionDidDrop?.call();
  }

  @override
  void audioSessionDidStop() {
    callbacks.audioSessionDidStop?.call();
  }

  @override
  void joined(AttendeeInfo info) {
    callbacks.joined?.call(info);
  }

  @override
  void dropped(AttendeeInfo info) {
    callbacks.dropped?.call(info);
  }

  @override
  void left(AttendeeInfo info) {
    callbacks.left?.call(info);
  }

  @override
  void muted(AttendeeInfo info) {
    callbacks.muted?.call(info);
  }

  @override
  void unmuted(AttendeeInfo info) {
    callbacks.unmuted?.call(info);
  }

  @override
  void videoTileAdded(TileInfo info) {
    callbacks.videoTileAdded?.call(info);
  }

  @override
  void videoTileRemoved(TileInfo info) {
    callbacks.videoTileRemoved?.call(info);
  }
}
