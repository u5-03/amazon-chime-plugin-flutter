import 'package:amazon_chime_plugin/api/api.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_controller.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/utils/result.dart';

/// An implementation of AmazonChimePluginRequesterPlatform that uses method channels.
abstract interface class AmazonChimePluginInterface {
  AmazonChimePluginInterface(this.meetingRepository) : super();
  final MeetingController meetingRepository;

  Future<Result<String>> getPlatformVersion();
  Future<Result<String>> initialAudioSelection();
  Future<Result<List<String>>> listAudioDevices();
  Future<Result<String>> updateCurrentDevice(
    String deviceLabel,
  );
  Future<Result<void>> startLocalVideo();
  Future<Result<void>> stopLocalVideo();
  Future<Result<void>> joinMeetingWithAPI(
    String meetingId,
    String attendeeName,
    ApiConfig config,
  );
  Future<Result<void>> joinMeeting(
    JoinInfoModel info,
  );
  Future<Result<void>> stop();
  Future<Result<void>> mute();
  Future<Result<void>> unmute();
}
