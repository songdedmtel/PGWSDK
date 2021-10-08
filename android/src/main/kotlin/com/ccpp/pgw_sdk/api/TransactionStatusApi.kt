/*
 * Created by Nonthawatt Phongwittayapanu on 10/7/21, 3:39 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

package com.ccpp.pgw_sdk.api

import android.util.Log
import androidx.annotation.NonNull
import com.ccpp.pgw.sdk.android.callback.APIResponseCallback
import com.ccpp.pgw.sdk.android.core.PGWSDK
import com.ccpp.pgw.sdk.android.enums.APIResponseCode
import com.ccpp.pgw.sdk.android.model.api.TransactionStatusRequest
import com.ccpp.pgw.sdk.android.model.api.TransactionStatusResponse
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject


class TransactionStatusApi(
    @NonNull val call: MethodCall, @NonNull val result: MethodChannel.Result
) {

    fun request() {
        val json = call.argument<String>("transactionStatusRequest") ?: ""
        val jsonObject = JSONObject(json)
        val paymentToken = jsonObject["paymentToken"].toString()

        Log.d("DEMO", "parseJson: Request =>> ${jsonObject.toString(2)}")

        val transactionStatusRequest = TransactionStatusRequest(paymentToken)
        transactionStatusRequest.setAdditionalInfo(true)

        PGWSDK.getInstance()
            .transactionStatus(transactionStatusRequest, object : APIResponseCallback<TransactionStatusResponse> {
                override fun onResponse(response: TransactionStatusResponse) {
                    if (response.responseCode == APIResponseCode.TransactionNotFound ||
                        response.responseCode == APIResponseCode.TransactionCompleted) {
                        //Read transaction status inquiry response.
                        result.success(responseToJson(response))
                    } else {
                        //Get error response and display error.
                        Log.d("DEMO", "onResponse: Error ${response.responseCode}")
                        Log.d("DEMO", "onResponse: Error ${response.responseDescription}")
                        result.error(response.responseCode, response.responseDescription, null)
                    }

                }

                override fun onFailure(error: Throwable) {
                    //Get error response and display error.
                }
            })
    }

    private fun responseToJson(response: TransactionStatusResponse): String {
        val responseMap = mapOf<String, Any>(
            "channelCode" to response.channelCode,
            "invoiceNo" to response.invoiceNo,
            "additionalInfo" to mapOf(
                "transactionDetails" to mapOf(
                    "dateTime" to response.additionalInfo.transactionInfo.dateTime,
                    "agentCode" to response.additionalInfo.transactionInfo.agentCode,
                    "channelCode" to response.additionalInfo.transactionInfo.channelCode,
                    "data" to response.additionalInfo.transactionInfo.data,
                    "interestType" to response.additionalInfo.transactionInfo.interestType,
                    "interestRate" to response.additionalInfo.transactionInfo.interestRate,
                    "monthlyAmount" to response.additionalInfo.transactionInfo.monthlyAmount,
                    "installmentPeriod" to response.additionalInfo.transactionInfo.installmentPeriod,
                    "amount" to response.additionalInfo.transactionInfo.amount,
                    "currencyCode" to response.additionalInfo.transactionInfo.currencyCode,
                    "invoiceNo" to response.additionalInfo.transactionInfo.invoiceNo,
                    "productDescription" to response.additionalInfo.transactionInfo.productDescription,
                ),
                "merchantDetails" to mapOf(
                    "id" to response.additionalInfo.merchantInfo.id,
                    "name" to response.additionalInfo.merchantInfo.name,
                    "address" to response.additionalInfo.merchantInfo.address,
                    "email" to response.additionalInfo.merchantInfo.email,
                    "logoUrl" to response.additionalInfo.merchantInfo.logoUrl,
                    "bannerUrl" to response.additionalInfo.merchantInfo.bannerUrl,
                ),
                "paymentResultDetails" to mapOf(
                    "code" to response.additionalInfo.resultInfo.responseCode,
                    "description" to response.additionalInfo.resultInfo.responseDescription,
                    "autoRedirectTimer" to response.additionalInfo.resultInfo.autoRedirectTimer,
                    "frontendReturnUrl" to response.additionalInfo.resultInfo.frontendReturnUrl,
                    "frontendReturnData" to response.additionalInfo.resultInfo.frontendReturnData,
                ),
            ),
            "responseCode" to response.responseCode,
            "responseDescription" to response.responseDescription,
        )

        return JSONObject(responseMap).toString()
    }

}