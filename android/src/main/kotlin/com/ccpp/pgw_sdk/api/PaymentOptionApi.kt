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
import com.ccpp.pgw.sdk.android.model.api.PaymentOptionRequest
import com.ccpp.pgw.sdk.android.model.api.PaymentOptionResponse
import com.ccpp.pgw_sdk.helper.JsonHelper.jsonString
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class PaymentOptionApi(
    @NonNull val call: MethodCall, @NonNull val result: MethodChannel.Result,
) {

    /**
     * Payment Option function
     */
    fun request() {
        val json = call.argument<String>("paymentOptionRequest") ?: ""
        val request = paymentOptionRequestFromJson(json) ?: kotlin.run {
            result.error("998", "Parse json error", null)
            return
        }

        PGWSDK.getInstance().paymentOption(request, object : APIResponseCallback<PaymentOptionResponse> {
            override fun onResponse(response: PaymentOptionResponse) {
                if (response.responseCode == APIResponseCode.APISuccess) {
                    //Read payment option response.
                    result.success(paymentOptionResponseToJson(response))
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

    private fun paymentOptionRequestFromJson(json: String): PaymentOptionRequest? {
        val jsonObject = JSONObject(json)

        Log.d("DEMO", "parseJson: Request =>> ${jsonObject.toString(2)}")

        val paymentToken = jsonString(jsonObject, "paymentToken")
        val clientId = jsonString(jsonObject, "clientID")
        val locale = jsonString(jsonObject, "locale")

        return PaymentOptionRequest(paymentToken).apply {
            if (!clientId.isNullOrBlank()) {
                setClientId(clientId)
            }
            if (!locale.isNullOrBlank()) {
                setLocale(locale)
            }
        }
    }

    private fun paymentOptionResponseToJson(response: PaymentOptionResponse): String {
        val channels: ArrayList<Map<String, Any?>> = arrayListOf()
        response.channels.forEach {
            val groups: ArrayList<Map<String, Any?>> = arrayListOf()
            it.groups.forEach { group ->
                groups.add(
                    mapOf(
                        "sequenceNo" to group.sequenceNo,
                        "name" to group.name,
                        "code" to group.code,
                        "iconUrl" to group.iconUrl,
                        "logoUrl" to group.logoUrl,
                    )
                )
            }
            channels.add(
                mapOf(
                    "sequenceNo" to it.sequenceNo,
                    "name" to it.name,
                    "code" to it.code,
                    "iconUrl" to it.iconUrl,
                    "logoUrl" to it.logoUrl,
                    "groups" to groups,
                )
            )
        }

        val paymentItems: ArrayList<Map<String, Any?>> = arrayListOf()
        response.transactionInfo.paymentItemInfos.forEach {
            paymentItems.add(
                mapOf(
                    "code" to it.code,
                    "name" to it.name,
                    "quantity" to it.quantity,
                    "price" to it.price,
                )
            )
        }

        val responseMap = mapOf(
            "paymentToken" to response.paymentToken,
            "merchantInfo" to mapOf(
                "id" to response.merchantInfo.id,
                "name" to response.merchantInfo.name,
                "address" to response.merchantInfo.address,
                "email" to response.merchantInfo.email,
                "logoUrl" to response.merchantInfo.logoUrl,
                "bannerUrl" to response.merchantInfo.bannerUrl,
            ),
            "userInfo" to mapOf(
                "userAddress" to mapOf(
                    "userBillingAddress" to mapOf(
                        "address1" to response.userInfo.userAddress.userBillingAddress.address1,
                        "address2" to response.userInfo.userAddress.userBillingAddress.address2,
                        "address3" to response.userInfo.userAddress.userBillingAddress.address3,
                        "city" to response.userInfo.userAddress.userBillingAddress.city,
                        "state" to response.userInfo.userAddress.userBillingAddress.state,
                        "postalCode" to response.userInfo.userAddress.userBillingAddress.postalCode,
                        "countryCode" to response.userInfo.userAddress.userBillingAddress.countryCode,
                    ),
                ),
            ),
            "channels" to channels,
            "transactionInfo" to mapOf(
                "recurring" to mapOf(
                    "amount" to response.transactionInfo.recurring.amount,
                    "interval" to response.transactionInfo.recurring.interval,
                    "count" to response.transactionInfo.recurring.count,
                    "chargeNextDate" to response.transactionInfo.recurring.chargeNextDate,
                    "chargeOnDate" to response.transactionInfo.recurring.chargeOnDate,
                ),
                "paymentItems" to paymentItems,
                "amount" to response.transactionInfo.amount,
                "currencyCode" to response.transactionInfo.currencyCode,
                "invoiceNo" to response.transactionInfo.invoiceNo,
                "productDescription" to response.transactionInfo.productDescription,
            ),
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
                    )
//                    "immediatePayment" to response.configurationInfo.payment.immediatePayment,
//                    "tokenize" to response.configurationInfo.payment.tokenize,
//                    "tokenizeOnly" to response.configurationInfo.payment.tokenizeOnly,
//                    "cardTokenOnly" to response.configurationInfo.payment.cardTokenOnly,
                ),
//                "notification" to mapOf(
//                    "" to response.configurationInfo.notification,
//                ),
            ),
            "responseCode" to response.responseCode,
            "responseDescription" to response.responseDescription,
        )

        return JSONObject(responseMap).toString()
    }
}