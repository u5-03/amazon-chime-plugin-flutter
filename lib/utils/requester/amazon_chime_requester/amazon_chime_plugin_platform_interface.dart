import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:amazon_chime_plugin/utils/requester/amazon_chime_requester/amazon_chime_plugin_method_channel.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class AmazonChimeRequesterPlatform extends PlatformInterface {
  /// Constructs a AmazonChimePlatform.
  AmazonChimeRequesterPlatform() : super(token: _token);

  static final Object _token = Object();

  static AmazonChimeRequesterPlatform _instance =
      MethodChannelAmazonChimeRequester();

  /// The default instance of [AmazonChimeRequesterPlatform] to use.
  ///
  /// Defaults to [MethodChannelAmazonChimeRequester].
  static AmazonChimeRequesterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AmazonChimeRequesterPlatform] when
  /// they register themselves.
  static set instance(AmazonChimeRequesterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Result<String>> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Result<String>> initialAudioSelection() async {
    throw UnimplementedError(
      'initialAudioSelection() has not been implemented.',
    );
  }

  Future<Result<List<String>>> listAudioDevices() async {
    throw UnimplementedError(
      'listAudioDevices() has not been implemented.',
    );
  }

  Future<Result<String>> updateCurrentDevice(
    String deviceLabel,
  ) async {
    throw UnimplementedError(
      'updateCurrentDevice() has not been implemented.',
    );
  }

  Future<Result<void>> startLocalVideo() async {
    throw UnimplementedError(
      'startLocalVideo() has not been implemented.',
    );
  }

  Future<Result<void>> stopLocalVideo() async {
    throw UnimplementedError(
      'stopLocalVideo() has not been implemented.',
    );
  }

  Future<Result<void>> join(
    JoinParameter parameter,
  ) async {
    throw UnimplementedError(
      'join() has not been implemented.',
    );
  }

  Future<Result<void>> stop() async {
    throw UnimplementedError(
      'stop() has not been implemented.',
    );
  }

  Future<Result<void>> mute() async {
    throw UnimplementedError(
      'mute() has not been implemented.',
    );
  }

  Future<Result<void>> unmute() async {
    throw UnimplementedError(
      'unmute() has not been implemented.',
    );
  }

  Future<Result<void>> switchLocalCamera() async {
    throw UnimplementedError(
      'switchLocalCamera() has not been implemented.',
    );
  }
}
