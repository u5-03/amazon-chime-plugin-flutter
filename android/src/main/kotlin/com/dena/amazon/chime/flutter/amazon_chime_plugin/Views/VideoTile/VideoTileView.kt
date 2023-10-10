package com.dena.amazon.chime.flutter.amazon_chime_plugin.Views.VideoTile

import android.content.Context
import android.view.View
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.DefaultVideoRenderView
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoScalingType
import com.amazonaws.services.chime.sdk.meetings.utils.logger.ConsoleLogger
import com.dena.amazon.chime.flutter.amazon_chime_plugin.Manager.MeetingSession
import io.flutter.plugin.platform.PlatformView

internal class VideoTileView(context: Context?, creationParams: Int?): PlatformView {
    private val view: DefaultVideoRenderView

    private val videoTileViewLogger: ConsoleLogger = ConsoleLogger()

    override fun getView(): View {
        return view
    }

    override fun dispose() {}

    init {
        view = DefaultVideoRenderView(context as Context)
        view.scalingType = VideoScalingType.AspectFit
        MeetingSession.shared.meetingSession?.audioVideo?.bindVideoView(view, creationParams as Int)
            ?: videoTileViewLogger.error("VideoTileView", "Error while binding video view.")
    }
}