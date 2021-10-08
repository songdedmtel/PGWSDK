//
//  TransactionApi.swift
//  pgw_sdk
//
//  Created by Nonthawatt Phongwittayapanu on 7/10/2564 BE.
//  Copyright © 2021 2C2P. All rights reserved.
//

import UIKit
import PGW

class TransactionApi {
    private var call: FlutterMethodCall
    private var result: FlutterResult
    
    init(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.call = call
        self.result = result
    }
    
    func proceed() {
        guard let dicts = call.arguments as? [String: Any],
              let jsonString = dicts["request"] as? String
        else {
            result(FlutterError.init(code: "998", message: "Arguments exception", details: nil))
            return
        }
        guard let request = mappingRequest(json: jsonString) else {
            result(FlutterError.init(code: "900", message: "Json exception", details: nil))
            return
        }
        
        PGWSDK.shared.proceedTransaction(transactionResultRequest: request, { (response: TransactionResultResponse) in
            if response.responseCode == APIResponseCode.TransactionAuthenticateRedirect ||
                response.responseCode == APIResponseCode.TransactionAuthenticateFullRedirect ||
                response.responseCode == APIResponseCode.TransactionCompleted {
                
                let responseDict = [
                    "channelCode": response.channelCode as String,
                    "invoiceNo": response.invoiceNo as String,
                    "type": response.type as String,
                    "data": response.data as String,
                    "fallbackData": response.fallbackData as String,
                    "expiryTimer": response.expiryTimer as Int,
                    "expiryDescription": response.expiryDescription as String,
                    "responseCode": response.responseCode as String,
                    "responseDescription": response.responseDescription as String,
                ] as [String : Any]
                
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: responseDict)
                    if let string = String(data: data, encoding: .utf8) {
                        print(string)
                        return self.result(string)
                    }
                } catch let error as NSError {
                        print(error)
                }
//            } else if response.responseCode == APIResponseCode.TransactionCompleted {
//                //Inquiry payment result by using invoice no.
            } else {
                //Get error response and display error.
                self.result(FlutterError.init(code: response.responseCode, message: response.responseDescription, details: nil))
            }
        }) { (error: NSError) in
            //Get error response and display error.
            self.result(FlutterError.init(code: "\(error.code)", message: error.localizedDescription, details: nil))
        }
    }
    
    private func mappingRequest(json: String) -> TransactionResultRequest? {
        do {
            let jsonData = json.data(using: .utf8)!
            let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any?]
            let paymentToken = jsonDict?["paymentToken"] as? String ?? ""
            
            /// Get "payment": {...}
            let jsonPayment = jsonDict?["payment"] as? [String: Any?] ?? [:]
            
            /// Get "code": {...}, "data": {...}
            let jsonPaymentCode = jsonPayment["code"] as? [String: Any?] ?? [:]
            let jsonPaymentData = jsonPayment["data"] as? [String: Any?] ?? [:]
            
            let paymentCode: PaymentCode = PaymentCode(
                channelCode: jsonPaymentCode["channelCode"] as? String ?? "",
                jsonPaymentCode["agentCode"] as? String ?? "",
                jsonPaymentCode["agentChannelCode"] as? String ?? ""
            )
            guard let paymentRequest = getPaymentRequest(paymentCode, jsonDict: jsonPaymentData) else {
                return nil
            }
            
            var builder = TransactionResultRequestBuilder(paymentToken: paymentToken)
            if let clientId = jsonDict?["clientID"] as? String {
                builder = builder.clientId(clientId)
            }
            if let locale = jsonDict?["locale"] as? String {
                builder = builder.locale(locale)
            }
            
            return builder
                .with(paymentRequest)
                .build()
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    private func getPaymentRequest(_ paymentCode: PaymentCode, jsonDict: [String: Any?]) -> PaymentRequest? {
        switch paymentCode.channelCode {
        case "CC":
            return CardPaymentBuilder(paymentCode: paymentCode, jsonDict["cardNo"] as? String ?? "")
                .expiryMonth(jsonDict["expiryMonth"] as? Int ?? 0)
                .expiryYear(jsonDict["expiryYear"] as? Int ?? 0)
                .securityCode(jsonDict["securityCode"] as? String ?? "")
                .build()
        case "123":
            switch paymentCode.agentChannelCode {
            case "IBANKING":
                return InternetBankingBuilder(paymentCode: paymentCode)
                    .name(jsonDict["name"] as? String ?? "")
                    .email(jsonDict["email"] as? String ?? "")
                    .mobileNo(jsonDict["mobileNo"] as? String ?? "")
                    .build()
            case "WEBPAY":
                return WebPaymentBuilder(paymentCode: paymentCode)
                    .name(jsonDict["name"] as? String ?? "")
                    .email(jsonDict["email"] as? String ?? "")
                    .mobileNo(jsonDict["mobileNo"] as? String ?? "")
                    .build()
            case "OVERTHECOUNTER":
                return PayAtCounterBuilder(paymentCode: paymentCode)
                    .name(jsonDict["name"] as? String ?? "")
                    .email(jsonDict["email"] as? String ?? "")
                    .mobileNo(jsonDict["mobileNo"] as? String ?? "")
                    .build()
            case "ATM":
                return SelfServiceMachineBuilder(paymentCode: paymentCode)
                    .name(jsonDict["name"] as? String ?? "")
                    .email(jsonDict["email"] as? String ?? "")
                    .mobileNo(jsonDict["mobileNo"] as? String ?? "")
                    .build()
            default:
                return nil
            }
        case "VEMVQR":
            return QRPaymentBuilder(paymentCode: paymentCode)
                .type(QRTypeCode.URL)
                .name(jsonDict["name"] as? String ?? "")
                .email(jsonDict["email"] as? String ?? "")
                .mobileNo(jsonDict["mobileNo"] as? String ?? "")
                .build()
        case "UPOP":
            return CardPaymentBuilder(paymentCode: paymentCode)
                .name(jsonDict["name"] as? String ?? "")
                .email(jsonDict["email"] as? String ?? "")
                .mobileNo(jsonDict["mobileNo"] as? String ?? "")
                .build()
        case "GCASH",
             "GRAB",
             "TNG",
             "TRUEMONEY",
             "WAVE",
             "OKDOLLAR",
             "BOOST",
             "PAYPAL",
             "MPS",
             "SPA",
             "KPY",
             "CBY",
             "OVO",
             "LINKAJA":
            return DigitalPaymentBuilder(paymentCode: paymentCode)
                .name(jsonDict["name"] as? String ?? "")
                .email(jsonDict["email"] as? String ?? "")
                .accountNo(jsonDict["accountNo"] as? String ?? "")
                .build()
        case "MPASS":
            return DigitalPaymentBuilder(paymentCode: paymentCode)
                .name(jsonDict["name"] as? String ?? "")
                .email(jsonDict["email"] as? String ?? "")
                .mobileNo(jsonDict["mobileNo"] as? String ?? "")
                .build()
        case "ALIPAY":
            return DigitalPaymentBuilder(paymentCode: paymentCode)
                .name(jsonDict["name"] as? String ?? "")
                .email(jsonDict["email"] as? String ?? "")
                .build()
        case "KBZ":
            return CardPaymentBuilder(paymentCode: paymentCode, jsonDict["cardNo"] as? String ?? "")
                .expiryMonth(jsonDict["expiryMonth"] as? Int ?? 0)
                .expiryYear(jsonDict["expiryYear"] as? Int ?? 0)
                .pin(jsonDict["pin"] as? String ?? "")
                .build()
        default:
            return nil
        }
    }
}
