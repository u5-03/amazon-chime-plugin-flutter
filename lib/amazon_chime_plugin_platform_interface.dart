import 'package:amazon_chime_plugin/amazon_chime_plugin_method_channel.dart';
import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class AmazonChimePluginPlatform extends PlatformInterface {
  /// Constructs a AmazonChimePluginPlatform.
  AmazonChimePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static AmazonChimePluginPlatform _instance = MethodChannelAmazonChimePlugin();

  /// The default instance of [AmazonChimePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelAmazonChimePlugin].
  static AmazonChimePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AmazonChimePluginPlatform] when
  /// they register themselves.
  static set instance(AmazonChimePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Result<String, AmazonChimeError>> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Result<String, AmazonChimeError>>
      requestMicrophonePermissions() async {
    throw UnimplementedError(
      'requestMicrophonePermissions() has not been implemented.',
    );
  }

  Future<Result<String, AmazonChimeError>> requestCameraPermissions() async {
    throw UnimplementedError(
      'requestCameraPermissions() has not been implemented.',
    );
  }
}
