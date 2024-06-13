abstract class AudioDevicesInterface {
  void getActiveAudioDevice() {}

  Future<void> listAudioDevices() async {}

  Future<void> updateCurrentAudioDevice(String device) async {}
}
