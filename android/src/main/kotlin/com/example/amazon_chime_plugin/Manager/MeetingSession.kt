package com.example.amazon_chime_plugin.Manager

import android.content.Context
import android.media.AudioDeviceInfo
import android.media.AudioManager
import android.media.AudioPlaybackConfiguration
import android.os.Build
import androidx.annotation.RequiresApi
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AudioVideoConfiguration
import com.amazonaws.services.chime.sdk.meetings.audiovideo.audio.AudioStreamType
import com.amazonaws.services.chime.sdk.meetings.device.MediaDeviceType
import com.amazonaws.services.chime.sdk.meetings.session.DefaultMeetingSession
import com.example.amazon_chime_plugin.PlatoformRequester.Errors.AmazonChimeError
import java.util.Timer
import kotlin.concurrent.schedule

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
            Timer().schedule(5000) {
                // 遅延後に実行したい処理をここに記述
                println("----------------------------------------------------------------------------------------------------")
                println(audioVideo.listAudioDevices())
                println("ActiveAudioDevice: ${audioVideo.getActiveAudioDevice()?.id}, ${audioVideo.getActiveAudioDevice()?.type}, ${audioVideo.getActiveAudioDevice()?.label},")
                val activeAudioDevice = audioVideo.getActiveAudioDevice()
                println("↑ChimeのAudioList--↓DeviceのAudioList")
                println(getActiveAudioOutputDevices(context))
                println("ActiveDeviceAudioDevice: ${getCurrentActiveAudioOutputDevice(context)?.id}, ${getCurrentActiveAudioOutputDevice(context)?.type}, ${getCurrentActiveAudioOutputDevice(context)?.productName}")
                println("----------------------------------------------------------------------------------------------------")
            }

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

    private fun getActiveAudioOutputDevices(context: Context): List<AudioDeviceInfo> {
        val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val audioDevices = audioManager.getDevices(AudioManager.GET_DEVICES_OUTPUTS)

        val activeAudioDevices = audioDevices.filter { device ->
            // 必要に応じてデバイスのフィルタリングを行います
            device.type == AudioDeviceInfo.TYPE_BLUETOOTH_A2DP ||
                    device.type == AudioDeviceInfo.TYPE_BUILTIN_SPEAKER ||
                    device.type == AudioDeviceInfo.TYPE_USB_DEVICE ||
                    device.type == AudioDeviceInfo.TYPE_WIRED_HEADPHONES
        }

        return activeAudioDevices
    }

    @RequiresApi(Build.VERSION_CODES.Q)
    fun getCurrentActiveAudioOutputDevice(context: Context): AudioDeviceInfo? {
        val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager

        // アクティブなオーディオ出力デバイスのリストを取得
        val audioDevices = audioManager.getDevices(AudioManager.GET_DEVICES_OUTPUTS)

        var currentActiveDevice: AudioDeviceInfo? = null

        // オーディオプレイバックのコールバックを設定
        val playbackCallback = object : AudioManager.AudioPlaybackCallback() {
            override fun onPlaybackConfigChanged(configs: List<AudioPlaybackConfiguration>) {
                for (config in configs) {
                    val device = config.audioDeviceInfo
                    if (device != null && device.type != AudioDeviceInfo.TYPE_UNKNOWN) {
                        currentActiveDevice = device
                        break
                    }
                }
            }
        }

        // コールバックを登録
        audioManager.registerAudioPlaybackCallback(playbackCallback, null)

        // 遅延後に現在アクティブなデバイスを取得
        Thread.sleep(100) // コールバックが呼ばれるまでの短い遅延

        // コールバックを解除
        audioManager.unregisterAudioPlaybackCallback(playbackCallback)

        return currentActiveDevice
    }
}
