package com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester
import FlutterError

sealed class AmazonChimeError : Throwable() {
    object InvalidResponse : AmazonChimeError()
    data class CustomError(val text: String) : AmazonChimeError()

    val asFlutterError: FlutterError
        get() = when (this) {
            is InvalidResponse -> FlutterError("0", "invalidResponse", null)
            is CustomError -> FlutterError("0", text, null)
        }
}
