package io.herow.herow_plugin_flutter

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.herow.sdk.connection.HerowPlatform
import io.herow.sdk.detection.HerowInitializer

internal class MethodCallHandlerImpl(var context: Context) : MethodChannel.MethodCallHandler {

    private lateinit var herowInitializer: HerowInitializer

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        herowInitializer = HerowInitializer.getInstance(context)
        when (call.method) {
            "configApp" -> {
                val herowPlatform = call.argument<String>("herowPlatform").toString()
                val apiKey = call.argument<String>("apiKey").toString()
                val secret = call.argument<String>("secret").toString()
                herowInitializer.configPlatform(HerowPlatform.valueOf(herowPlatform)).configApp(apiKey, secret).synchronize()
            }
            "setCustomId" -> {
                val customId = call.argument<String>("customId").toString()
                herowInitializer.setCustomId(customId)
            }
            "getCustomId" -> {
                val customId = herowInitializer.getCustomId()
                result.success(customId)
            }
            "removeCustomId" -> {
                herowInitializer.removeCustomId()
            }
            "getOptin" -> {
                val optinValue = herowInitializer.getOptinValue()
                result.success(optinValue)
            }
            "acceptOptin" -> {
                herowInitializer.acceptOptin()
            }
            "refuseOptin" -> {
                herowInitializer.refuseOptin()
            }
            "launchClickAndCollect" -> {
                herowInitializer.launchClickAndCollect()
            }
            "stopClickAndCollect" -> {
                herowInitializer.stopClickAndCollect()
            }
            "isOnClickAndCollect" -> {
                val onClickAndCollect = herowInitializer.isOnClickAndCollect()
                result.success(onClickAndCollect)
            }
            "reset" -> {
                val sdkId = call.argument<String>("sdkId").toString()
                val sdkKey = call.argument<String>("sdkKey").toString()
                val customId = call.argument<String>("customId").toString()
                herowInitializer.reset(sdkId, sdkKey, customId)
            }
            else -> result.notImplemented()
        }
    }
}