package com.example.amazon_chime_plugin.Manager

import android.content.Context
import android.media.AudioManager
import android.os.Looper
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AudioVideoConfiguration
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AudioVideoFacade
import com.amazonaws.services.chime.sdk.meetings.audiovideo.audio.AudioRecordingPresetOverride
import com.amazonaws.services.chime.sdk.meetings.audiovideo.audio.AudioStreamType
import com.amazonaws.services.chime.sdk.meetings.device.DeviceChangeObserver
import com.amazonaws.services.chime.sdk.meetings.device.MediaDevice
import com.amazonaws.services.chime.sdk.meetings.session.DefaultMeetingSession
import com.amazonaws.services.chime.sdk.meetings.session.Meeting
import com.example.amazon_chime_plugin.AmazonChimePlugin
import com.example.amazon_chime_plugin.PlatoformRequester.Errors.AmazonChimeError

class MeetingSession private constructor() {
    companion object {
        val shared = MeetingSession()
    }

    private var _meetingSession: DefaultMeetingSession? = null
    private var currentActiveAudioDevice: MediaDevice? = null
    private lateinit var context: Context
    var meetingSession: DefaultMeetingSession?
        get() = _meetingSession
        private set(value) {
            _meetingSession = value
        }

    private val observer = object: DeviceChangeObserver {
        override fun onAudioDeviceChanged(freshAudioDeviceList: List<MediaDevice>) {
            updateSelectedAudioDevice()
        }
    }

    fun setContext(context: Context) {
        this.context = context.applicationContext
    }

    fun setSession(session: DefaultMeetingSession) {
        meetingSession = session
    }

    fun removeSession() {
        meetingSession?.audioVideo?.removeDeviceChangeObserver(observer);
        meetingSession = null
    }

    @Throws(AmazonChimeError::class)
    fun startMeetingAudio() {
        val audioVideo =
            meetingSession?.audioVideo
        if (audioVideo != null) {
            val audioVideoConfiguration = AudioVideoConfiguration(
                audioStreamType = AudioStreamType.Music,
            )
            audioVideo.start(audioVideoConfiguration)
            audioVideo.startRemoteVideo()

            // Remove background noise
            // Ref: https://github.com/aws/amazon-chime-sdk-android?tab=readme-ov-file#amazon-voice-focus
            audioVideo.realtimeSetVoiceFocusEnabled(true);
            // Without delay, new audio won't be reflected or may be overridden by SDK
            android.os.Handler(Looper.getMainLooper()).postDelayed( {
                updateSelectedAudioDevice()
            }, 500)
        } else {
            throw AmazonChimeError.CustomError("Audio video is null").asFlutterError
        }

        audioVideo.addDeviceChangeObserver(observer)
    }

    private fun setActiveAudioDevice(mediaDevice: MediaDevice) {
        currentActiveAudioDevice = mediaDevice
    }

    private fun updateSelectedAudioDevice() {
        val audioVideo =
            meetingSession?.audioVideo ?: return
        val devices = audioVideo.listAudioDevices().sortedBy { it.order }
        if (devices.isNotEmpty()) {
            val device = devices[0]
            if (device == currentActiveAudioDevice) return
            audioVideo.chooseAudioDevice(device)
            setActiveAudioDevice(device)
            AmazonChimePlugin.requester?.didChangedAudioDevice(devices[0].label) {}
        }
    }
}
