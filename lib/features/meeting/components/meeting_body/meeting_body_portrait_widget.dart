import 'package:amazon_chime_plugin/constants/style.dart';
import 'package:amazon_chime_plugin/features/meeting/components/video_tile/video_tile_widget.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_repository.dart';
import 'package:amazon_chime_plugin/features/meeting/models/participant/participant_model.dart';
import 'package:amazon_chime_plugin/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MeetingBodyPortraitWidget extends ConsumerWidget {
  const MeetingBodyPortraitWidget({super.key});

  Widget localListInfo(BuildContext context, WidgetRef ref) {
    final meetingProvider = ref.watch(meetingRepositoryProvider);
    final participants = meetingProvider.participants;
    final localParticipantId = meetingProvider.localParticipantId;
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
              showAudioDeviceDialog(context, ref);
            },
          ),
          IconButton(
            icon: Icon(localMuteIcon(ref)),
            iconSize: Style.iconSize,
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            color: Colors.blue,
            onPressed: meetingProvider.sendLocalMuteToggle,
          ),
          IconButton(
            icon: Icon(localVideoIcon(ref)),
            iconSize: Style.iconSize,
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            constraints: const BoxConstraints(),
            color: Colors.blue,
            onPressed: meetingProvider.sendLocalVideoTileOn,
          ),
        ],
      ),
    );
  }

  Widget remoteListInfo(WidgetRef ref) {
    final meetingProvider = ref.read(meetingRepositoryProvider);
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            child: Icon(
              remoteMuteIcon(ref),
              size: Style.iconSize,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            child: Icon(
              remoteVideoIcon(ref),
              size: Style.iconSize,
            ),
          ),
        ],
      ),
      title: Text(
        meetingProvider.participants[meetingProvider.remoteParticipantId]
                ?.formattedExternalUserId ??
            '',
        style: const TextStyle(fontSize: Style.fontSize),
      ),
    );
  }

  List<Widget> displayParticipants(BuildContext context, WidgetRef ref) {
    final meetingProvider = ref.watch(meetingRepositoryProvider);
    final participantsWidgets = <Widget>[];
    final participants = meetingProvider.participants;
    final localParticipantId = meetingProvider.localParticipantId;
    final remoteParticipantId = meetingProvider.remoteParticipantId;
    print('participants: $participants');
    if (participants.containsKey(localParticipantId)) {
      participantsWidgets.add(localListInfo(context, ref));
    }
    if (participants.length > 1) {
      if (participants.containsKey(remoteParticipantId)) {
        participantsWidgets.add(remoteListInfo(ref));
      }
    }

    return participantsWidgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingProvider = ref.read(meetingRepositoryProvider);
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: VideoTileWidget.displayVideoTiles(
                Orientation.portrait, ref.watch(meetingRepositoryProvider)),
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
            children: displayParticipants(context, ref),
          ),
          WillPopScope(
            onWillPop: () async {
              await meetingProvider.stopMeeting();
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
    WidgetRef ref,
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
          children: _getSimpleDialogOptionsAudioDevices(context, ref),
        );
      },
    );

    if (deviceLabel != null) {
      await ref
          .read(meetingRepositoryProvider)
          .updateCurrentAudioDevice(deviceLabel);
    } else {
      logger.severe('No device chosen.');
    }
  }

  List<Widget> _getSimpleDialogOptionsAudioDevices(
    BuildContext context,
    WidgetRef ref,
  ) {
    final dialogOptions = <Widget>[];
    FontWeight weight;
    final deviceList = ref.read(meetingRepositoryProvider).deviceList;
    final selectedAudioDevice =
        ref.read(meetingRepositoryProvider).selectedAudioDevice;
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
    WidgetRef ref,
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
        actions: getSimpleDialogOptionsAudioDevices(context, ref),
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
    WidgetRef ref,
  ) {
    final dialogOptions = <Widget>[];
    FontWeight weight;
    final deviceList = ref.read(meetingRepositoryProvider).deviceList;
    final selectedAudioDevice =
        ref.read(meetingRepositoryProvider).selectedAudioDevice;
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
        ref.read(meetingRepositoryProvider).stopMeeting();
        Navigator.pop(context);
      },
      child: const Text('Leave Meeting'),
    );
  }

  IconData localMuteIcon(WidgetRef ref) {
    final localParticipantId =
        ref.watch(meetingRepositoryProvider).localParticipantId;
    final isMuted = ref
            .watch(meetingRepositoryProvider)
            .participants[localParticipantId]
            ?.muteStatus ??
        false;
    if (isMuted) {
      return Icons.mic_off;
    } else {
      return Icons.mic;
    }
  }

  IconData remoteMuteIcon(WidgetRef ref) {
    final remoteParticipantId =
        ref.watch(meetingRepositoryProvider).remoteParticipantId;
    final isMuted = ref
            .watch(meetingRepositoryProvider)
            .participants[remoteParticipantId]
            ?.muteStatus ??
        false;
    if (isMuted) {
      return Icons.mic_off;
    } else {
      return Icons.mic;
    }
  }

  IconData localVideoIcon(WidgetRef ref) {
    final localParticipantId =
        ref.watch(meetingRepositoryProvider).localParticipantId;
    final isVideoOn = ref
            .watch(meetingRepositoryProvider)
            .participants[localParticipantId]
            ?.isVideoOn ??
        false;
    if (isVideoOn) {
      return Icons.videocam_off;
    } else {
      return Icons.videocam;
    }
  }

  IconData remoteVideoIcon(WidgetRef ref) {
    final remoteParticipantId =
        ref.watch(meetingRepositoryProvider).remoteParticipantId;
    final isVideoOn = ref
            .read(meetingRepositoryProvider)
            .participants[remoteParticipantId]
            ?.isVideoOn ??
        false;
    if (isVideoOn) {
      return Icons.videocam_off;
    } else {
      return Icons.videocam;
    }
  }
}
