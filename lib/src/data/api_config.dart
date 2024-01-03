final class ApiConfig {
  ApiConfig({
    required this.region,
    required this.apiUrl,
    required this.meetingId,
    required this.attendeeId,
  });
  final String region;
  final String apiUrl;
  final String meetingId;
  final String attendeeId;

  Uri requestUrl() => Uri.parse(
        '${apiUrl}join?title=$meetingId&name=$attendeeId&region=$region',
      );
  @override
  String toString() => 'ApiConfig(region: $region, apiUrl: $apiUrl)';
}
