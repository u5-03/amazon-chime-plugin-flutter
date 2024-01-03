import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';

final class RequesterToFlutterCallbacks {
  RequesterToFlutterCallbacks({
    this.audioSessionDidDrop,
    this.audioSessionDidStop,
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
  void Function(AttendeeInfo)? joined;
  void Function(AttendeeInfo)? dropped;
  void Function(AttendeeInfo)? left;
  void Function(AttendeeInfo)? muted;
  void Function(AttendeeInfo)? unmuted;
  void Function(TileInfo)? videoTileAdded;
  void Function(TileInfo)? videoTileRemoved;
}
