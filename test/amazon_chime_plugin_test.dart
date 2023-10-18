// import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
// import 'package:amazon_chime_plugin/amazon_chime_plugin_method_channel.dart';
// import 'package:amazon_chime_plugin/amazon_chime_plugin_platform_interface.dart';
import 'dart:convert';

import 'package:amazon_chime_plugin/features/meeting/models/meeting_api/join_info_api_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // final initialPlatform = AmazonChimePlatform.instance;

  // test('$MethodChannelAmazonChimePlugin is the default instance', () {
  //   expect(initialPlatform, isInstanceOf<MethodChannelAmazonChimePlugin>());
  // });

  test('JSON parse', () async {
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

  test('testFromFlutterToNative', () async {
    // final amazonChimePlugin = AmazonChimePlugin();
    // final fakePlatform = MockAmazonChimePluginPlatform();
    // AmazonChimePlatform.instance = fakePlatform;

    // expect((await amazonChimePlugin.getPlatformVersion()).value, '42');
    // expect(
    //   (await amazonChimePlugin.requestCameraPermissions()).value,
    //   'Camera authorized.',
    // );
    // expect(
    //   (await amazonChimePlugin.requestMicrophonePermissions()).value,
    //   'Microphone authorized.',
    // );
  });

  test('testErrorFromFlutterToNative', () async {
    // final amazonChimePlugin = AmazonChimePlugin();
    // final fakePlatform = MockErrorAmazonChimePluginPlatform();
    // AmazonChimePlatform.instance = fakePlatform;
    // expect(
    //   (await amazonChimePlugin.getPlatformVersion()).error,
    //   AmazonChimeError.invalidResponse(),
    // );
    // expect(
    //   (await amazonChimePlugin.requestCameraPermissions()).error,
    //   AmazonChimeError.customError('This is camera permission error!'),
    // );
    // expect(
    //   (await amazonChimePlugin.requestMicrophonePermissions()).error,
    //   AmazonChimeError.unknown(),
    // );
  });
}
