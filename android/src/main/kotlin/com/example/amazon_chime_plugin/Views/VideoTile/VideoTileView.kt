package com.example.amazon_chime_plugin.Views.VideoTile

import android.content.Context
import android.os.Looper
import android.view.View
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.DefaultVideoRenderView
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoScalingType
import com.amazonaws.services.chime.sdk.meetings.utils.logger.ConsoleLogger
import com.example.amazon_chime_plugin.Manager.MeetingSession
import io.flutter.plugin.platform.PlatformView
import java.util.logging.Handler

internal class VideoTileView(context: Context?, creationParams: Int?): PlatformView {
    private val view: DefaultVideoRenderView
    private val tileId: Int

    private val videoTileViewLogger: ConsoleLogger = ConsoleLogger()

    override fun getView(): View {
        return view
    }

    override fun dispose() {
        MeetingSession.shared.meetingSession?.audioVideo?.unbindVideoView(tileId)
    }

    init {
        view = DefaultVideoRenderView(context as Context)
        tileId = creationParams as Int
        view.scalingType = VideoScalingType.AspectFill
        view.mirror = true
        // // Memo: without delay, tileView won't present when re-display tileView
        android.os.Handler(Looper.getMainLooper()).postDelayed( {
            MeetingSession.shared.meetingSession?.audioVideo?.bindVideoView(view, tileId)
                ?: videoTileViewLogger.error("VideoTileView", "Error while binding video view.")
        }, 300)
    }
}
