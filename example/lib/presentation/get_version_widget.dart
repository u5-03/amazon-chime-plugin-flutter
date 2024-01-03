import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
import 'package:amazon_chime_plugin_example/components/future_widget.dart';
import 'package:flutter/material.dart';

final class GetVersionWidget extends StatelessWidget {
  GetVersionWidget({super.key});

  final controller = MeetingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AmazonChimePlugin example'),
      ),
      body: Center(
        child: Column(
          children: [
            FutureWidget(
              future: controller.getPlatformVersion(),
              whenDone: (result) => Text(result),
            ),
          ],
        ),
      ),
    );
  }
}
