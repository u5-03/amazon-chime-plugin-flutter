import 'package:permission_handler/permission_handler.dart';

final class PermissionManager {
  static Future<PermissionStatus> get microphonePermissionStatus =>
      Permission.microphone.status;
  static Future<PermissionStatus> get cameraPermissionStatus =>
      Permission.camera.status;
  static Future<PermissionStatus> requestMicrophonePermissions() async {
    if (await microphonePermissionStatus.isGranted) {
      return microphonePermissionStatus;
    } else {
      return _request(permission: Permission.microphone);
    }
  }

  static Future<PermissionStatus> requestCameraPermissions() async {
    if (await cameraPermissionStatus.isGranted) {
      return cameraPermissionStatus;
    } else {
      return _request(permission: Permission.camera);
    }
  }

  static Future<PermissionStatus> _request({required Permission permission}) =>
      permission.request();
}
