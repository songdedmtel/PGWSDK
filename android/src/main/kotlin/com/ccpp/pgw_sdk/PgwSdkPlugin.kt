package com.ccpp.pgw_sdk

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import com.ccpp.pgw.sdk.android.builder.PGWSDKParamsBuilder
import com.ccpp.pgw.sdk.android.core.PGWSDK
import com.ccpp.pgw.sdk.android.enums.APIEnvironment
import com.ccpp.pgw_sdk.api.PaymentOptionApi
import com.ccpp.pgw_sdk.api.PaymentOptionDetailApi
import com.ccpp.pgw_sdk.api.TransactionApi
import com.ccpp.pgw_sdk.api.TransactionStatusApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


/** PgwSdkPlugin */
class PgwSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "pgw_sdk")
        channel.setMethodCallHandler(this)

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "sdkVersion" -> {
                result.success("4.4.0")
            }
            "initialize" -> {
                val env = call.argument<String>("apiEnvironment") ?: ""
                val apiEnvironment =
                    APIEnvironment.values().firstOrNull { it.name.equals(env, true) } ?: APIEnvironment.Sandbox
                val pgwSdkParams = PGWSDKParamsBuilder(activity, apiEnvironment).build()
                PGWSDK.initialize(pgwSdkParams)
            }
            "proceedTransaction" -> {
                TransactionApi(call, result).request()
            }
            "paymentOption" -> {
                PaymentOptionApi(call, result).request()
            }
            "paymentOptionDetail" -> {
                PaymentOptionDetailApi(call, result).request()
            }
            "transactionStatus" -> {
                TransactionStatusApi(call, result).request()
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        return false
    }

}
