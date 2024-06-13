package com.example.amazon_chime_plugin.PlatoformRequester

import FlutterError
import JoinParameter
import AttendeeInfo
import RequesterToNative
import TileInfo
import android.os.Build
import android.content.Context
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AttendeeInfo as ChimeAttendeeInfo
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AudioVideoObserver
import com.amazonaws.services.chime.sdk.meetings.audiovideo.SignalUpdate
import com.amazonaws.services.chime.sdk.meetings.audiovideo.VolumeUpdate
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.RemoteVideoSource
import com.amazonaws.services.chime.sdk.meetings.realtime.RealtimeObserver
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoTileObserver
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoTileState
import com.amazonaws.services.chime.sdk.meetings.session.Attendee
import com.amazonaws.services.chime.sdk.meetings.session.CreateAttendeeResponse
import com.amazonaws.services.chime.sdk.meetings.session.CreateMeetingResponse
import com.amazonaws.services.chime.sdk.meetings.session.DefaultMeetingSession
import com.amazonaws.services.chime.sdk.meetings.session.MediaPlacement
import com.amazonaws.services.chime.sdk.meetings.session.Meeting
import com.amazonaws.services.chime.sdk.meetings.session.MeetingSessionConfiguration
import com.amazonaws.services.chime.sdk.meetings.session.MeetingSessionStatus
import com.amazonaws.services.chime.sdk.meetings.utils.logger.ConsoleLogger
import com.example.amazon_chime_plugin.AmazonChimePlugin
import com.example.amazon_chime_plugin.Manager.MeetingSession
import com.example.amazon_chime_plugin.PlatoformRequester.Errors.AmazonChimeError
import com.example.amazon_chime_plugin.PlatoformRequester.Models.ResponseMessageKind
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job

