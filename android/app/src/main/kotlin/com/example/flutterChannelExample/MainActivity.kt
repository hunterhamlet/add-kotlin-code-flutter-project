package com.example.flutterChannelExample

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "channel_example"
    private val METHOD_KOTLIN_FUNC = "changeColor"
    private val KEY_CHANGE_COLOR = "color"

    @ExperimentalStdlibApi
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
                call, result ->
            when {
                call.method.equals(METHOD_KOTLIN_FUNC) -> {
                    changeColor(call, result)
                }
            }
        }
    }

    private fun changeColor(call: MethodCall, result: MethodChannel.Result) {
        var color = call.argument<String>(KEY_CHANGE_COLOR);
        result.success(color);
    }

}
