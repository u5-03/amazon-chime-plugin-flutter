class Response {
  static const String audioAndVideoPermissionDenied =
      'ERROR audio and video permissions not authorized.';
  static const String audioNotAuthorized =
      'ERROR audio permissions not authorized.';
  static const String videoNotAuthorized =
      'ERROR video permissions not authorized.';

  // API
  static const String notConnectedToInternet =
      'ERROR device is not connected to the internet.';
  static const String apiResponseNull = 'ERROR api response is null';
  static const String apiCallFailed =
      'ERROR api call has returned incorrect status';

  // Meeting
  static const String emptyParameter = 'ERROR empty meeting or attendee';
  static const String invalidAttendeeOrMeeting =
      'ERROR meeting or attendee are too short or long.';
  static const String nullJoinResponse = 'ERROR join response is null.';
  static const String nullMeetingData = 'ERROR meeting data is null';
  static const String nullLocalAttendee = 'ERROR local attendee is null';
  static const String nullRemoteAttendee = 'ERROR remote attendee is null';
  static const String stopResponseNull = 'ERROR stop response is null';

  // Observers
  static const String nullRealtimeObservers =
      'WARNING realtime observer is null';
  static const String nullAudioVideoObservers =
      'WARNING audioVideo observer is null';
  static const String nullVideoTileObservers =
      'WARNING videoTile observer is null';

  // Mute
  static const String muteResponseNull = 'ERROR mute response is null.';
  static const String unmuteResponseNull = 'ERROR unmute response is null.';

  // Video
  static const String videoStartResponseNull =
      'ERROR video start response is null';
  static const String videoStoppedResponseNull =
      'ERROR video stop response is null';

  // Audio Device
  static const String nullInitialAudioDevice =
      'ERROR failed to get initial audio device';
  static const String nullAudioDeviceList = 'ERROR audio device list is null';
  static const String nullAudioDeviceUpdate =
      'ERROR audio device update is null.';
}

class MethodCallOption {
  static const String manageAudioPermissions = 'manageAudioPermissions';
  static const String manageVideoPermissions = 'manageVideoPermissions';
  static const String initialAudioSelection = 'initialAudioSelection';
  static const String join = 'join';
  static const String stop = 'stop';
  static const String leave = 'leave';
  static const String drop = 'drop';
  static const String mute = 'mute';
  static const String unmute = 'unmute';
  static const String localVideoOn = 'startLocalVideo';
  static const String localVideoOff = 'stopLocalVideo';
  static const String videoTileAdd = 'videoTileAdd';
  static const String videoTileRemove = 'videoTileRemove';
  static const String listAudioDevices = 'listAudioDevices';
  static const String updateAudioDevice = 'updateAudioDevice';
  static const String audioSessionDidDrop = 'audioSessionDidDrop';
  static const String audioSessionDidStop = 'audioSessionDidStop';
}