class RequesterToNativeImpl(context: Context): RequesterToNative, RealtimeObserver, VideoTileObserver,
    AudioVideoObserver {
    private var scope: CoroutineScope = CoroutineScope(Dispatchers.IO)
    private var job: Job? = null
    private val context: Context

    init {
        this.context = context
        MeetingSession.shared.setContext(context);
    }

    fun cancel() {
        job?.cancel()
    }

    private fun setupAudioVideoFacadeObservers() {
        MeetingSession.shared.meetingSession?.audioVideo?.addRealtimeObserver(this);
        MeetingSession.shared.meetingSession?.audioVideo?.addAudioVideoObserver(this);
        MeetingSession.shared.meetingSession?.audioVideo?.addVideoTileObserver(this);
    }

    // MEMO: 実装時の調査で、エラーをthrowする場合、上記のsendMessageはFlutterError以外のExceptionなどをthrowすると、アプリが
    // クラッシュしたので、エラーをthrowする場合、AmazonChimeErrorで定義後に必ずasFlutterErrorで変換してthrowする
    // Errorの場合は、`throw AmazonChimeError.InvalidResponse.asFlutterError`のように記述する
    override fun getPlatformVersion(callback: (Result<String>) -> Unit) {
        // throw IllegalStateException("Another condition was not met!")
        callback(Result.success("Android ${Build.VERSION.RELEASE}"))
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
               callback(Result.failure(AmazonChimeError.ResponseMessage(type = ResponseMessageKind.MICROPHONE_DEVICE_UPDATE_FAILED).asFlutterError))
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
           callback(Result.failure(AmazonChimeError.CustomError("Failed to start local video!").asFlutterError))
       }
   }

   override fun stopLocalVideo(callback: (Result<Unit>) -> Unit) {
       val result: Unit? = MeetingSession.shared.meetingSession?.audioVideo?.stopLocalVideo()
       if (result != null) {
           callback(Result.success(Unit))
       } else {
           callback(Result.failure(AmazonChimeError.CustomError("Failed to stop local video!").asFlutterError))
       }
   }

    override fun startRemoteVideo(callback: (Result<Unit>) -> Unit) {
        val result: Unit? = MeetingSession.shared.meetingSession?.audioVideo?.startRemoteVideo()
        if (result != null) {
            callback(Result.success(Unit))
        } else {
            callback(Result.failure(AmazonChimeError.CustomError("Failed to start local video!").asFlutterError))
        }
    }

    override fun stopRemoteVideo(callback: (Result<Unit>) -> Unit) {
        val result: Unit? = MeetingSession.shared.meetingSession?.audioVideo?.stopRemoteVideo()
        if (result != null) {
            callback(Result.success(Unit))
        } else {
            callback(Result.failure(AmazonChimeError.CustomError("Failed to stop local video!").asFlutterError))
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
       setupAudioVideoFacadeObservers()
       try {
           MeetingSession.shared.startMeetingAudio()
           callback(Result.success(Unit))
       } catch (error: FlutterError) {
           callback(Result.failure(error))
       }
    }

   override fun stop(callback: (Result<Unit>) -> Unit) {
       MeetingSession.shared.meetingSession?.audioVideo?.let { audioVideo ->
           audioVideo.stop()
           audioVideo.stopRemoteVideo()
           audioVideo.stopLocalVideo()
           removeObservers()
           MeetingSession.shared.removeSession()
           callback(Result.success(Unit))
       } ?: run {
           callback(Result.failure(AmazonChimeError.CustomError(text = "Meeting audioVideo is nil").asFlutterError))
       }
   }

   override fun mute(callback: (Result<Unit>) -> Unit) {
       MeetingSession.shared.meetingSession?.audioVideo?.let { audioVideo ->
           val result = audioVideo.realtimeLocalMute()
           if (result) {
               callback(Result.success(Unit))
           } else {
               callback(Result.failure(AmazonChimeError.CustomError("Failed to switch to mute").asFlutterError))
           }
       } ?: run {
           callback(Result.failure(AmazonChimeError.CustomError(text = "Meeting audioVideo is nil").asFlutterError))
       }
   }

   override fun unmute(callback: (Result<Unit>) -> Unit) {
       MeetingSession.shared.meetingSession?.audioVideo?.let { audioVideo ->
           val result = audioVideo.realtimeLocalUnmute()
           if (result) {
               callback(Result.success(Unit))
           } else {
               callback(Result.failure(AmazonChimeError.CustomError("Failed to switch to unmute").asFlutterError))
           }
       } ?: run {
           callback(Result.failure(AmazonChimeError.CustomError(text = "Meeting audioVideo is nil").asFlutterError))
       }
    }

    override fun switchCamera(callback: (Result<Unit>) -> Unit) {
        MeetingSession.shared.meetingSession?.audioVideo?.let { audioVideo ->
            audioVideo.switchCamera()
            callback(Result.success(Unit))
        } ?: run {
            callback(Result.failure(AmazonChimeError.CustomError(text = "Meeting audioVideo is nil").asFlutterError))
        }
     }

    override fun createTileTexture(tileId: Long, callback: (Result<Long>) -> Unit) {
        TODO("Not yet implemented")
    }

    override fun disposeTileTexture(tileId: Long, callback: (Result<Long>) -> Unit) {
        TODO("Not yet implemented")
    }

    // MARK: RealtimeObserver
    override fun onAttendeesDropped(attendeeInfo: Array<ChimeAttendeeInfo>) {
        for (currentAttendeeInfo in attendeeInfo) {
            val info = AttendeeInfo(
                currentAttendeeInfo.attendeeId,
                currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.dropped(info) {}
        }
    }

    override fun onAttendeesJoined(attendeeInfo: Array<ChimeAttendeeInfo>) {
        for (currentAttendeeInfo in attendeeInfo) {
            val info = AttendeeInfo(
                currentAttendeeInfo.attendeeId,
                currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.joined(info) {}
        }
    }

    override fun onAttendeesLeft(attendeeInfo: Array<ChimeAttendeeInfo>) {
        for (currentAttendeeInfo in attendeeInfo) {
            val info = AttendeeInfo(
                attendeeId = currentAttendeeInfo.attendeeId,
                externalUserId = currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.left(info, {})
        }
    }

    override fun onAttendeesMuted(attendeeInfo: Array<ChimeAttendeeInfo>) {
        for (currentAttendeeInfo in attendeeInfo) {
            val info = AttendeeInfo(
                attendeeId = currentAttendeeInfo.attendeeId,
                externalUserId = currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.muted(info, {})
        }
    }

    override fun onAttendeesUnmuted(attendeeInfo: Array<ChimeAttendeeInfo>) {
        for (currentAttendeeInfo in attendeeInfo) {
            val info = AttendeeInfo(
                attendeeId = currentAttendeeInfo.attendeeId,
                externalUserId = currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.unmuted(info, {})
        }
    }

    override fun onSignalStrengthChanged(signalUpdates: Array<SignalUpdate>) {
        // TODO("Not yet implemented")
    }

    override fun onVolumeChanged(volumeUpdates: Array<VolumeUpdate>) {
        // TODO("Not yet implemented")
    }

    // MARK: VideoTileObserver
    override fun onVideoTileAdded(tileState: VideoTileState) {
        val info = TileInfo(
            tileId = tileState.tileId.toLong(),
            attendeeId = tileState.attendeeId,
            videoStreamContentWidth = tileState.videoStreamContentWidth.toDouble(),
            videoStreamContentHeight = tileState.videoStreamContentHeight.toDouble(),
            isLocalTile = tileState.isLocalTile,
            isContent = tileState.isContent
        )
        AmazonChimePlugin.requester?.videoTileAdded(info, { })
    }

    override fun onVideoTilePaused(tileState: VideoTileState) {
        // Out of scope
    }

    override fun onVideoTileRemoved(tileState: VideoTileState) {
        val info = TileInfo(
            tileId = tileState.tileId.toLong(),
            attendeeId = tileState.attendeeId,
            videoStreamContentWidth = tileState.videoStreamContentWidth.toDouble(),
            videoStreamContentHeight = tileState.videoStreamContentHeight.toDouble(),
            isLocalTile = tileState.isLocalTile,
            isContent = tileState.isContent
        )
        AmazonChimePlugin.requester?.videoTileRemoved(info, { })
    }

    override fun onVideoTileResumed(tileState: VideoTileState) {
        // Out of scope
    }

    override fun onVideoTileSizeChanged(tileState: VideoTileState) {
        // Out of scope
    }

    private fun removeObservers() {
        MeetingSession.shared.meetingSession?.audioVideo?.removeRealtimeObserver(this);
        MeetingSession.shared.meetingSession?.audioVideo?.removeVideoTileObserver(this);
        MeetingSession.shared.meetingSession?.audioVideo?.removeAudioVideoObserver(this);
    }

    // MARK: AudioVideoObserver
    override fun onAudioSessionCancelledReconnect() {
        AmazonChimePlugin.requester?.audioSessionDidCancelReconnect {}
    }

    override fun onAudioSessionDropped() {
        AmazonChimePlugin.requester?.audioSessionDidDrop {}
    }

    override fun onAudioSessionStarted(reconnecting: Boolean) {
        AmazonChimePlugin.requester?.audioSessionDidStart(reconnecting) {}
    }

    override fun onAudioSessionStartedConnecting(reconnecting: Boolean) {
        AmazonChimePlugin.requester?.audioSessionDidStartConnecting(reconnecting) {}
    }

    override fun onAudioSessionStopped(sessionStatus: MeetingSessionStatus) {
        AmazonChimePlugin.requester?.audioSessionDidStop {}
    }

    override fun onCameraSendAvailabilityUpdated(available: Boolean) {
        AmazonChimePlugin.requester?.cameraSendAvailabilityDidChange(available) {}
    }

    override fun onConnectionBecamePoor() {
        AmazonChimePlugin.requester?.connectionDidBecomePoor {}
    }

    override fun onConnectionRecovered() {
        AmazonChimePlugin.requester?.connectionDidRecover {}
    }

    override fun onRemoteVideoSourceAvailable(sources: List<RemoteVideoSource>) {
        AmazonChimePlugin.requester?.remoteVideoSourcesDidBecomeAvailable(sources.map { it.attendeeId }) {}
    }

    override fun onRemoteVideoSourceUnavailable(sources: List<RemoteVideoSource>) {
        AmazonChimePlugin.requester?.remoteVideoSourcesDidBecomeUnavailable(sources.map { it.attendeeId }) {}
    }

    override fun onVideoSessionStartedConnecting() {
        AmazonChimePlugin.requester?.videoSessionDidStartConnecting {}
    }

    override fun onVideoSessionStarted(sessionStatus: MeetingSessionStatus) {}

    override fun onVideoSessionStopped(sessionStatus: MeetingSessionStatus) {}
}
