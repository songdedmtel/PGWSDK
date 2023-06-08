/*
 * Created by Nonthawatt Phongwittayapanu on 2/8/22, 1:49 PM
 * Copyright © 2022 2C2P. All rights reserved.
 */

package com.ccpp.pgw_sdk.api

import android.util.Log
import androidx.annotation.NonNull
import com.ccpp.pgw.sdk.android.builder.CardTokenPaymentBuilder
import com.ccpp.pgw.sdk.android.builder.TransactionResultRequestBuilder
import com.ccpp.pgw.sdk.android.callback.APIResponseCallback
import com.ccpp.pgw.sdk.android.core.PGWSDK
import com.ccpp.pgw.sdk.android.enums.APIResponseCode
import com.ccpp.pgw.sdk.android.model.PaymentCode
import com.ccpp.pgw.sdk.android.model.api.TransactionResultRequest
import com.ccpp.pgw.sdk.android.model.api.TransactionResultResponse
import com.ccpp.pgw_sdk.helper.JsonHelper
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class PaymentWithCardTokenApi(
    @NonNull val call: MethodCall, @NonNull val result: MethodChannel.Result
) {

    /**
     * Proceed function
     */
    fun request() {
        val json = call.argument<String>("request") ?: ""
        val request = transactionRequestFromJson(json) ?: kotlin.run {
            result.error("998", "Parse json error", null)
            return
        }

        PGWSDK.getInstance()
            .proceedTransaction(request, object : APIResponseCallback<TransactionResultResponse> {
                override fun onResponse(response: TransactionResultResponse) {
                    when (response.responseCode) {
                        APIResponseCode.TransactionQRPayment,
                        APIResponseCode.TransactionPaymentSlip,
                        APIResponseCode.TransactionAuthenticateRedirect,
                        APIResponseCode.TransactionAuthenticateFullRedirect -> {
                            val redirectUrl = response.data //Open WebView
                            Log.d("DEMO", "onResponse: =>> $response")
                            Log.d("DEMO", "onResponse: Url =>> $redirectUrl")
                            result.success(transactionResponseToJson(response))
                        }
                        APIResponseCode.TransactionCompleted -> {
                            Log.d("DEMO", "onResponse: Transaction Complete")
                            result.success(transactionResponseToJson(response))
                        }
                        else -> {
                            //Get error response.
                            Log.d("DEMO", "onResponse: Error ${response.responseCode}")
                            Log.d("DEMO", "onResponse: Error ${response.responseDescription}")

                            result.error(response.responseCode, response.responseDescription, null)
                        }
                    }
                }

                override fun onFailure(error: Throwable) {

                    //Get error response and display error.
                    result.error("999", error.localizedMessage, error)
                }
            })
    }

    private fun transactionRequestFromJson(json: String): TransactionResultRequest? {
        val jsonObject = JSONObject(json)

        Log.d("DEMO", "parseJson: Request =>> ${jsonObject.toString(2)}")

        val paymentToken = jsonObject["paymentToken"].toString()
        val clientId = JsonHelper.jsonString(jsonObject, "clientID")
        val locale = JsonHelper.jsonString(jsonObject, "locale")
        return try {
            val jsonPayment = jsonObject["payment"] as JSONObject// JSON payment
            val jsonPaymentCode = jsonPayment["code"] as JSONObject
            val jsonPaymentData = jsonPayment["data"] as JSONObject

            val cardToken = JsonHelper.jsonString(jsonPaymentData, "token")
            val securityCode = JsonHelper.jsonString(jsonPaymentData, "securityCode")

            val code = PaymentCode(
                JsonHelper.jsonString(jsonPaymentCode, "channelCode"),
                JsonHelper.jsonString(jsonPaymentCode, "agentCode"),
                JsonHelper.jsonString(jsonPaymentCode, "agentChannelCode"),
            )

            val paymentRequest = CardTokenPaymentBuilder(code, cardToken).setSecurityCode(securityCode).build()

            return TransactionResultRequestBuilder(paymentToken).apply {
                if (!clientId.isNullOrBlank()) {
                    setClientId(clientId)
                }
                if (!locale.isNullOrBlank()) {
                    setLocale(locale)
                }
                with(paymentRequest)
            }.build()
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }

    private fun transactionResponseToJson(response: TransactionResultResponse): String {
        val responseMap = mapOf<String, Any>(
            "channelCode" to response.channelCode,
            "invoiceNo" to response.invoiceNo,
            "type" to response.type,
            "data" to response.data,
            "fallbackData" to response.fallbackData,
            "expiryTimer" to response.expiryTimer,
            "expiryDescription" to response.expiryDescription,
            "responseCode" to response.responseCode,
            "responseDescription" to response.responseDescription,
        )

        return JSONObject(responseMap).toString()
    }
}