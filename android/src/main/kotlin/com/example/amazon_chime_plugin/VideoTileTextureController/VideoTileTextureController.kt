import android.content.Context
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoFrame
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoRenderView
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.buffer.VideoFrameI420Buffer
import com.example.amazon_chime_plugin.Manager.MeetingSession
import android.opengl.GLES20
import android.opengl.GLSurfaceView
import android.opengl.EGL14
import android.util.Log
import android.view.Surface
import android.view.SurfaceView
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.DefaultVideoRenderView
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.gl.SurfaceRenderView
import io.flutter.view.TextureRegistry
import java.nio.ByteBuffer
import javax.microedition.khronos.egl.EGLConfig
import javax.microedition.khronos.opengles.GL10

class VideoTileTextureController(
    private val tileId: Int,
    private val surfaceTextureEntry: TextureRegistry.SurfaceTextureEntry,
    private val context: Context
) : SurfaceRenderView(context) {

    companion object {
        private const val UNINITIALIZED_TEXTURE_ID: Long = -1L
    }

    private var _textureId: Long = UNINITIALIZED_TEXTURE_ID
    val textureId: Long
        get() = _textureId
    private var surfaceTextureId: Int = 0
    private lateinit var textureBuffer: ByteBuffer
    private var width: Int = 640 // デフォルトの幅
    private var height: Int = 480 // デフォルトの高さ

    private var surface: Surface? = null

    init {
        try {
            _textureId = surfaceTextureEntry.id() ?: UNINITIALIZED_TEXTURE_ID
            val surfaceTexture = surfaceTextureEntry.surfaceTexture()
            surface = Surface(surfaceTexture)
            var videoRenderView = DefaultVideoRenderView(context as Context)
            // Amazon Chime SDKのビデオタイルにこのコントローラをバインド
            MeetingSession.shared.meetingSession?.audioVideo?.bindVideoView(this, tileId)
            generateGreenFrame()
            MeetingSession.shared.meetingSession?.audioVideo

            // デバッグメッセージ
            Log.d("VideoTileTextureController", "Controller initialized with texture ID: $_textureId")
        } catch (e: Exception) {
            Log.e("VideoTileTextureController", "Error initializing VideoTileTextureController", e)
            throw e
        }
    }

    private fun generateGreenFrame() {
        val size = width * height * 4
        textureBuffer = ByteBuffer.allocate(size)
        for (i in 0 until size step 4) {
            textureBuffer.put(i, 0.toByte())      // R
            textureBuffer.put(i + 1, 255.toByte()) // G
            textureBuffer.put(i + 2, 0.toByte())  // B
            textureBuffer.put(i + 3, 255.toByte()) // A
        }
        textureBuffer.position(0)
    }

    fun dispose() {
        surfaceTextureEntry.release()
        surface?.release()
    }

    private fun updateFrame(buffer: ByteBuffer, width: Int, height: Int) {
        this.textureBuffer = buffer
        this.width = width
        this.height = height
    }

    // GLSurfaceView.Renderer
//    override fun onSurfaceCreated(gl: GL10?, config: EGLConfig?) {
//        GLES20.glClearColor(0.0f, 0.0f, 0.0f, 1.0f)
//        val textures = IntArray(1)
//        GLES20.glGenTextures(1, textures, 0)
//        surfaceTextureId = textures[0]
//        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, surfaceTextureId)
//        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_LINEAR, GLES20.GL_LINEAR)
//        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR)
//        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR)
//        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE)
//        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE)
//
//        checkGlError("onSurfaceCreated")
//        // デバッグメッセージ
//        Log.d("VideoTileTextureController", "Texture created and bound with ID: $surfaceTextureId")
//    }
//
//    private fun checkGlError(glOperation: String) {
//        var error: Int
//        while (GLES20.glGetError().also { error = it } != GLES20.GL_NO_ERROR) {
//            Log.e("VideoTileTextureController", "$glOperation: glError $error")
//            throw RuntimeException("$glOperation: glError $error")
//        }
//    }

//    override fun onDrawFrame(gl: GL10?) {
//        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT)
//        if (::textureBuffer.isInitialized) {
//            GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, surfaceTextureId)
//            GLES20.glTexImage2D(
//                GLES20.GL_TEXTURE_2D, 0, GLES20.GL_RGBA, width, height, 0,
//                GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, textureBuffer
//            )
//            checkGlError("onDrawFrame")
//
//            // デバッグメッセージ
//            Log.d("VideoTileTextureController", "Frame drawn with texture ID: $surfaceTextureId")
//        }
//    }
//
//    override fun onSurfaceChanged(gl: GL10?, width: Int, height: Int) {
//        GLES20.glViewport(0, 0, width, height)
//    }

    // VideoRenderView
    override fun onVideoFrameReceived(frame: VideoFrame) {
        return;
//        try {
//            // デバッグログ
//            Log.d("VideoTileTextureController", "onVideoFrameReceived called")
//
//            val buffer = frame.buffer as? VideoFrameI420Buffer ?: return
//
//            // デバッグログ
//            Log.d("VideoTileTextureController", "Buffer casted to VideoFrameI420Buffer")
//
//            val rgbBuffer = i420ToRgb(buffer.dataY, buffer.dataU, buffer.dataV, buffer.width, buffer.height)
//
//            // デバッグログ
//            Log.d("VideoTileTextureController", "Converted I420 to RGB")
//
//            updateFrame(rgbBuffer, buffer.width, buffer.height)
//
//            // デバッグログ
//            Log.d("VideoTileTextureController", "Frame updated")
//
//            // 必要に応じてGLSurfaceViewをリフレッシュ
//            surfaceTextureEntry.surfaceTexture().setDefaultBufferSize(buffer.width, buffer.height)
//
//            // デバッグログ
//            Log.d("VideoTileTextureController", "SurfaceTexture buffer size set")
//
//            // OpenGLコンテキストを確認
//            val eglContext = EGL14.eglGetCurrentContext()
//            if (eglContext == EGL14.EGL_NO_CONTEXT) {
//                Log.e("VideoTileTextureController", "No EGL context available")
//                return
//            }
//
//            // 描画をトリガー
//            surfaceTextureEntry.surfaceTexture().updateTexImage()
//
//            // デバッグログ
//            Log.d("VideoTileTextureController", "Texture image updated")
//        } catch (e: Exception) {
//            Log.e("VideoTileTextureController", "Error in onVideoFrameReceived", e)
//        }
    }
}
