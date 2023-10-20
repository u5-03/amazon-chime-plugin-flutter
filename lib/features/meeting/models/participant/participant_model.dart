import 'package:amazon_chime_plugin/features/meeting/models/video_tile_model/video_tile_model.dart';
import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant_model.freezed.dart';
part 'participant_model.g.dart';

@freezed
class ParticipantModel with _$ParticipantModel {
  const factory ParticipantModel({
    required String participantId,
    required String externalUserId,
    @Default(false) bool muteStatus,
    @Default(false) bool isVideoOn,
    VideoTileModel? videoTile,
  }) = _ParticipantModel;

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  factory ParticipantModel.fromPigeonModel(ParticipantInfo info) =>
      ParticipantModel(
        externalUserId: info.externalUserId,
        participantId: info.attendeeId,
      );
}

extension ParticipantModelExt on ParticipantModel {
  String get formattedExternalUserId {
    final externalUserIdArray = externalUserId.split('#');
    final extUserId =
        externalUserIdArray.length == 2 ? externalUserIdArray[1] : 'UNKNOWN';
    return extUserId;
  }

  bool get isContentShare {
    final participantIdArray = participantId.split('#');
    return participantIdArray.length == 2;
  }
}
