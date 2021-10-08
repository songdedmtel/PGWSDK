//
//  PaymentOptionApi.swift
//  pgw_sdk
//
//  Created by Nonthawatt Phongwittayapanu on 7/10/2564 BE.
//  Copyright © 2021 2C2P. All rights reserved.
//

import UIKit
import PGW

class PaymentOptionApi {
    private var call: FlutterMethodCall
    private var result: FlutterResult
    
    init(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.call = call
        self.result = result
    }
    
    func request() {
        guard let dicts = call.arguments as? [String: Any],
              let jsonString = dicts["paymentOptionRequest"] as? String
        else {
            result(FlutterError.init(code: "998", message: "Arguments exception", details: nil))
            return
        }
        guard
            let request = mappingRequest(json: jsonString) else {
            result(FlutterError.init(code: "900", message: "Json exception", details: nil))
            return
        }
        
        PGWSDK.shared.paymentOption(paymentOptionRequest: request, { (response: PaymentOptionResponse) in
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
    private func mappingRequest(json: String) -> PaymentOptionRequest? {
        do {
            let jsonData = json.data(using: .utf8)!
            let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any?]
            let paymentToken = jsonDict?["paymentToken"] as? String ?? ""
            
            let request = PaymentOptionRequest(paymentToken: paymentToken)
            
            if let clientId = jsonDict?["clientID"] as? String {
                request.clientId = clientId
            }
            if let locale = jsonDict?["locale"] as? String {
                request.locale = locale
            }
            
            return request
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    // MARK: - Response
    private func mappingResposne(_ response: PaymentOptionResponse) -> String? {
        var channels: [[String: Any?]] = []
        response.channels.forEach { (it: PaymentChannelCategory) in
            var groups: [[String: Any?]] = []
            it.groups.forEach { (group: PaymentChannelGroup) in
                groups.append(
                    [
                        "sequenceNo": group.sequenceNo,
                        "name": group.name,
                        "code": group.code,
                        "iconUrl": group.iconUrl,
                        "logoUrl": group.logoUrl,
                    ]
                )
            }
            channels.append(
                [
                    "sequenceNo": it.sequenceNo,
                    "name": it.name,
                    "code": it.code,
                    "iconUrl": it.iconUrl,
                    "logoUrl": it.logoUrl,
                    "groups": groups,
                ]
            )
        }
        
        var paymentItems: [[String: Any?]] = []
        response.transactionInfo.paymentItemInfos.forEach { (it: PaymentItemInfo) in
            paymentItems.append(
                [
                    "code": it.code,
                    "name": it.name,
                    "quantity": it.quantity,
                    "price": it.price,
                ]
            )
        }
        
        let responseDict: [String : Any?] = [
            "paymentToken": response.paymentToken,
            "merchantInfo": [
                "id": response.merchantInfo.id,
                "name": response.merchantInfo.name,
                "address": response.merchantInfo.address,
                "email": response.merchantInfo.email,
                "logoUrl": response.merchantInfo.logoUrl,
                "bannerUrl": response.merchantInfo.bannerUrl,
            ],
            
            /// Swift can't get `userBillingAddress` from PGW
            //            "userInfo": [
            //                "userAddress": [
            //                    "userBillingAddress": [
            //                        "address1": response.userInfo.userAddress.userBillingAddress.address1,
            //                        "address2": response.userInfo.userAddress.userBillingAddress.address2,
            //                        "address3": response.userInfo.userAddress.userBillingAddress.address3,
            //                        "city": response.userInfo.userAddress.userBillingAddress.city,
            //                        "state": response.userInfo.userAddress.userBillingAddress.state,
            //                        "postalCode": response.userInfo.userAddress.userBillingAddress.postalCode,
            //                        "countryCode": response.userInfo.userAddress.userBillingAddress.countryCode,
            //                    ],
            //                ],
            //            ],
            
            "channels": channels,
            "transactionInfo":[
                "recurring":[
                    "amount": response.transactionInfo.recurring.amount ?? "",
                    "interval": response.transactionInfo.recurring.interval,
                    "count": response.transactionInfo.recurring.count,
                    "chargeNextDate": response.transactionInfo.recurring.chargeNextDate ?? "",
                    "chargeOnDate": response.transactionInfo.recurring.chargeOnDate ?? "",
                ],
                "paymentItems": paymentItems,
                "amount": response.transactionInfo.amount ?? "",
                "currencyCode": response.transactionInfo.currencyCode ?? "",
                "invoiceNo": response.transactionInfo.invoiceNo ?? "",
                "productDescription": response.transactionInfo.productDescription ?? "",
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
