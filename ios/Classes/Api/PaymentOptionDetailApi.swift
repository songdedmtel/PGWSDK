//
//  PaymentOptionDetailApi.swift
//  pgw_sdk
//
//  Created by Nonthawatt Phongwittayapanu on 7/10/2564 BE.
//  Copyright © 2021 2C2P. All rights reserved.
//

import UIKit
import PGW

class PaymentOptionDetailApi {
    private var call: FlutterMethodCall
    private var result: FlutterResult
    
    init(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.call = call
        self.result = result
    }
    
    func request() {
        guard let dicts = call.arguments as? [String: Any],
              let jsonString = dicts["paymentOptionDetailRequest"] as? String
        else {
            result(FlutterError.init(code: "998", message: "Arguments exception", details: nil))
            return
        }
        guard let request = mappingRequest(json: jsonString) else {
            result(FlutterError.init(code: "900", message: "Json exception", details: nil))
            return
        }
        
        PGWSDK.shared.paymentOptionDetail(paymentOptionDetailRequest: request, { (response: PaymentOptionDetailResponse) in
            if response.responseCode == APIResponseCode.APISuccess {
                if let jsonString = self.mappingResposne(response) {
                    self.result(jsonString)
                } else {
                    self.result(FlutterError.init(code: response.responseCode, message: "Parse json error, \(response.responseDescription ?? "")", details: nil))
                }
            } else {
                //Get error response and display error.
                self.result(FlutterError.init(code: response.responseCode, message: response.responseDescription, details: nil))
            }
        }) { (error: NSError) in
            //Get error response and display error.
            self.result(FlutterError.init(code: "\(error.code)", message: error.localizedDescription, details: nil))
        }
    }
    
    // MARK: - Request
    private func mappingRequest(json: String) -> PaymentOptionDetailRequest? {
        do {
            let jsonData = json.data(using: .utf8)!
            let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any?]
            let paymentToken = jsonDict?["paymentToken"] as? String ?? ""
            
            let request = PaymentOptionDetailRequest(paymentToken: paymentToken)
            
            if let clientId = jsonDict?["clientID"] as? String {
                request.clientId = clientId
            }
            if let locale = jsonDict?["locale"] as? String {
                request.locale = locale
            }
            if let clientId = jsonDict?["categoryCode"] as? String {
                request.categoryCode = clientId
            }
            if let locale = jsonDict?["groupCode"] as? String {
                request.groupCode = locale
            }
            return request
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    // MARK: - Response
    private func mappingResposne(_ response: PaymentOptionDetailResponse) -> String? {
        var channels: [[String: Any?]] = []
        response.channels.forEach { (it: PaymentChannel) in
            channels.append(
                [
                    "sequenceNo": it.sequenceNo,
                    "name": it.name,
                    "iconUrl": it.iconUrl,
                    "logoUrl": it.logoUrl,
                ]
            )
        }
        
        var cardTypes: [[String: Any?]] = []
        response.validation.cardTypes.forEach { (it: CardTypeValidation) in
            cardTypes.append(
                [
                    "sequenceNo": it.sequenceNo,
                    "name": it.name,
                    "iconUrl": it.iconUrl,
                    "regex": it.regex,
                    "prefixes": it.prefixes,
                ]
            )
        }
        
        let responseDict: [String : Any?] = [
            "name": response.name,
            "categoryCode": response.categoryCode,
            "groupCode": response.groupCode,
            "iconUrl": response.iconUrl,
            "validation": [
                "cardNo": [
                    "prefixes": response.validation.cardNo.prefixes ?? [],
                    "regex": response.validation.cardNo.regex ?? "",
                ],
                "cardTypes": cardTypes,
            ],
            "channels": channels,
            "totalChannel": response.totalChannel,
            "configurationInfo": [
                "payment": [
                    "exchangeRate": [
                        "mcp": [
                            "terms": response.configurationInfo.payment.exchangeRate.multipleCurrencyPricing.terms,
                        ],
                        "dcc": [
                            "terms": response.configurationInfo.payment.exchangeRate.dynamicCurrencyConversion.terms,
                        ],
                        "apmMcc": [
                            "terms": response.configurationInfo.payment.exchangeRate.alternativePaymentMethodMultipleCurrencyConversion.terms,
                        ],
                    ],
                ],
                "configurationInfo":[
                    "payment":[
                        "exchangeRate":[
                            "mcp":[
                                "terms": response.configurationInfo.payment.exchangeRate.multipleCurrencyPricing.terms,
                            ],
                            "dcc":[
                                "terms": response.configurationInfo.payment.exchangeRate.dynamicCurrencyConversion.terms,
                            ],
                            "apmMcc":[
                                "terms": response.configurationInfo.payment.exchangeRate.alternativePaymentMethodMultipleCurrencyConversion.terms,
                            ],
                        ],
                    ],
                ],
            ],
            "responseCode": response.responseCode as String,
            "responseDescription": response.responseDescription as String,
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: responseDict)
            let string = String(data: data, encoding: .utf8)
            print(string ?? "")
            return string
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
}
