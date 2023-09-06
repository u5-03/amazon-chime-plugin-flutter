import 'package:amazon_chime_plugin/api/api.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/features/meeting/data/meeting_repository.dart';
import 'package:amazon_chime_plugin/features/meeting/models/meeting/join_info_model.dart';
import 'package:amazon_chime_plugin/plugin/amazon_chime_plugin_interface.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_requester.dart';

/// An implementation of AmazonChimePluginRequesterPlatform that uses method channels.
class AmazonChimePlugin implements AmazonChimePluginInterface {
  AmazonChimePlugin(this.meetingRepository) : super();

  @override
  final MeetingRepository meetingRepository;
  final requester = AmazonChimeRequester();

  @override
  Future<Result<String, AmazonChimeError>> getPlatformVersion() async {
    return requester.getPlatformVersion();
  }

  @override
  Future<Result<String, AmazonChimeError>>
      requestMicrophonePermissions() async {
    return requester.requestMicrophonePermissions();
  }

  @override
  Future<Result<String, AmazonChimeError>> requestCameraPermissions() async {
    return requester.requestCameraPermissions();
  }

  @override
  Future<Result<String, AmazonChimeError>> initialAudioSelection() async {
    return requester.initialAudioSelection();
  }

  @override
  Future<Result<List<String>, AmazonChimeError>> listAudioDevices() async {
    return requester.listAudioDevices();
  }

  @override
  Future<Result<String, AmazonChimeError>> updateCurrentDevice(
    String deviceLabel,
  ) async {
    return requester.updateCurrentDevice(deviceLabel);
  }

  @override
  Future<Result<void, AmazonChimeError>> startLocalVideo() async {
    return requester.startLocalVideo();
  }

  @override
  Future<Result<void, AmazonChimeError>> stopLocalVideo() async {
    return requester.stopLocalVideo();
  }

  @override
  Future<Result<void, AmazonChimeError>> joinMeetingWithAPI(
    String meetingId,
    String attendeeName,
    ApiConfig config,
  ) async {
    return meetingRepository.joinMeetingWithAPI(
      meetingId,
      attendeeName,
      config,
    );
  }

  @override
  Future<Result<void, AmazonChimeError>> joinMeeting(
    JoinInfoModel info,
  ) async {
    return meetingRepository.joinMeeting(info);
  }

  @override
  Future<Result<void, AmazonChimeError>> stop() async {
    return requester.stop();
  }

  @override
  Future<Result<void, AmazonChimeError>> mute() async {
    return requester.mute();
  }

  @override
  Future<Result<void, AmazonChimeError>> unmute() async {
    return requester.unmute();
  }
}
