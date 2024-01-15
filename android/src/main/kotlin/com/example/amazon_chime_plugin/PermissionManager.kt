package com.example.amazon_chime_plugin


import FlutterError
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.example.amazon_chime_plugin.PlatoformRequester.Models.ResponseMessageKind
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.Continuation
import kotlin.coroutines.resume
import android.Manifest
import com.example.amazon_chime_plugin.PlatoformRequester.Errors.AmazonChimeError

class PermissionManager(
    private val activity: Activity
) {
    private val context: Context = activity.applicationContext
    private val permissionContinuations = mutableMapOf<Int, Continuation<Boolean>>()

    companion object {
        private const val CAMERA_PERMISSION_REQUEST_CODE = 1
        private const val MICROPHONE_PERMISSION_REQUEST_CODE = 2
        private val CAMERA_PERMISSIONS = arrayOf(
            Manifest.permission.CAMERA
        )
        private val MICROPHONE_PERMISSIONS = arrayOf(
            Manifest.permission.MODIFY_AUDIO_SETTINGS,
            Manifest.permission.RECORD_AUDIO,
        )
    }

    @Throws(FlutterError::class)
    suspend fun requestMicrophonePermission(): ResponseMessageKind {
        val permissions = MICROPHONE_PERMISSIONS
        val requestCode = MICROPHONE_PERMISSION_REQUEST_CODE
        return if (hasPermissionsAlready(MICROPHONE_PERMISSIONS)) {
            ResponseMessageKind.MICROPHONE_AUTHORIZED
        } else {
            val granted = requestPermission(permissions, requestCode)
            if (granted) {
                throw AmazonChimeError.ResponseMessage(ResponseMessageKind.MICROPHONE_AUTHORIZED).asFlutterError
            } else {
                throw AmazonChimeError.ResponseMessage(ResponseMessageKind.MICROPHONE_AUTH_NOT_GRANTED).asFlutterError
            }
        }
    }

    @Throws(FlutterError::class)
    suspend fun requestVideoPermission(): ResponseMessageKind {
        val permissions = CAMERA_PERMISSIONS
        val requestCode = CAMERA_PERMISSION_REQUEST_CODE
        return if (hasPermissionsAlready(CAMERA_PERMISSIONS)) {
            ResponseMessageKind.CAMERA_AUTHORIZED
        } else {
            val granted = requestPermission(permissions, requestCode)
            if (granted) {
                ResponseMessageKind.CAMERA_AUTHORIZED
            } else {
                throw AmazonChimeError.ResponseMessage(ResponseMessageKind.CAMERA_AUTH_NOT_GRANTED).asFlutterError
            }
        }
    }

    @Throws(FlutterError::class)
    fun onRequestPermissionsResult(requestCode: Int, grantResults: IntArray) {
        permissionContinuations[requestCode]?.let { continuation ->
            val granted = grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
            continuation.resume(granted)
            permissionContinuations.remove(requestCode)
        }
    }

    private suspend fun requestPermission(permissions: Array<String>, requestCode: Int): Boolean = suspendCancellableCoroutine { continuation ->
        permissionContinuations[requestCode] = continuation
        ActivityCompat.requestPermissions(activity, permissions, requestCode)
    }

    fun hasPermissionsAlready(PERMISSIONS: Array<String>): Boolean {
        return PERMISSIONS.all {
            ContextCompat.checkSelfPermission(context, it) == PackageManager.PERMISSION_GRANTED
        }
    }
}
