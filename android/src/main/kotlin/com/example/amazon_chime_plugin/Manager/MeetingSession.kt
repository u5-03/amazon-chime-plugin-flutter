package com.example.amazon_chime_plugin.Manager

import android.content.Context
import android.media.AudioManager
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AudioVideoConfiguration
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AudioVideoFacade
import com.amazonaws.services.chime.sdk.meetings.audiovideo.audio.AudioRecordingPresetOverride
import com.amazonaws.services.chime.sdk.meetings.audiovideo.audio.AudioStreamType
import com.amazonaws.services.chime.sdk.meetings.session.DefaultMeetingSession
import com.example.amazon_chime_plugin.PlatoformRequester.Errors.AmazonChimeError

class MeetingSession private constructor() {
    companion object {
        val shared = MeetingSession()
    }

    private var _meetingSession: DefaultMeetingSession? = null
    private lateinit var context: Context
    var meetingSession: DefaultMeetingSession?
        get() = _meetingSession
        private set(value) {
            _meetingSession = value
        }

    fun setContext(context: Context) {
        this.context = context.applicationContext
    }

    fun setSession(session: DefaultMeetingSession) {
        meetingSession = session
    }

    fun removeSession() {
        restoreSpeakerSetting()
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
            setSpeakerSetting()
            audioVideo.startRemoteVideo()

            // Remove background noise
            // Ref: https://github.com/aws/amazon-chime-sdk-android?tab=readme-ov-file#amazon-voice-focus
            audioVideo.realtimeSetVoiceFocusEnabled(true);
        } else {
            throw AmazonChimeError.CustomError("Audio video is null").asFlutterError
        }
    }

    private fun setSpeakerSetting() {
        val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        audioManager.isSpeakerphoneOn = true
    }

    private fun restoreSpeakerSetting() {
        val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        audioManager.isSpeakerphoneOn = false
    }
}
