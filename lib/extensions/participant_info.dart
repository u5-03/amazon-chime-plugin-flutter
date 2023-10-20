import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';

extension ParticipantInfoExt on ParticipantInfo {
  bool get isContentShare {
    final participantIdArray = attendeeId.split('#');
    return participantIdArray.length == 2;
  }
}
