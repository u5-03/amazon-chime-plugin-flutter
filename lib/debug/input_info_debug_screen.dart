import 'package:amazon_chime_plugin/api/api.dart';
import 'package:amazon_chime_plugin/extensions/alert_dialog.dart';
import 'package:amazon_chime_plugin/features/meeting/components/meeting_body/meeting_body_portrait_widget.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_controller.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _meetingIdProvider =
    StateProvider<String>((ref) => '1d94fb6b-1ade-4dbd-b6bc-be911c422713');
final _userNameProvider = StateProvider<String>((ref) => 'TestUser');

class InputInfoDebugScreen extends ConsumerWidget {
  const InputInfoDebugScreen(this.apiConfig, {super.key});

  final ApiConfig apiConfig;

  Future<void> _onButtonTapped(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final meetingId = ref.read(_meetingIdProvider);
    final userName = ref.read(_userNameProvider);
    final result = await ref
        .read(meetingControllerProvider.notifier)
        .joinMeetingWithAPI(meetingId, userName, apiConfig);
    if (!context.mounted) {
      return;
    }
    switch (result) {
      case Success():
        await Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => const MeetingBodyPortraitWidget(),
            fullscreenDialog: true, // modal page
          ),
        );
      case Failure(exception: final exception):
        if (!context.mounted) {
          return;
        }
        DialogExt.showMessageAlert(
          message: exception.message,
          context: context,
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Info Debug Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Meeting ID',
              ),
              controller: TextEditingController(
                text: ref.read(_meetingIdProvider),
              ),
              onChanged: (value) {
                ref.read(_meetingIdProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'User Name',
              ),
              controller: TextEditingController(
                text: ref.read(_userNameProvider.notifier).state,
              ),
              onChanged: (value) {
                ref.read(_userNameProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _onButtonTapped(ref, context),
              // onPressed: ref.watch(_isAllElementsNotEmpty)
              //     ? () => _onButtonTapped(ref, context)
              //     : null,
              child: const Text('Submit'),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
