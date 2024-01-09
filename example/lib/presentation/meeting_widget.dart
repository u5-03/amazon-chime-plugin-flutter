import 'package:amazon_chime_plugin/amazon_chime_plugin.dart';
import 'package:amazon_chime_plugin_example/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MeetingWidget extends StatelessWidget {
  const MeetingWidget({
    required this.controller,
    // required this.meetingValue,
    super.key,
  });
  final MeetingController controller;
  // final MeetingValue meetingValue;

  Widget localListInfo(
    BuildContext context,
    MeetingController meetingController,
    MeetingValue meetingValue,
  ) {
    final attendees = meetingValue.attendees;
    final localAttendeeId = meetingValue.localAttendeeId;

    final isMuted =
        meetingValue.attendees[localAttendeeId]?.muteStatus ?? false;
    final isVideoOn =
        meetingValue.attendees[localAttendeeId]?.isVideoOn ?? false;

    return ListTile(
      title: Text(
        attendees[localAttendeeId]?.externalUserId ?? 'UNKNOWN',
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
              showAudioDeviceDialog(context, meetingValue, (deviceLabel) async {
                await meetingController.updateCurrentAudioDevice(deviceLabel);
              });
            },
          ),
          IconButton(
            icon: Icon(localMuteIcon(isMuted: isMuted)),
            iconSize: Style.iconSize,
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            color: Colors.blue,
            onPressed: isMuted ? controller.unmute : controller.mute,
          ),
          IconButton(
            icon: Icon(localVideoIcon(isVideoOn: isVideoOn)),
            iconSize: Style.iconSize,
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            constraints: const BoxConstraints(),
            color: Colors.blue,
            onPressed: isVideoOn
                ? controller.stopLocalVideo
                : controller.startLocalVideo,
          ),
          IconButton(
            icon: const Icon(
              Icons.switch_camera,
              size: 20,
            ),
            iconSize: Style.iconSize,
            padding: EdgeInsets.symmetric(
              horizontal: Style.iconPadding,
            ),
            color: Colors.blue,
            onPressed: meetingController.switchLocalCamera,
          ),
        ],
      ),
    );
  }

  Widget remoteListInfo(
    MeetingValue meetingValue,
  ) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            child: Icon(
              remoteMuteIcon(meetingValue),
              size: Style.iconSize,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.iconPadding),
            child: Icon(
              remoteVideoIcon(meetingValue),
              size: Style.iconSize,
            ),
          ),
        ],
      ),
      title: Text(
        meetingValue.attendees[meetingValue.remoteAttendeeId]
                ?.formattedExternalUserId ??
            '',
        style: const TextStyle(fontSize: Style.fontSize),
      ),
    );
  }

  List<Widget> displayAttendees(
    BuildContext context,
    MeetingController meetingController,
    MeetingValue meetingValue,
  ) {
    final attendeesWidgets = <Widget>[];
    final attendees = meetingValue.attendees;
    final localAttendeeId = meetingValue.localAttendeeId;
    final remoteAttendeeId = meetingValue.remoteAttendeeId;
    if (attendees.containsKey(localAttendeeId)) {
      attendeesWidgets.add(
        localListInfo(
          context,
          meetingController,
          meetingValue,
        ),
      );
    }
    if (attendees.length > 1) {
      if (attendees.containsKey(remoteAttendeeId)) {
        attendeesWidgets.add(
          remoteListInfo(
            meetingValue,
          ),
        );
      }
    }

    return attendeesWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // RequesterToFlutterImp.ref = ref;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Info Debug Screen'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          controller.stopMeeting();
          return true;
        },
        child: ValueListenableBuilder<MeetingValue>(
            valueListenable: controller.notifier,
            builder: (context, meetingValue, _) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: VideoTileWidget.displayVideoTiles(
                            Orientation.portrait,
                            controller,
                            Size(size.width / 2, 230),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 20),
                          child: Text(
                            'Attendees:',
                            style: TextStyle(fontSize: Style.titleSize),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Column(
                          children: displayAttendees(
                            context,
                            controller,
                            meetingValue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            child: Text(
                              'MeetingID: ${meetingValue.meetingId ?? ''}',
                            ),
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: meetingValue.meetingId ?? '',
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: leaveMeetingButton(controller, context),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> showAudioDeviceDialog(
    BuildContext context,
    MeetingValue meetingValue,
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
          children: _getSimpleDialogOptionsAudioDevices(context, meetingValue),
        );
      },
    );
    if (deviceLabel != null) {
      debugPrint('No device chosen.');
      await didShowDialog(deviceLabel);
      return;
    }
  }

  List<Widget> _getSimpleDialogOptionsAudioDevices(
    BuildContext context,
    MeetingValue meetingValue,
  ) {
    final dialogOptions = <Widget>[];
    FontWeight weight;
    final deviceList = meetingValue.deviceList;
    final selectedAudioDevice = meetingValue.selectedAudioDevice;
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
            debugPrint('${deviceList[i]} was chosen.');
            Navigator.pop(context, deviceList[i]);
          },
        ),
      );
    }
    return dialogOptions;
  }
}

extension MeetingBodyPortraitExt on MeetingWidget {
  Future<void> showAudioDeviceDialog(
    BuildContext context,
    MeetingValue meetingValue,
    MeetingController controller,
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
        actions: getSimpleDialogOptionsAudioDevices(context, meetingValue),
      ),
    );
    if (device == null) {
      debugPrint('No device chosen.');
      return;
    }
    await controller.updateCurrentAudioDevice(device);
  }

  List<Widget> getSimpleDialogOptionsAudioDevices(
    BuildContext context,
    MeetingValue meetingValue,
  ) {
    final dialogOptions = <Widget>[];
    FontWeight weight;
    final deviceList = meetingValue.deviceList;
    final selectedAudioDevice = meetingValue.selectedAudioDevice;
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
            debugPrint('${deviceList[i]} was chosen.');
            Navigator.pop(context, deviceList[i]);
          },
        ),
      );
    }
    return dialogOptions;
  }
}

extension _MeetingBodyPortraitWidgetExt on MeetingWidget {
  Widget leaveMeetingButton(
      MeetingController controller, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        controller.stopMeeting();
        Navigator.pop(context);
      },
      child: const Text('Leave Meeting'),
    );
  }

  IconData localMuteIcon({required bool isMuted}) {
    if (isMuted) {
      return Icons.mic_off;
    } else {
      return Icons.mic;
    }
  }

  IconData remoteMuteIcon(MeetingValue meetingValue) {
    final remoteAttendeeId = meetingValue.remoteAttendeeId;
    final isMuted =
        meetingValue.attendees[remoteAttendeeId]?.muteStatus ?? false;
    if (isMuted) {
      return Icons.mic_off;
    } else {
      return Icons.mic;
    }
  }

  IconData localVideoIcon({required bool isVideoOn}) {
    if (isVideoOn) {
      return Icons.videocam;
    } else {
      return Icons.videocam_off;
    }
  }

  IconData remoteVideoIcon(MeetingValue meetingValue) {
    final remoteAttendeeId = meetingValue.remoteAttendeeId;
    final isVideoOn =
        meetingValue.attendees[remoteAttendeeId]?.isVideoOn ?? false;
    if (isVideoOn) {
      return Icons.videocam;
    } else {
      return Icons.videocam_off;
    }
  }
}
