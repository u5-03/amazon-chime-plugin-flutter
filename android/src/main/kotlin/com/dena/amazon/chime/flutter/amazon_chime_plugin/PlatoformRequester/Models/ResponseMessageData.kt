package com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester.Models

import StringData

data class ResponseMessageData(val result: Boolean, val type: ResponseMessage) {
    val asStringData: StringData
        get() = StringData(result, type.rawValue)
}
