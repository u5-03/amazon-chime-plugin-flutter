package com.example.amazon_chime_plugin.Manager

import com.amazonaws.services.chime.sdk.meetings.audiovideo.AudioVideoFacade
import com.amazonaws.services.chime.sdk.meetings.session.DefaultMeetingSession
import com.example.amazon_chime_plugin.PlatoformRequester.AmazonChimeError

class MeetingSession private constructor() {
    companion object {
        val shared = MeetingSession()
    }

    private var _meetingSession: DefaultMeetingSession? = null
    var meetingSession: DefaultMeetingSession?
        get() = _meetingSession
        private set(value) {
            _meetingSession = value
        }

    fun setSession(session: DefaultMeetingSession) {
        meetingSession = session
    }

    fun removeSession() {
        meetingSession = null
    }

    @Throws(AmazonChimeError::class)
    fun startMeetingAudio() {
        val audioVideo =
            meetingSession?.audioVideo
        if (audioVideo != null) {
            audioVideo.start()
            audioVideo.startRemoteVideo()
        } else {
            throw AmazonChimeError.CustomError("Audio video is null").asFlutterError
        }
    }
}
