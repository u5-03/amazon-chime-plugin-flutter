abstract class AudioDevicesInterface {
  void initialAudioSelection() {}

  Future<void> listAudioDevices() async {}

  Future<void> updateCurrentAudioDevice(String device) async {}
}
