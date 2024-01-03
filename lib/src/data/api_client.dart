import 'dart:convert';
import 'dart:io';

import 'package:amazon_chime_plugin/src/errors/amazon_chime_error.dart';

final class ApiClient {
  static Future<Map<String, dynamic>> post({required Uri uri}) async {
    final client = HttpClient();
    try {
      print(uri);
      final request = await client.postUrl(uri);
      // request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        return json.decode(responseBody) as Map<String, dynamic>;
      } else {
        throw AmazonChimeError.responseMessage(
          'Request failed with status(${response.statusCode}): ${response.toString()}.',
        );
      }
    } catch (e) {
      throw AmazonChimeError.responseMessage(
        'Request failed with error: $e.',
      );
    } finally {
      client.close();
    }
  }
}
