package com.ccpp.pgw_sdk.helper

import org.json.JSONObject

object JsonHelper {
    fun jsonString(jsonObject: JSONObject, name: String): String? {
        return if (jsonObject.has(name)) jsonObject[name] as? String else null
    }
}