import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';

final class RequesterToFlutterCallbacks {
  RequesterToFlutterCallbacks({
    this.audioSessionDidDrop,
    this.audioSessionDidStop,
    this.connectionDidRecover,
    this.connectionDidBecomePoor,
    this.audioSessionDidCancelReconnect,
    this.videoSessionDidStartConnecting,
    this.audioSessionDidStartConnecting,
    this.audioSessionDidStart,
    this.cameraSendAvailabilityDidChange,
    this.remoteVideoSourcesDidBecomeAvailable,
    this.remoteVideoSourcesDidBecomeUnavailable,
    this.joined,
    this.dropped,
    this.left,
    this.muted,
    this.unmuted,
    this.videoTileAdded,
    this.videoTileRemoved,
  });
  void Function()? audioSessionDidDrop;
  void Function()? audioSessionDidStop;
  void Function()? connectionDidRecover;
  void Function()? connectionDidBecomePoor;
  void Function()? audioSessionDidCancelReconnect;
  void Function()? videoSessionDidStartConnecting;
  void Function(bool)? audioSessionDidStartConnecting;
  void Function(bool)? audioSessionDidStart;
  void Function(bool)? cameraSendAvailabilityDidChange;
  void Function(List<String>)? remoteVideoSourcesDidBecomeAvailable;
  void Function(List<String>)? remoteVideoSourcesDidBecomeUnavailable;
  void Function(AttendeeInfo)? joined;
  void Function(AttendeeInfo)? dropped;
  void Function(AttendeeInfo)? left;
  void Function(AttendeeInfo)? muted;
  void Function(AttendeeInfo)? unmuted;
  void Function(TileInfo)? videoTileAdded;
  void Function(TileInfo)? videoTileRemoved;
}
