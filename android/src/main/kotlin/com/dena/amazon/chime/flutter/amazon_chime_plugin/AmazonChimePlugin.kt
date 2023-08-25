package com.dena.amazon.chime.flutter.amazon_chime_plugin

import RequesterToNative
import android.app.Activity
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester.RequesterToNativeImpl
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

/** AmazonChimePlugin */
class AmazonChimePlugin: FlutterPlugin, ActivityAware, PluginRegistry.RequestPermissionsResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var permissionManager: PermissionManager? = null
  private var binaryMessenger: BinaryMessenger? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "amazon_chime_plugin")
    binaryMessenger = flutterPluginBinding.binaryMessenger
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    val activity = binding.activity
    val permissionManager = PermissionManager(activity)
    this.permissionManager = permissionManager
    binaryMessenger?.let { binaryMessenger ->
      // Ref: https://pub.dev/packages/pigeon
      RequesterToNative.setUp(binaryMessenger, RequesterToNativeImpl(permissionManager))
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {
    binaryMessenger = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    binaryMessenger = null
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {}

  override fun onRequestPermissionsResult(
    requestCode: Int,
    permissions: Array<out String>,
    grantResults: IntArray
  ): Boolean {
    permissionManager?.onRequestPermissionsResult(requestCode, permissions, grantResults)
    return permissionManager?.hasPermissionsAlready(permissions as Array<String>) ?: false
  }
}

