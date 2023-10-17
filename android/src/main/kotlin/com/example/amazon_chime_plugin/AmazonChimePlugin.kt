package com.example.amazon_chime_plugin

import JoinParameter
import RequesterToNative
import RequesterToFlutter
import androidx.annotation.NonNull
import android.content.Context
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import com.example.amazon_chime_plugin.PlatoformRequester.RequesterToNativeImpl // ←これの実装が原因くさい
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import io.flutter.embedding.engine.plugins.FlutterPlugin
import com.example.amazon_chime_plugin.Views.VideoTile.VideoTileFactory

// After modified, must modify ios/dart defition too.
enum class PlatformViewKind(val rawValue: String) {
  VIDEO_TILE("videoTile")
}

/** AmazonChimePlugin */
public class AmazonChimePlugin: FlutterPlugin {
  companion object {
    var requester: RequesterToFlutter? = null
  }

  // MARK: FlutterPlugin
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    // throw IllegalStateException("Another condition was not met!")
    RequesterToNative.setUp(flutterPluginBinding.binaryMessenger, RequesterToNativeImpl(flutterPluginBinding.applicationContext))
    requester = RequesterToFlutter(flutterPluginBinding.binaryMessenger)
     flutterPluginBinding
       .platformViewRegistry
       .registerViewFactory(PlatformViewKind.VIDEO_TILE.rawValue, VideoTileFactory())
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    RequesterToNative.setUp(binding.binaryMessenger, null)
    requester = null
  }

  // // MARK: ActivityAware
  // override fun onAttachedToActivity(binding: ActivityPluginBinding) {
  //   val activity = binding.activity
  //   throw IllegalStateException("Another condition was not met!")

    // binaryMessenger?.let { binaryMessenger ->
      // Ref: https://pub.dev/packages/pigeon
      //  RequesterToNative.setUp(binaryMessenger, RequesterToNativeImpl(permissionManager, context = activity.applicationContext))
      //  requester = RequesterToFlutter(binaryMessenger)
      // throw IllegalStateException("Another condition was not met!")
    // }
  // }

  // override fun onDetachedFromActivityForConfigChanges() {
  //   binaryMessenger = null
  // }

  // override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  //   // onAttachedToActivity(binding)
  // }

  // override fun onDetachedFromActivity() {
  //   // binaryMessenger = null
  // }
}
