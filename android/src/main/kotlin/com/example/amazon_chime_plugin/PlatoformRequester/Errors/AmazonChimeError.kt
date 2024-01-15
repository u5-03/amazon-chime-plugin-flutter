package com.example.amazon_chime_plugin.PlatoformRequester.Errors
import AmazonChimeErrorType
import FlutterError
import com.example.amazon_chime_plugin.PlatoformRequester.Models.ResponseMessageKind

sealed class AmazonChimeError: Throwable() {
    abstract val errorType: AmazonChimeErrorType
    object InvalidResponse: AmazonChimeError() {
        override val errorType: AmazonChimeErrorType =
            AmazonChimeErrorType.INVALIDRESPONSE
    }
    data class ResponseMessage(val type: ResponseMessageKind): AmazonChimeError() {
        override val errorType: AmazonChimeErrorType =
            AmazonChimeErrorType.RESPONSEMESSAGE
    }
    data class CustomError(val text: String): AmazonChimeError() {
        override val errorType: AmazonChimeErrorType =
            AmazonChimeErrorType.INVALIDRESPONSE
    }

    val asFlutterError: FlutterError
        get() {
            val code = errorType.raw.toString()
            return when (this) {
                is InvalidResponse -> FlutterError(code, null, null)
                is ResponseMessage -> FlutterError(code, type.rawValue, null)
                is CustomError -> FlutterError(code, text, null)
            }
        }
}
