import 'package:amazon_chime_plugin/components/future_widget.dart';
import 'package:amazon_chime_plugin/debug/components/result_widget.dart';
import 'package:amazon_chime_plugin/utils/permission_manager.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_requester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class GetVersionWidget extends ConsumerWidget {
  GetVersionWidget({super.key});

  final AmazonChimeRequester plugin = AmazonChimeRequester();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AmazonChimePlugin example'),
      ),
      body: Center(
        child: Column(
          children: [
            FutureWidget(
              future: plugin.getPlatformVersion(),
              whenDone: (result) => ResultWidget(result: result),
            ),
            FutureWidget(
              future: PermissionManager.requestCameraPermissions(),
              whenDone: (status) {
                return Text('Camera: $status');
              },
            ),
            FutureWidget(
              future: PermissionManager.requestMicrophonePermissions(),
              whenDone: (status) {
                return Text('Microphone: $status');
              },
            ),
          ],
        ),
      ),
    );
  }
}
