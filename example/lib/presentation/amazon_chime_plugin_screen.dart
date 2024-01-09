import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
import 'package:amazon_chime_plugin_example/components/future_widget.dart';
import 'package:amazon_chime_plugin_example/extensions/dialog.dart';
import 'package:amazon_chime_plugin_example/presentation/input_info_debug_screen.dart';
import 'package:amazon_chime_plugin_example/utils/permission_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final class AmazonChimeSDKSampleScreen extends StatelessWidget {
  AmazonChimeSDKSampleScreen({super.key});

  final MeetingController controller = MeetingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Info')),
      body: Center(
        child: Column(
          children: [
            FutureWidget(
              future: controller.getPlatformVersion(),
              whenDone: (text) => Text(text),
            ),
            ElevatedButton(
              child: const Text('Request Microphone Permissions'),
              onPressed: () async {
                final status =
                    await PermissionManager.requestMicrophonePermissions();

                if (context.mounted) {
                  DialogExt.showMessageAlert(
                    message: status.toString(),
                    context: context,
                  );
                }
              },
            ),
            ElevatedButton(
              child: const Text('Request Camera Permissions'),
              onPressed: () async {
                final status =
                    await PermissionManager.requestCameraPermissions();
                if (context.mounted) {
                  DialogExt.showMessageAlert(
                    message: status.toString(),
                    context: context,
                  );
                }
              },
            ),
            ElevatedButton(
              child: const Text('Present Broadcast screen'),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) => InputInfoDebugScreen(
                        ApiConfig(
                          meetingId: dotenv.env['MEETING_ID'] as String,
                          attendeeId: 'TestUser',
                          apiUrl: dotenv.env['API_URL'] as String,
                          region: dotenv.env['REGION'] as String,
                        ),
                        controller),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
