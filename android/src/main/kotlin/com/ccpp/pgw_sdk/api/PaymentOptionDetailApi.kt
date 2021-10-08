/*
 * Created by Nonthawatt Phongwittayapanu on 10/6/21, 3:39 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

package com.ccpp.pgw_sdk.api

import android.util.Log
import androidx.annotation.NonNull
import com.ccpp.pgw.sdk.android.callback.APIResponseCallback
import com.ccpp.pgw.sdk.android.core.PGWSDK
import com.ccpp.pgw.sdk.android.enums.APIResponseCode
import com.ccpp.pgw.sdk.android.enums.PaymentChannelCode
import com.ccpp.pgw.sdk.android.model.api.PaymentOptionDetailRequest
import com.ccpp.pgw.sdk.android.model.api.PaymentOptionDetailResponse
import com.ccpp.pgw.sdk.android.model.api.PaymentOptionRequest
import com.ccpp.pgw.sdk.android.model.api.PaymentOptionResponse
import com.ccpp.pgw_sdk.helper.JsonHelper
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class PaymentOptionDetailApi(
    @NonNull val call: MethodCall, @NonNull val result: MethodChannel.Result,
) {

    /**
     * Payment Option Detail
     */
    fun request() {
        val json = call.argument<String>("paymentOptionDetailRequest") ?: ""
        val request = paymentOptionDetailRequestFromJson(json) ?: kotlin.run {
            result.error("998", "Parse json error", null)
            return
        }

        PGWSDK.getInstance().paymentOptionDetail(request, object : APIResponseCallback<PaymentOptionDetailResponse> {
            override fun onResponse(response: PaymentOptionDetailResponse) {
                if (response.responseCode == APIResponseCode.APISuccess) {
                    //Read payment option detail response.
                    result.success(paymentOptionDetailResponseToJson(response))
                } else {
                    //Get error response and display error.
                    Log.d("DEMO", "onResponse: Error ${response.responseCode}")
                    Log.d("DEMO", "onResponse: Error ${response.responseDescription}")

                    result.error(response.responseCode, response.responseDescription, null)
                }
            }

            override fun onFailure(error: Throwable) {
                //Get error response and display error.
                Log.d("DEMO", "onFailure: $error")
                result.error("999", error.localizedMessage, error)
            }
        })
    }

    private fun paymentOptionDetailRequestFromJson(json: String): PaymentOptionDetailRequest? {
        val jsonObject = JSONObject(json)

        Log.d("DEMO", "parseJson: Request =>> ${jsonObject.toString(2)}")

        val paymentToken = JsonHelper.jsonString(jsonObject, "paymentToken")
        val clientId = JsonHelper.jsonString(jsonObject, "clientID")
        val locale = JsonHelper.jsonString(jsonObject, "locale")
        val category = JsonHelper.jsonString(jsonObject, "categoryCode")
        val group = JsonHelper.jsonString(jsonObject, "groupCode")

        return PaymentOptionDetailRequest(paymentToken).apply {
            if (!clientId.isNullOrBlank()) {
                setClientId(clientId)
            }
            if (!locale.isNullOrBlank()) {
                setLocale(locale)
            }
            categoryCode = category // PaymentChannelCode.Category.GlobalCardPayment;
            groupCode = group //PaymentChannelCode.Group.GlobalInstallmentPaymentPlan;
        }
    }

    private fun paymentOptionDetailResponseToJson(response: PaymentOptionDetailResponse): String {
        val channels: ArrayList<Map<String, Any?>> = arrayListOf()
        response.channels.forEach {
            channels.add(
                mapOf(
                    "sequenceNo" to it.sequenceNo,
                    "name" to it.name,
                    "iconUrl" to it.iconUrl,
                    "logoUrl" to it.logoUrl,
                )
            )
        }

        val cardTypes: ArrayList<Map<String, Any?>> = arrayListOf()
        response.validation.cardTypes.forEach {
            cardTypes.add(
                mapOf(
                    "sequenceNo" to it.sequenceNo,
                    "name" to it.name,
                    "iconUrl" to it.iconUrl,
                    "regex" to it.regex,
                    "prefixes" to it.prefixes,
                )
            )
        }

        val responseMap = mapOf(
            "name" to response.name,
            "categoryCode" to response.categoryCode,
            "groupCode" to response.groupCode,
            "iconUrl" to response.iconUrl,
            "validation" to mapOf(
                "cardNo" to mapOf(
                    "prefixes" to response.validation.cardNo.prefixes,
                    "regex" to response.validation.cardNo.regex,
                ),
                "cardTypes" to cardTypes,
            ),
            "channels" to channels,
            "totalChannel" to response.totalChannel,
            "configurationInfo" to mapOf(
                "payment" to mapOf(
                    "exchangeRate" to mapOf(
                        "mcp" to mapOf(
                            "terms" to response.configurationInfo.payment.exchangeRate.multipleCurrencyPricing.terms,
                        ),
                        "dcc" to mapOf(
                            "terms" to response.configurationInfo.payment.exchangeRate.dynamicCurrencyConversion.terms,
                        ),
                        "apmMcc" to mapOf(
                            "terms" to response.configurationInfo.payment.exchangeRate.alternativePaymentMethodMultipleCurrencyConversion.terms,
                        ),
                    ),
                ),
                "responseCode" to response.responseCode,
                "responseDescription" to response.responseDescription,
            ),
        )

        return JSONObject(responseMap).toString()
    }
}