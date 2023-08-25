import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
import 'package:amazon_chime_plugin/components/future_widget.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/extensions/alert_dialog.dart';
import 'package:flutter/material.dart';

class ChimeSDKSampleScreen extends StatefulWidget {
  const ChimeSDKSampleScreen({super.key});

  @override
  State<ChimeSDKSampleScreen> createState() => _ChimeSDKSampleState();
}

class _ChimeSDKSampleState extends State<ChimeSDKSampleScreen> {
  final plugin = AmazonChimePlugin();

  Widget resultWidget(Result<String, AmazonChimeError> result) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Info')),
      body: Center(
        child: Column(
          children: [
            FutureWidget(
              future: plugin.getPlatformVersion(),
              whenDone: resultWidget,
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
          ],
        ),
      ),
    );
  }
}
