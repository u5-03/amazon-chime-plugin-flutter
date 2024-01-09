import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/src/models/video_tile_model.dart';

final class AttendeeModel {
  final String attendeeId;
  final String externalUserId;
  final bool muteStatus;
  final bool isVideoOn;
  final VideoTileModel? videoTile;

  AttendeeModel({
    required this.attendeeId,
    required this.externalUserId,
    this.muteStatus = false,
    this.isVideoOn = false,
    this.videoTile,
  });

  AttendeeModel copyWith({
    String? attendeeId,
    String? externalUserId,
    bool? muteStatus,
    bool? isVideoOn,
    VideoTileModel? videoTile,
  }) {
    return AttendeeModel(
      attendeeId: attendeeId ?? this.attendeeId,
      externalUserId: externalUserId ?? this.externalUserId,
      muteStatus: muteStatus ?? this.muteStatus,
      isVideoOn: isVideoOn ?? this.isVideoOn,
      videoTile: videoTile ?? this.videoTile,
    );
  }

  factory AttendeeModel.fromJson(Map<String, dynamic> json) {
    return AttendeeModel(
      attendeeId: json['attendeeId'],
      externalUserId: json['externalUserId'],
      muteStatus: json['muteStatus'] ?? false,
      isVideoOn: json['isVideoOn'] ?? false,
      videoTile: json['videoTile'] != null
          ? VideoTileModel.fromJson(json['videoTile'])
          : null,
    );
  }

  factory AttendeeModel.fromPigeonModel(AttendeeInfo info) {
    return AttendeeModel(
      externalUserId: info.externalUserId,
      attendeeId: info.attendeeId,
    );
  }

  String get formattedExternalUserId {
    final externalUserIdArray = externalUserId.split('#');
    final extUserId =
        externalUserIdArray.length == 2 ? externalUserIdArray[1] : 'UNKNOWN';
    return extUserId;
  }

  bool get isContentShare {
    final attendeeIdArray = attendeeId.split('#');
    return attendeeIdArray.length == 2;
  }
}
