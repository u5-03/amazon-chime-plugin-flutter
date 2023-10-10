import 'dart:convert';

import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting_api/join_info_api_model.dart';
import 'package:amazon_chime_plugin/utils/logger.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<Result<JoinInfoModel, AmazonChimeError>> join(
    String meetingId,
    String attendeeId,
    ApiConfig config,
  ) async {
    final url =
        '${config.apiUrl}join?title=$meetingId&name=$attendeeId&region=${config.region}';

    print('POST - join api call: $url');
    try {
      final response = await http.post(Uri.parse(url));
      logger.info('STATUS: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        logger.info('POST - join api call successful!');
        print('response.body: ${response.body}');
        final joinInfoMap = jsonDecode(response.body) as Map<String, dynamic>;
        print('joinInfoMap: $joinInfoMap');
        final joinInfo = JoinInfoParentAPIModel.fromJson(joinInfoMap)
            .joinInfo
            .asJoinInfoModel;
        print('joinInfo: $joinInfo');
        return Success(joinInfo);
      } else {
        return Failure(
          AmazonChimeError.customError(
            'not 200 status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      logger.severe('join request Failed. Status: $e');
      return Failure(AmazonChimeError.customError(e.toString()));
    }
  }

  // Map<String, dynamic> joinInfoToJSON(JoinInfoModel info) {
  //   final flattenedJSON = <String, dynamic>{
  //     'MeetingId': info.meeting.meetingId,
  //     'ExternalMeetingId': info.meeting.externalMeetingId,
  //     'MediaRegion': info.meeting.mediaRegion,
  //     'AudioHostUrl': info.meeting.mediaPlacement.audioHostUrl,
  //     'AudioFallbackUrl': info.meeting.mediaPlacement.audioFallbackUrl,
  //     'SignalingUrl': info.meeting.mediaPlacement.signalingUrl,
  //     'TurnControlUrl': info.meeting.mediaPlacement.turnControllerUrl,
  //     'ExternalUserId': info.attendee.externalUserId,
  //     'AttendeeId': info.attendee.attendeeId,
  //     'JoinToken': info.attendee.joinToken,
  //   };

  //   return flattenedJSON;
  // }
}

class ApiConfig {
  ApiConfig({
    required this.region,
    required this.apiUrl,
  });
  final String region;
  final String apiUrl;
}
