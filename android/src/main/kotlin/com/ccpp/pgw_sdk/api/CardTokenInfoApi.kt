/*
 * Created by Nonthawatt Phongwittayapanu on 10/20/21, 11:31 AM
 * Copyright © 2021 2C2P. All rights reserved.
 */

package com.ccpp.pgw_sdk.api

import android.util.Log
import androidx.annotation.NonNull
import com.ccpp.pgw.sdk.android.callback.APIResponseCallback
import com.ccpp.pgw.sdk.android.core.PGWSDK
import com.ccpp.pgw.sdk.android.enums.APIResponseCode
import com.ccpp.pgw.sdk.android.model.api.CardTokenInfoRequest
import com.ccpp.pgw.sdk.android.model.api.CardTokenInfoResponse
import com.ccpp.pgw_sdk.helper.JsonHelper.jsonString
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class CardTokenInfoApi(
    @NonNull val call: MethodCall, @NonNull val result: MethodChannel.Result
) {

    /**
     * Card token info function
     */
    fun request() {
        val json = call.argument<String>("cardTokenInfoRequest") ?: ""
        val request = cardTokenInfoRequestFromJson(json) ?: kotlin.run {
            result.error("998", "Parse json error", null)
            return
        }

        PGWSDK.getInstance().cardTokenInfo(request, object : APIResponseCallback<CardTokenInfoResponse> {
            override fun onResponse(response: CardTokenInfoResponse) {
                if (response.responseCode == APIResponseCode.APISuccess) {
                    //Read payment option response.
                    result.success(cardTokenInfoResponseToJson(response))
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

    private fun cardTokenInfoRequestFromJson(json: String): CardTokenInfoRequest? {
        val jsonObject = JSONObject(json)

        Log.d("DEMO", "parseJson: Request =>> ${jsonObject.toString(2)}")

        val paymentToken = jsonString(jsonObject, "paymentToken")
        val clientId = jsonString(jsonObject, "clientID")
        val locale = jsonString(jsonObject, "locale")

        return CardTokenInfoRequest(paymentToken).apply {
            if (!clientId.isNullOrBlank()) {
                setClientId(clientId)
            }
            if (!locale.isNullOrBlank()) {
                setLocale(locale)
            }
        }
    }

    private fun cardTokenInfoResponseToJson(response: CardTokenInfoResponse): String {
        val cardTokens: ArrayList<Map<String, Any?>> = arrayListOf()
        response.cardTokens.forEach {
            cardTokens.add(
                mapOf(
                    "token" to it.token,
                    "cardNo" to it.cardNo,
                    "expiryDate" to it.expiryDate,
                    "name" to it.name,
                    "email" to it.email,
                    "status" to it.status,
                    "iconUrl" to it.iconUrl,
                    "logoUrl" to it.logoUrl,
                )
            )
        }

        val responseMap = mapOf(
            "paymentToken" to response.paymentToken,
            "cardTokens" to cardTokens,
            "responseCode" to response.responseCode,
            "responseDescription" to response.responseDescription,
        )

        return JSONObject(responseMap).toString()
    }

}