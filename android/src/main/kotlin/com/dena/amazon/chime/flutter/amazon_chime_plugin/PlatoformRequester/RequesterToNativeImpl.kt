package com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester

import FlutterError
import JoinParameter
import ParticipantInfo
import RequesterToNative
import android.os.Build
import android.content.Context
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AttendeeInfo
import com.amazonaws.services.chime.sdk.meetings.audiovideo.SignalUpdate
import com.amazonaws.services.chime.sdk.meetings.audiovideo.VolumeUpdate
import com.amazonaws.services.chime.sdk.meetings.realtime.RealtimeObserver
import com.amazonaws.services.chime.sdk.meetings.session.Attendee
import com.amazonaws.services.chime.sdk.meetings.session.CreateAttendeeResponse
import com.amazonaws.services.chime.sdk.meetings.session.CreateMeetingResponse
import com.amazonaws.services.chime.sdk.meetings.session.DefaultMeetingSession
import com.amazonaws.services.chime.sdk.meetings.session.MediaPlacement
import com.amazonaws.services.chime.sdk.meetings.session.Meeting
import com.amazonaws.services.chime.sdk.meetings.session.MeetingSessionConfiguration
import com.amazonaws.services.chime.sdk.meetings.utils.logger.ConsoleLogger
import com.dena.amazon.chime.flutter.amazon_chime_plugin.AmazonChimePlugin
import com.dena.amazon.chime.flutter.amazon_chime_plugin.Manager.MeetingSession
import com.dena.amazon.chime.flutter.amazon_chime_plugin.PermissionManager
import com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester.Models.ResponseMessageKind
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class RequesterToNativeImpl(permissionManager: PermissionManager, context: Context): RequesterToNative,
    RealtimeObserver {
    private val applicationScope: CoroutineScope = CoroutineScope(Dispatchers.IO)
    private val permissionManager = permissionManager
    private var job: Job? = null
    private val context: Context

    init {
        this.context = context
        setupAudioVideoFacadeObservers()
    }

    fun cancel() {
        job?.cancel()
    }

    private fun setupAudioVideoFacadeObservers() {
        MeetingSession.shared.meetingSession?.audioVideo.addRealtimeObserver(this);
    }

    // MEMO: 実装時の調査で、エラーをthrowする場合、上記のsendMessageはFlutterError以外のExceptionなどをthrowすると、アプリが
    // クラッシュしたので、エラーをthrowする場合、AmazonChimeErrorで定義後に必ずasFlutterErrorで変換してthrowする
    // Errorの場合は、`throw AmazonChimeError.InvalidResponse.asFlutterError`のように記述する
    override fun getPlatformVersion(callback: (Result<String>) -> Unit) {
        callback(Result.success("Android ${Build.VERSION.RELEASE}"))
    }

    override fun requestMicrophonePermissions(callback: (Result<String>) -> Unit) {
        applicationScope.launch {
            try {
                val result = permissionManager.requestMicrophonePermission()
                callback(Result.success(result.rawValue))
            } catch (error: FlutterError) {
                callback(Result.failure(error))
            }
        }
    }

    override fun requestCameraPermissions(callback: (Result<String>) -> Unit) {
        applicationScope.launch {
            try {
                val result = permissionManager.requestVideoPermission()
                callback(Result.success(result.rawValue))
            } catch (error: FlutterError) {
                callback(Result.failure(error))
            }
        }
    }

    override fun initialAudioSelection(callback: (Result<String>) -> Unit) {
        val initialAudioDevice = MeetingSession.shared.meetingSession?.audioVideo?.getActiveAudioDevice()
        if (initialAudioDevice != null) {
            callback(Result.success(initialAudioDevice.label))
        } else {
            callback(Result.failure(AmazonChimeError.ResponseMessage(ResponseMessageKind.MEETING_SESSION_IS_NULL).asFlutterError))
        }
    }

    override fun listAudioDevices(callback: (Result<List<String>>) -> Unit) {

        val audioDevices = MeetingSession.shared.meetingSession?.audioVideo?.listAudioDevices()
        if (audioDevices != null) {
            callback(Result.success(audioDevices.map { device -> device.label }))
        } else {
            callback(Result.failure(AmazonChimeError.ResponseMessage(ResponseMessageKind.MEETING_SESSION_IS_NULL).asFlutterError))
        }
    }

    override fun updateCurrentDevice(deviceLabel: String, callback: (Result<String>) -> Unit) {
        val audioDevices = MeetingSession.shared.meetingSession?.audioVideo?.listAudioDevices()
        if (audioDevices != null) {
            val device = audioDevices.firstOrNull { it.label == deviceLabel }
            if (device != null) {
                MeetingSession.shared.meetingSession?.audioVideo?.chooseAudioDevice(mediaDevice = device)
                callback(Result.success(ResponseMessageKind.MICROPHONE_DEVICE_UPDATED.rawValue))
            } else {
                callback(Result.failure(AmazonChimeError.ResponseMessage(type = ResponseMessageKind.MICROPHONE_DEVICE_UPDATE_FAILED)))
            }
        } else {
            MeetingSession.shared.meetingSession?.logger?.error(tag = "", msg = ResponseMessageKind.FAILED_TO_LIST_MICROPHONE_DEVICES.rawValue)
            callback(Result.failure(AmazonChimeError.ResponseMessage(type = ResponseMessageKind.FAILED_TO_LIST_MICROPHONE_DEVICES).asFlutterError))
        }
    }

    override fun startLocalVideo(callback: (Result<Unit>) -> Unit) {
        val result: Unit? = MeetingSession.shared.meetingSession?.audioVideo?.startLocalVideo()
        if (result != null) {
            callback(Result.success(Unit))
        } else {
            callback(Result.failure(AmazonChimeError.CustomError("Failed to start local video!")))
        }
    }

    override fun stopLocalVideo(callback: (Result<Unit>) -> Unit) {
        MeetingSession.shared.meetingSession?.let { meetingSession ->
            meetingSession.audioVideo.stop()
            MeetingSession.shared.removeSession()
            callback(Result.success(Unit))
        } ?: run {
            callback(Result.failure(AmazonChimeError.CustomError(text = "Meeting session is nil")))
        }
    }

    override fun join(parameter: JoinParameter, callback: (Result<Unit>) -> Unit) {
        val createMeetingResponse = CreateMeetingResponse(
            Meeting(
                parameter.externalMeetingId,
                MediaPlacement(
                    parameter.audioFallbackUrl,
                    parameter.audioHostUrl,
                    parameter.signalingUrl,
                    parameter.turnControlUrl
                ),
                parameter.mediaRegion,
                parameter.meetingId
            )
        )
        val createAttendeeResponse =
            CreateAttendeeResponse(
                Attendee(
                    parameter.attendeeId,
                    parameter.externalUserId,
                    parameter.joinToken
                )
            )
        val meetingSessionConfiguration = MeetingSessionConfiguration(
            createMeetingResponse,
            createAttendeeResponse
        )

        val meetingSession =
            DefaultMeetingSession(meetingSessionConfiguration, ConsoleLogger(), context)

        MeetingSession.shared.setSession(meetingSession)
        return MeetingSession.shared.startMeetingAudio()
    }

    override fun stop(callback: (Result<Unit>) -> Unit) {
        MeetingSession.shared.meetingSession?.audioVideo?.let { audioVideo ->
            audioVideo.stop()
            MeetingSession.shared.removeSession()
            // TODO: implement
//            removeObservers()
            callback(Result.success(Unit))
        } ?: run {
            callback(Result.failure(AmazonChimeError.CustomError(text = "Meeting audioVideo is nil")))
        }
    }

    override fun mute(callback: (Result<Unit>) -> Unit) {
        MeetingSession.shared.meetingSession?.audioVideo?.let { audioVideo ->
            val result = audioVideo.realtimeLocalMute()
            if (result) {
                callback(Result.success(Unit))
            } else {
                callback(Result.failure(AmazonChimeError.CustomError("Failed to switch to mute")))
            }
        } ?: run {
            callback(Result.failure(AmazonChimeError.CustomError(text = "Meeting audioVideo is nil")))
        }
    }

    override fun unmute(callback: (Result<Unit>) -> Unit) {
        MeetingSession.shared.meetingSession?.audioVideo?.let { audioVideo ->
            val result = audioVideo.realtimeLocalUnmute()
            if (result) {
                callback(Result.success(Unit))
            } else {
                callback(Result.failure(AmazonChimeError.CustomError("Failed to switch to unmute")))
            }
        } ?: run {
            callback(Result.failure(AmazonChimeError.CustomError(text = "Meeting audioVideo is nil")))
        }


//       override fun onAttendeesDropped(attendeeInfo: Array<AttendeeInfo>) {
//
//        }
//
//        override fun onAttendeesJoined(attendeeInfo: Array<AttendeeInfo>) {
//
//        }
//
//        override fun onAttendeesLeft(attendeeInfo: Array<AttendeeInfo>) {
//            for (currentAttendeeInfo in attendeeInfo) {
//                val info = ParticipantInfo(
//                    currentAttendeeInfo.attendeeId,
//                    currentAttendeeInfo.externalUserId
//                )
//                AmazonChimePlugin.requester?.left(info) {}
//            }
//        }
//
//        override fun onAttendeesMuted(attendeeInfo: Array<AttendeeInfo>) {
//            for (currentAttendeeInfo in attendeeInfo) {
//                val info = ParticipantInfo(
//                    currentAttendeeInfo.attendeeId,
//                    currentAttendeeInfo.externalUserId
//                )
//                AmazonChimePlugin.requester?.muted(info) {}
//            }
//        }
//
//        override fun onAttendeesUnmuted(attendeeInfo: Array<AttendeeInfo>) {
//            for (currentAttendeeInfo in attendeeInfo) {
//                val info = ParticipantInfo(
//                    currentAttendeeInfo.attendeeId,
//                    currentAttendeeInfo.externalUserId
//                )
//                AmazonChimePlugin.requester?.unmuted(info) {}
//            }
//        }
//
//        override fun onSignalStrengthChanged(signalUpdates: Array<SignalUpdate>) {
//            TODO("Not yet implemented")
//        }
//
//        override fun onVolumeChanged(volumeUpdates: Array<VolumeUpdate>) {
//            TODO("Not yet implemented")
//        }
    }

    // MARK: RealtimeObserver
    override fun onAttendeesDropped(attendeeInfo: Array<AttendeeInfo>) {
        for (currentAttendeeInfo in attendeeInfo) {
            val info = ParticipantInfo(
                currentAttendeeInfo.attendeeId,
                currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.dropped(info) {}
        }
    }

    override fun onAttendeesJoined(attendeeInfo: Array<AttendeeInfo>) {
        for (currentAttendeeInfo in attendeeInfo) {
            val info = ParticipantInfo(
                currentAttendeeInfo.attendeeId,
                currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.joined(info) {}
        }
    }

    override fun onAttendeesLeft(attendeeInfo: Array<AttendeeInfo>) {
        TODO("Not yet implemented")
    }

    override fun onAttendeesMuted(attendeeInfo: Array<AttendeeInfo>) {
        TODO("Not yet implemented")
    }

    override fun onAttendeesUnmuted(attendeeInfo: Array<AttendeeInfo>) {
        TODO("Not yet implemented")
    }

    override fun onSignalStrengthChanged(signalUpdates: Array<SignalUpdate>) {
        TODO("Not yet implemented")
    }

    override fun onVolumeChanged(volumeUpdates: Array<VolumeUpdate>) {
        TODO("Not yet implemented")
    }

//    private fun removeObservers() {
//        realtimeObserver?.let {
//            meetingSession?.audioVideo?.removeRealtimeObserver(it)
//        }
//        audioVideoObserver?.let {
//            meetingSession?.audioVideo?.removeAudioVideoObserver(it)
//        }
//        videoTileObserver?.let {
//            meetingSession?.audioVideo?.removeVideoTileObserver(it)
//        }
//    }
}
