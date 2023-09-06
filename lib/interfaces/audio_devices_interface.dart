abstract class AudioDevicesInterface {
  void _initialAudioSelection() {}

  Future<void> _listAudioDevices() async {}

  Future<void> updateCurrentAudioDevice(String device) async {}
}
