import 'package:amazon_chime_plugin/constants/style.dart';
import 'package:amazon_chime_plugin/features/meeting/components/video_tile/video_tile_widget.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_controller.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_data/meeting_data.dart';
import 'package:amazon_chime_plugin/features/meeting/models/participant/participant_model.dart';
import 'package:amazon_chime_plugin/utils/logger.dart';
import 'package:amazon_chime_plugin/utils/requester/requester_to_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MeetingBodyPortraitWidget extends ConsumerWidget {
  const MeetingBodyPortraitWidget({
    // required this.meetingController,
    // required this.meetingData,
    super.key,
  });
  // final MeetingController meetingController;
  // final MeetingData meetingData;

  Widget localListInfo(
    BuildContext context,
    MeetingController meetingController,
    MeetingData meetingData,
  ) {
    final participants = meetingData.participants;
    final localParticipantId = meetingData.localParticipantId;

    return ListTile(
      title: Text(
        participants[localParticipantId]?.formattedExternalUserId ?? 'UNKNOWN',
        style: const TextStyle(
          color: Colors.black,
          fontSize: Style.fontSize,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.headphones),
            iconSize: Style.iconSize,
            color: Colors.blue,
            onPressed: () {
              showAudioDeviceDialog(context, meetingData, (deviceLabel) async {
                await meetingController.updateCurrentAudioDevice(deviceLabel);
              });
            },
          ),
          IconButton(
            icon: Icon(localMuteIcon(meetingData)),
            iconSize: Style.iconSize,
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            color: Colors.blue,
            onPressed: meetingController.sendLocalMuteToggle,
          ),
          IconButton(
            icon: Icon(localVideoIcon(meetingData)),
            iconSize: Style.iconSize,
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            constraints: const BoxConstraints(),
            color: Colors.blue,
            onPressed: meetingController.sendLocalVideoTileOn,
          ),
        ],
      ),
    );
  }

  Widget remoteListInfo(
    MeetingData meetingData,
  ) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            child: Icon(
              remoteMuteIcon(meetingData),
              size: Style.iconSize,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            child: Icon(
              remoteVideoIcon(meetingData),
              size: Style.iconSize,
            ),
          ),
        ],
      ),
      title: Text(
        meetingData.participants[meetingData.remoteParticipantId]
                ?.formattedExternalUserId ??
            '',
        style: const TextStyle(fontSize: Style.fontSize),
      ),
    );
  }

  List<Widget> displayParticipants(
    BuildContext context,
    MeetingController meetingController,
    MeetingData meetingData,
  ) {
    final participantsWidgets = <Widget>[];
    final participants = meetingData.participants;
    final localParticipantId = meetingData.localParticipantId;
    final remoteParticipantId = meetingData.remoteParticipantId;
    print('participants: $participants');
    if (participants.containsKey(localParticipantId)) {
      participantsWidgets.add(
        localListInfo(
          context,
          meetingController,
          meetingData,
        ),
      );
    }
    if (participants.length > 1) {
      if (participants.containsKey(remoteParticipantId)) {
        participantsWidgets.add(remoteListInfo(meetingData));
      }
    }

    return participantsWidgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingData = ref.watch(meetingControllerProvider);
    RequesterToFlutterImp.ref = ref;
    print('meetingData: $meetingData');
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: VideoTileWidget.displayVideoTiles(
              Orientation.portrait,
              // TODO: Force unwrapを外す
              meetingData,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Text(
              'Attendees',
              style: TextStyle(fontSize: Style.titleSize),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: displayParticipants(
              context,
              ref.read(meetingControllerProvider.notifier),
              meetingData,
            ),
          ),
          WillPopScope(
            onWillPop: () async {
              await ref.read(meetingControllerProvider.notifier).stopMeeting();
              return true;
            },
            child: const Spacer(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: SizedBox(
              height: 50,
              width: 300,
              child: leaveMeetingButton(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showAudioDeviceDialog(
    BuildContext context,
    MeetingData meetingData,
    Future<void> Function(String) didShowDialog,
  ) async {
    final deviceLabel = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Choose Audio Device'),
          elevation: 40,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: Style.fontSize,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
          children: _getSimpleDialogOptionsAudioDevices(context, meetingData),
        );
      },
    );
    if (deviceLabel != null) {
      logger.severe('No device chosen.');
      await didShowDialog(deviceLabel);
      return;
    }
  }

  List<Widget> _getSimpleDialogOptionsAudioDevices(
    BuildContext context,
    MeetingData meetingData,
  ) {
    final dialogOptions = <Widget>[];
    FontWeight weight;
    final deviceList = meetingData.deviceList;
    final selectedAudioDevice = meetingData.selectedAudioDevice;
    for (var i = 0; i < deviceList.length; i++) {
      if (deviceList[i] == selectedAudioDevice) {
        weight = FontWeight.bold;
      } else {
        weight = FontWeight.normal;
      }
      dialogOptions.add(
        SimpleDialogOption(
          child: Text(
            deviceList[i],
            style: TextStyle(color: Colors.black, fontWeight: weight),
          ),
          onPressed: () {
            logger.info('${deviceList[i]} was chosen.');
            Navigator.pop(context, deviceList[i]);
          },
        ),
      );
    }
    return dialogOptions;
  }
}

extension MeetingBodyPortraitExt on MeetingBodyPortraitWidget {
  Future<void> showAudioDeviceDialog(
    BuildContext context,
    MeetingData meetingData,
  ) async {
    final device = await showAdaptiveDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog.adaptive(
        title: const Text('Choose Audio Device'),
        elevation: 40,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: Style.fontSize,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
        actions: getSimpleDialogOptionsAudioDevices(context, meetingData),
      ),
    );
    if (device == null) {
      logger.severe('No device chosen.');
      return;
    }

    // TODO: implement
    // meetingProvider.updateCurrentDevice(device);
  }

  List<Widget> getSimpleDialogOptionsAudioDevices(
    BuildContext context,
    MeetingData meetingData,
  ) {
    final dialogOptions = <Widget>[];
    FontWeight weight;
    final deviceList = meetingData.deviceList;
    final selectedAudioDevice = meetingData.selectedAudioDevice;
    for (var i = 0; i < deviceList.length; i++) {
      if (deviceList[i] == selectedAudioDevice) {
        weight = FontWeight.bold;
      } else {
        weight = FontWeight.normal;
      }
      dialogOptions.add(
        SimpleDialogOption(
          child: Text(
            deviceList[i],
            style: TextStyle(color: Colors.black, fontWeight: weight),
          ),
          onPressed: () {
            logger.info('${deviceList[i]} was chosen.');
            Navigator.pop(context, deviceList[i]);
          },
        ),
      );
    }
    return dialogOptions;
  }
}

extension _MeetingBodyPortraitWidgetExt on MeetingBodyPortraitWidget {
  Widget leaveMeetingButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        ref.read(meetingControllerProvider.notifier).stopMeeting();
        Navigator.pop(context);
      },
      child: const Text('Leave Meeting'),
    );
  }

  IconData localMuteIcon(MeetingData meetingData) {
    final localParticipantId = meetingData.localParticipantId;
    final isMuted =
        meetingData.participants[localParticipantId]?.muteStatus ?? false;
    if (isMuted) {
      return Icons.mic_off;
    } else {
      return Icons.mic;
    }
  }

  IconData remoteMuteIcon(MeetingData meetingData) {
    final remoteParticipantId = meetingData.remoteParticipantId;
    final isMuted =
        meetingData.participants[remoteParticipantId]?.muteStatus ?? false;
    if (isMuted) {
      return Icons.mic_off;
    } else {
      return Icons.mic;
    }
  }

  IconData localVideoIcon(MeetingData meetingData) {
    final localParticipantId = meetingData.localParticipantId;
    final isVideoOn =
        meetingData.participants[localParticipantId]?.isVideoOn ?? false;
    if (isVideoOn) {
      return Icons.videocam_off;
    } else {
      return Icons.videocam;
    }
  }

  IconData remoteVideoIcon(MeetingData meetingData) {
    final remoteParticipantId = meetingData.remoteParticipantId;
    final isVideoOn =
        meetingData.participants[remoteParticipantId]?.isVideoOn ?? false;
    if (isVideoOn) {
      return Icons.videocam_off;
    } else {
      return Icons.videocam;
    }
  }
}
