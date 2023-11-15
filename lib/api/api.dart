import 'dart:convert';

import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting_api/join_info_api_model.dart';
import 'package:amazon_chime_plugin/utils/logger.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<Result<JoinInfoModel>> join(
    String meetingId,
    String attendeeId,
    ApiConfig config,
  ) async {
    final url =
        '${config.apiUrl}join?title=$meetingId&name=$attendeeId&region=${config.region}';

    logger.info('POST - join api call: $url');
    try {
      final response = await http.post(Uri.parse(url));
      logger.info('STATUS: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        logger.info('POST - join api call successful!');
        final joinInfoMap = jsonDecode(response.body) as Map<String, dynamic>;
        final joinInfo = JoinInfoParentAPIModel.fromJson(joinInfoMap)
            .joinInfo
            .asJoinInfoModel;
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
}

final class ApiConfig {
  ApiConfig({
    required this.region,
    required this.apiUrl,
  });
  final String region;
  final String apiUrl;
}
