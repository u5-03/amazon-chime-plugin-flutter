import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
import 'package:amazon_chime_plugin_example/extensions/dialog.dart';
import 'package:amazon_chime_plugin_example/models/join_info_api_model.dart';
import 'package:amazon_chime_plugin_example/presentation/meeting_widget.dart';
import 'package:flutter/material.dart';

final class InputInfoDebugScreen extends StatefulWidget {
  const InputInfoDebugScreen(this.apiConfig, this.controller, {super.key});

  final ApiConfig apiConfig;
  final MeetingController controller;

  @override
  State<InputInfoDebugScreen> createState() => _InputInfoDebugScreenState();
}

class _InputInfoDebugScreenState extends State<InputInfoDebugScreen> {
  String _meetingId = '';
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _meetingId = widget.apiConfig.meetingId;
    _userName = widget.apiConfig.attendeeId;
  }

  Future<void> _onButtonTapped(
    BuildContext context,
  ) async {
    try {
      widget.controller.joinMeetingWithAPI(
          widget.apiConfig,
          (map) =>
              JoinInfoParentAPIModel.fromJson(map).joinInfo.asJoinInfoModel);
      await Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => MeetingWidget(controller: widget.controller),
          fullscreenDialog: true, // modal page
        ),
      );
    } catch (exception) {
      if (!context.mounted) {
        return;
      }
      DialogExt.showMessageAlert(
        message: exception.toString(),
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Info Debug Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Meeting ID',
              ),
              controller: TextEditingController(
                text: _meetingId,
              ),
              onChanged: (value) {
                setState(() {
                  _meetingId = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'User Name',
              ),
              controller: TextEditingController(
                text: _userName,
              ),
              onChanged: (value) {
                setState(() {
                  _userName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _onButtonTapped(context),
              child: const Text('Join Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}
