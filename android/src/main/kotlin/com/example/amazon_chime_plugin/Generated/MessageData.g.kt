// Autogenerated from Pigeon (v12.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class MethodType(val raw: Int) {
  GETPLATFORMVERSION(0),
  REQUESTMICROPHONEPERMISSIONS(1),
  REQUESTCAMERAPERMISSIONS(2),
  INITIALAUDIOSELECTION(3),
  LISTAUDIODEVICES(4),
  UPDATEAUDIODEVICE(5),
  LOCALVIDEOON(6),
  LOCALVIDEOOFF(7),
  JOIN(8),
  MUTE(9),
  UNMUTE(10),
  STOP(11),
  VIDEOTILEADD(12),
  VIDEOTILEREMOVE(13),
  AUDIOSESSIONDIDDROP(14),
  AUDIOSESSIONDIDSTOP(15);

  companion object {
    fun ofRaw(raw: Int): MethodType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class AmazonChimeErrorType(val raw: Int) {
  UNKNOWN(0),
  INVALIDRESPONSE(1),
  RESPONSEMESSAGE(2),
  CUSTOMERROR(3);

  companion object {
    fun ofRaw(raw: Int): AmazonChimeErrorType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class JoinParameter (
  val meetingId: String,
  val externalMeetingId: String,
  val mediaRegion: String,
  val audioHostUrl: String,
  val audioFallbackUrl: String,
  val signalingUrl: String,
  val turnControlUrl: String,
  val externalUserId: String,
  val attendeeId: String,
  val joinToken: String

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): JoinParameter {
      val meetingId = list[0] as String
      val externalMeetingId = list[1] as String
      val mediaRegion = list[2] as String
      val audioHostUrl = list[3] as String
      val audioFallbackUrl = list[4] as String
      val signalingUrl = list[5] as String
      val turnControlUrl = list[6] as String
      val externalUserId = list[7] as String
      val attendeeId = list[8] as String
      val joinToken = list[9] as String
      return JoinParameter(meetingId, externalMeetingId, mediaRegion, audioHostUrl, audioFallbackUrl, signalingUrl, turnControlUrl, externalUserId, attendeeId, joinToken)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      meetingId,
      externalMeetingId,
      mediaRegion,
      audioHostUrl,
      audioFallbackUrl,
      signalingUrl,
      turnControlUrl,
      externalUserId,
      attendeeId,
      joinToken,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AttendeeInfo (
  val attendeeId: String,
  val externalUserId: String

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): AttendeeInfo {
      val attendeeId = list[0] as String
      val externalUserId = list[1] as String
      return AttendeeInfo(attendeeId, externalUserId)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      attendeeId,
      externalUserId,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class TileInfo (
  val tileId: Long,
  val attendeeId: String,
  val videoStreamContentWidth: Double,
  val videoStreamContentHeight: Double,
  val isLocalTile: Boolean,
  val isContent: Boolean

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): TileInfo {
      val tileId = list[0].let { if (it is Int) it.toLong() else it as Long }
      val attendeeId = list[1] as String
      val videoStreamContentWidth = list[2] as Double
      val videoStreamContentHeight = list[3] as Double
      val isLocalTile = list[4] as Boolean
      val isContent = list[5] as Boolean
      return TileInfo(tileId, attendeeId, videoStreamContentWidth, videoStreamContentHeight, isLocalTile, isContent)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      tileId,
      attendeeId,
      videoStreamContentWidth,
      videoStreamContentHeight,
      isLocalTile,
      isContent,
    )
  }
}

@Suppress("UNCHECKED_CAST")
private object RequesterToNativeCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          JoinParameter.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is JoinParameter -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface RequesterToNative {
  fun getPlatformVersion(callback: (Result<String>) -> Unit)
  fun initialAudioSelection(callback: (Result<String>) -> Unit)
  fun listAudioDevices(callback: (Result<List<String>>) -> Unit)
  fun updateCurrentDevice(deviceLabel: String, callback: (Result<String>) -> Unit)
  fun startLocalVideo(callback: (Result<Unit>) -> Unit)
  fun stopLocalVideo(callback: (Result<Unit>) -> Unit)
  fun startRemoteVideo(callback: (Result<Unit>) -> Unit)
  fun stopRemoteVideo(callback: (Result<Unit>) -> Unit)
  fun join(parameter: JoinParameter, callback: (Result<Unit>) -> Unit)
  fun stop(callback: (Result<Unit>) -> Unit)
  fun mute(callback: (Result<Unit>) -> Unit)
  fun unmute(callback: (Result<Unit>) -> Unit)
  fun switchCamera(callback: (Result<Unit>) -> Unit)

  companion object {
    /** The codec used by RequesterToNative. */
    val codec: MessageCodec<Any?> by lazy {
      RequesterToNativeCodec
    }
    /** Sets up an instance of `RequesterToNative` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: RequesterToNative?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.getPlatformVersion", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.getPlatformVersion() { result: Result<String> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.initialAudioSelection", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.initialAudioSelection() { result: Result<String> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.listAudioDevices", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.listAudioDevices() { result: Result<List<String>> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.updateCurrentDevice", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceLabelArg = args[0] as String
            api.updateCurrentDevice(deviceLabelArg) { result: Result<String> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.startLocalVideo", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.startLocalVideo() { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.stopLocalVideo", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.stopLocalVideo() { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.startRemoteVideo", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.startRemoteVideo() { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.stopRemoteVideo", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.stopRemoteVideo() { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.join", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val parameterArg = args[0] as JoinParameter
            api.join(parameterArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.stop", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.stop() { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.mute", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.mute() { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.unmute", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.unmute() { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToNative.switchCamera", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.switchCamera() { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
@Suppress("UNCHECKED_CAST")
private object RequesterToFlutterCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AttendeeInfo.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          TileInfo.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is AttendeeInfo -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is TileInfo -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class RequesterToFlutter(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by RequesterToFlutter. */
    val codec: MessageCodec<Any?> by lazy {
      RequesterToFlutterCodec
    }
  }
  fun audioSessionDidDrop(callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.audioSessionDidDrop", codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun audioSessionDidStop(callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.audioSessionDidStop", codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun connectionDidRecover(callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.connectionDidRecover", codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun connectionDidBecomePoor(callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.connectionDidBecomePoor", codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun audioSessionDidCancelReconnect(callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.audioSessionDidCancelReconnect", codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun videoSessionDidStartConnecting(callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoSessionDidStartConnecting", codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun audioSessionDidStartConnecting(reconnectingArg: Boolean, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.audioSessionDidStartConnecting", codec)
    channel.send(listOf(reconnectingArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun audioSessionDidStart(reconnectingArg: Boolean, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.audioSessionDidStart", codec)
    channel.send(listOf(reconnectingArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun cameraSendAvailabilityDidChange(availableArg: Boolean, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.cameraSendAvailabilityDidChange", codec)
    channel.send(listOf(availableArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun remoteVideoSourcesDidBecomeAvailable(sourcesArg: List<String>, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.remoteVideoSourcesDidBecomeAvailable", codec)
    channel.send(listOf(sourcesArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun remoteVideoSourcesDidBecomeUnavailable(sourcesArg: List<String>, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.remoteVideoSourcesDidBecomeUnavailable", codec)
    channel.send(listOf(sourcesArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun joined(infoArg: AttendeeInfo, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.joined", codec)
    channel.send(listOf(infoArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun left(infoArg: AttendeeInfo, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.left", codec)
    channel.send(listOf(infoArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun dropped(infoArg: AttendeeInfo, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.dropped", codec)
    channel.send(listOf(infoArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun muted(infoArg: AttendeeInfo, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.muted", codec)
    channel.send(listOf(infoArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun unmuted(infoArg: AttendeeInfo, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.unmuted", codec)
    channel.send(listOf(infoArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun videoTileAdded(infoArg: TileInfo, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileAdded", codec)
    channel.send(listOf(infoArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun videoTileRemoved(infoArg: TileInfo, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.amazon_chime_plugin.RequesterToFlutter.videoTileRemoved", codec)
    channel.send(listOf(infoArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
}
