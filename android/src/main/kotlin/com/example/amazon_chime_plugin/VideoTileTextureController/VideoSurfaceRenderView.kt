import android.content.Context
import android.graphics.SurfaceTexture
import android.opengl.GLES20
import android.opengl.GLSurfaceView
import android.util.AttributeSet
import android.view.Surface
import android.view.SurfaceHolder
import io.flutter.view.TextureRegistry
import com.example.amazon_chime_plugin.Manager.MeetingSession
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.gl.SurfaceRenderView
import javax.microedition.khronos.egl.EGLConfig
import javax.microedition.khronos.opengles.GL10

class VideoSurfaceRenderView(
    context: Context,
    attrs: AttributeSet?,
    private val textureEntry: TextureRegistry.SurfaceTextureEntry,
    private val tileId: Int
) : SurfaceRenderView(context, attrs), GLSurfaceView.Renderer {

    private lateinit var surfaceTexture: SurfaceTexture
    private lateinit var flutterSurface: Surface
    private var _textureId: Long = UNINITIALIZED_TEXTURE_ID

    val textureId: Long
        get() = _textureId

    init {
        _textureId = textureEntry.id()
        MeetingSession.shared.meetingSession?.audioVideo?.bindVideoView(this, tileId)
//        setEGLContextClientVersion(2) // Use OpenGL ES 2.0
//        setRenderer(this)
//        renderMode = GLSurfaceView.RENDERMODE_CONTINUOUSLY
    }

    override fun surfaceCreated(holder: SurfaceHolder) {
        super.surfaceCreated(holder)
        // Initialize SurfaceTexture and Surface using the provided TextureEntry
        surfaceTexture = textureEntry.surfaceTexture()
        flutterSurface = Surface(surfaceTexture)

        // Set up OpenGL
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, _textureId.toInt())
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_NEAREST)
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR)

        surfaceTexture.attachToGLContext(_textureId.toInt())
    }

    override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {
        super.surfaceChanged(holder, format, width, height)
        // Handle surface size changes
    }

    override fun surfaceDestroyed(holder: SurfaceHolder) {
        super.surfaceDestroyed(holder)
        dispose()
    }

    override fun onDrawFrame(gl: GL10?) {
        // Update the texture and draw the frame
        surfaceTexture.updateTexImage()
        // Transfer the frame to the Flutter surface
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT or GLES20.GL_DEPTH_BUFFER_BIT)
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, _textureId.toInt())
        surfaceTexture.updateTexImage()
    }

    override fun onSurfaceChanged(gl: GL10?, width: Int, height: Int) {
        // Handle surface size changes
        GLES20.glViewport(0, 0, width, height)
    }

    override fun onSurfaceCreated(gl: GL10?, config: EGLConfig?) {
        // Initialize OpenGL resources
        GLES20.glClearColor(0.0f, 0.0f, 0.0f, 1.0f)
    }

    fun dispose() {
        surfaceTexture.release()
        flutterSurface.release()
    }

    companion object {
        private const val UNINITIALIZED_TEXTURE_ID = -1L
    }
}
