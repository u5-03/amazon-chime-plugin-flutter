package com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester

import FlutterError
import MethodType
import RequesterToNative
import StringData
import android.os.Build
import com.dena.amazon.chime.flutter.amazon_chime_plugin.PermissionManager
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class RequesterToNativeImpl(permissionManager: PermissionManager): RequesterToNative {
    private var applicationScope: CoroutineScope = GlobalScope
    private val permissionManager = permissionManager

    override fun sendMessage(type: MethodType, callback: (Result<StringData>) -> Unit) {
        applicationScope.launch {
            // MEMO: catchでFlutterError以外の型のエラーを定義すると、このメソッド利用時にクラッシュする
            // finally内部はFlutterError含めたどのExceptionのthrowを記述してもクラッシュしたので、
            // 定義しない(`catch (error: FlutterError)`のみを利用する)
            try {
                val response = sendMessage(type)
                callback(Result.success(response))
            } catch (error: FlutterError) {
                callback(Result.failure(error))
            }
        }
    }

    // MEMO: 実装時の調査で、エラーをthrowする場合、上記のsendMessageはFlutterError以外のExceptionなどをthrowすると、アプリが
    // クラッシュしたので、エラーをthrowする場合、AmazonChimeErrorで定義後に必ずasFlutterErrorで変換してthrowする
    // Errorの場合は、`throw AmazonChimeError.InvalidResponse.asFlutterError`のように記述する
    @Throws suspend fun sendMessage(type: MethodType): StringData {
        // TODO: Pegionで生成されるMethodTypeの型が正しいSnakeCaseにならないので、設定方法の見直しを行う
        return when (type) {
            MethodType.GETPLATFORMVERSION -> StringData(true, "Android ${Build.VERSION.RELEASE}")
            MethodType.REQUESTMICROPHONEPERMISSIONS -> permissionManager.requestMicrophonePermission().asStringData
            MethodType.REQUESTCAMERAPERMISSIONS -> permissionManager.requestVideoPermission().asStringData
        }
    }
}
