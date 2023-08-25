package com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester.Errors

import AmazonChimeErrorType
import FlutterError
import com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester.Models.ResponseMessage

sealed class AmazonChimeError(private val errorType: AmazonChimeErrorType) {
    object InvalidResponse : AmazonChimeError(AmazonChimeErrorType.INVALIDRESPONSE)
    data class CustomError(val text: String) : AmazonChimeError(AmazonChimeErrorType.CUSTOMERROR)

    val asFlutterError: FlutterError
        get() {
            val code = errorType.raw.toString()
            return when (this) {
                is InvalidResponse -> FlutterError(code, null, null)
                is CustomError -> FlutterError(code, text, null)
            }
        }
}