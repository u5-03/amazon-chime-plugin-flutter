import 'package:amazon_chime_plugin/api/api.dart';
import 'package:amazon_chime_plugin/components/future_widget.dart';
import 'package:amazon_chime_plugin/debug/input_info_debug_screen.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/extensions/alert_dialog.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_requester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AmazonChimeSDKSampleScreen extends ConsumerWidget {
  AmazonChimeSDKSampleScreen({super.key});

  final AmazonChimeRequester plugin = AmazonChimeRequester();

  Widget _resultWidget(Result<String, AmazonChimeError> result) {
    switch (result) {
      case Success(value: final value):
        return Text(
          'Device OS is $value',
          // ignore: avoid_redundant_argument_values
          maxLines: null,
        );
      case Failure(exception: final exception):
        return Text(
          exception.message,
          // ignore: avoid_redundant_argument_values
          maxLines: null,
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Info')),
      body: Center(
        child: Column(
          children: [
            FutureWidget(
              future: plugin.getPlatformVersion(),
              whenDone: _resultWidget,
            ),
            ElevatedButton(
              child: const Text('Request Microphone Permissions'),
              onPressed: () async {
                final result = await plugin.requestMicrophonePermissions();
                if (context.mounted) {
                  DialogExt.showMessageAlert(
                    message: result.asContentString,
                    context: context,
                  );
                }
              },
            ),
            ElevatedButton(
              child: const Text('Request Camera Permissions'),
              onPressed: () async {
                final result = await plugin.requestCameraPermissions();
                if (context.mounted) {
                  DialogExt.showMessageAlert(
                    message: result.asContentString,
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
