package com.example.amazon_chime_plugin.Views.VideoTile

import android.content.Context
import android.os.Looper
import android.view.View
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.DefaultVideoRenderView
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoScalingType
import com.amazonaws.services.chime.sdk.meetings.utils.logger.ConsoleLogger
import com.example.amazon_chime_plugin.Manager.MeetingSession
import io.flutter.plugin.platform.PlatformView

internal class VideoTileView(context: Context?, viewId: Int, creationParams: Map<String?, Any?>?): PlatformView {
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
        val params = creationParams as Map<String, Any>
        tileId = params["tileId"] as Int
        val isScaleToFill = params["isScaleToFill"] as Boolean
        val isMirror = params["isMirror"] as Boolean
        view.scalingType = if(isScaleToFill) VideoScalingType.AspectFill else VideoScalingType.AspectFit
        view.mirror = isMirror
        // // Memo: without delay, tileView won't present when re-display tileView
        android.os.Handler(Looper.getMainLooper()).postDelayed( {
            MeetingSession.shared.meetingSession?.audioVideo?.bindVideoView(view, tileId)
                ?: videoTileViewLogger.error("VideoTileView", "Error while binding video view.")
        }, 300)
    }
}
