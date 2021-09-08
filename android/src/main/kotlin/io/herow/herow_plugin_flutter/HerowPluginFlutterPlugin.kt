package io.herow.herow_plugin_flutter

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

/** HerowPluginFlutterPlugin */
class HerowPluginFlutterPlugin : FlutterPlugin {
    private val CHANNEL = "herow.io/sdk"

    private var channel: MethodChannel? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        setupChannel(binding.binaryMessenger, binding.applicationContext)
    }

    override fun onDetachedFromEngine(p0: FlutterPlugin.FlutterPluginBinding) {
        teardownChannel()
    }

    fun setupChannel(messenger: BinaryMessenger, context: Context) {
        channel = MethodChannel(messenger, CHANNEL)
        val handler = MethodCallHandlerImpl(context)
        channel?.setMethodCallHandler(handler)
    }

    private fun teardownChannel() {
        channel?.setMethodCallHandler(null)
        channel = null
    }
}
