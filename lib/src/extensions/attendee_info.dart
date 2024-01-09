import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';

extension AttendeeInfoExt on AttendeeInfo {
  bool get isContentShare {
    final attendeeIdArray = attendeeId.split('#');
    return attendeeIdArray.length == 2;
  }
}
