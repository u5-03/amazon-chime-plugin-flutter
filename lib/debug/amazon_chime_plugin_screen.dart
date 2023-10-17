import 'package:amazon_chime_plugin/api/api.dart';
import 'package:amazon_chime_plugin/components/future_widget.dart';
import 'package:amazon_chime_plugin/debug/components/result_widget.dart';
import 'package:amazon_chime_plugin/debug/input_info_debug_screen.dart';
import 'package:amazon_chime_plugin/extensions/alert_dialog.dart';
import 'package:amazon_chime_plugin/utils/permission_manager.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_requester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AmazonChimeSDKSampleScreen extends ConsumerWidget {
  AmazonChimeSDKSampleScreen({super.key});

  final AmazonChimeRequester plugin = AmazonChimeRequester();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Info')),
      body: Center(
        child: Column(
          children: [
            FutureWidget(
              future: plugin.getPlatformVersion(),
              whenDone: (result) => ResultWidget(result: result),
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
                        apiUrl:
                            'https://5zcstrkvxe.execute-api.us-east-1.amazonaws.com/Prod/',
                        region: 'us-east-1',
                      ),
                    ),
                    fullscreenDialog: true, // modal page
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
