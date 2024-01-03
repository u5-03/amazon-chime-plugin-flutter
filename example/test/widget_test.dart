// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:amazon_chime_plugin_example/models/join_info_api_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('API response parse', (WidgetTester tester) async {
    const jsonString = '''
{
    "JoinInfo": {
        "Meeting": {
            "Meeting": {
                "MeetingId": "396bc713-ecdb-4fac-a406-1db789d52713",
                "MeetingHostId": null,
                "ExternalMeetingId": "ExternalMeetingId7",
                "MediaRegion": "us-east-1",
                "MediaPlacement": {
                    "AudioHostUrl": "1c6e2dd22c06d6fbf585e3f4e2eafd38.k.m3.ue1.app.chime.aws:3478",
                    "AudioFallbackUrl": "AudioFallbackUrl",
                    "SignalingUrl": "wss://signal.m3.ue1.app.chime.aws/control/396bc713-ecdb-4fac-a406-1db789d52713",
                    "TurnControlUrl": "https://2713.cell.us-east-1.meetings.chime.aws/v2/turn_sessions",
                    "ScreenDataUrl": "ScreenDataUrl",
                    "ScreenViewingUrl": "ScreenViewingUrl",
                    "ScreenSharingUrl": "ScreenSharingUrl",
                    "EventIngestionUrl": "https://data.svc.ue1.ingest.chime.aws/v1/client-events"
                },
                "PrimaryMeetingId": null,
                "TenantIds": [],
                "MeetingArn": "arn:aws:chime:us-east-1:436990515142:meeting/396bc713-ecdb-4fac-a406-1db789d52713"
            }
        },
        "Attendee": {
            "Attendee": {
                "ExternalUserId": "ExternalUserId",
                "AttendeeId": "35a392d3-9502-22df-830a-ba6d047bb681",
                "JoinToken": "JoinToken",
                "Capabilities": {
                    "Audio": "SendReceive",
                    "Video": "SendReceive",
                    "Content": "SendReceive"
                }
            }
        }
    }
}
''';
//     const jsonString = '''
// {
// 		"Audio": "SendReceive",
// 		"Video": "SendReceive",
// 		"Content": "SendReceive"
// 	}
// ''';

    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    // final capabilities = CapabilitiesAPIModel.fromJson(jsonData);

    // JSONデータをMyModelインスタンスにデコード
    final joinInfo =
        JoinInfoParentAPIModel.fromJson(jsonData).joinInfo.asJoinInfoModel;

    // MyModelインスタンスのプロパティが正しいかテスト
    expect(joinInfo.meeting.meetingId, '396bc713-ecdb-4fac-a406-1db789d52713');
    expect(
      joinInfo.attendeeInfo.attendeeId,
      '35a392d3-9502-22df-830a-ba6d047bb681',
    );
  });
}
