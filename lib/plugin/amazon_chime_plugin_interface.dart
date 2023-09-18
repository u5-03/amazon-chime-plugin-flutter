import 'package:amazon_chime_plugin/api/api.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_controller.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/utils/result.dart';

/// An implementation of AmazonChimePluginRequesterPlatform that uses method channels.
abstract interface class AmazonChimePluginInterface {
  AmazonChimePluginInterface(this.meetingRepository) : super();
  final MeetingController meetingRepository;

  Future<Result<String, AmazonChimeError>> getPlatformVersion();
  Future<Result<String, AmazonChimeError>> requestMicrophonePermissions();
  Future<Result<String, AmazonChimeError>> requestCameraPermissions();
  Future<Result<String, AmazonChimeError>> initialAudioSelection();
  Future<Result<List<String>, AmazonChimeError>> listAudioDevices();
  Future<Result<String, AmazonChimeError>> updateCurrentDevice(
    String deviceLabel,
  );
  Future<Result<void, AmazonChimeError>> startLocalVideo();
  Future<Result<void, AmazonChimeError>> stopLocalVideo();
  Future<Result<void, AmazonChimeError>> joinMeetingWithAPI(
    String meetingId,
    String attendeeName,
    ApiConfig config,
  );
  Future<Result<void, AmazonChimeError>> joinMeeting(
    JoinInfoModel info,
  );
  Future<Result<void, AmazonChimeError>> stop();
  Future<Result<void, AmazonChimeError>> mute();
  Future<Result<void, AmazonChimeError>> unmute();
}
