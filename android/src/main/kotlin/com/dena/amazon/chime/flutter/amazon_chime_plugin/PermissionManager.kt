package com.dena.amazon.chime.flutter.amazon_chime_plugin

import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester.Models.ResponseMessage
import com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester.Models.ResponseMessageData
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.Continuation
import kotlin.coroutines.resume
import android.Manifest

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

    suspend fun requestMicrophonePermission(): ResponseMessageData {
        val permissions = MICROPHONE_PERMISSIONS
        val requestCode = MICROPHONE_PERMISSION_REQUEST_CODE
        return if (hasPermissionsAlready(MICROPHONE_PERMISSIONS)) {
            ResponseMessageData(true, ResponseMessage.MICROPHONE_AUTHORIZED)
        } else {
            val granted = requestPermission(permissions, requestCode)
            if (granted) {
                ResponseMessageData(true, ResponseMessage.MICROPHONE_AUTHORIZED)
            } else {
                ResponseMessageData(false, ResponseMessage.MICROPHONE_AUTH_NOT_GRANTED)
            }
        }
    }

    suspend fun requestVideoPermission(): ResponseMessageData {
        val permissions = CAMERA_PERMISSIONS
        val requestCode = CAMERA_PERMISSION_REQUEST_CODE
        return if (hasPermissionsAlready(MICROPHONE_PERMISSIONS)) {
            ResponseMessageData(true, ResponseMessage.CAMERA_AUTHORIZED)
        } else {
            val granted = requestPermission(permissions, requestCode)
            if (granted) {
                ResponseMessageData(true, ResponseMessage.CAMERA_AUTHORIZED)
            } else {
                ResponseMessageData(false, ResponseMessage.CAMERA_AUTH_NOT_GRANTED)
            }
        }
    }

    fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
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
