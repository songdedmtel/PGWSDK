//
//  TransactionStatusApi.swift
//  pgw_sdk
//
//  Created by Nonthawatt Phongwittayapanu on 7/10/2564 BE.
//  Copyright © 2021 2C2P. All rights reserved.
//

import UIKit
import PGW

class TransactionStatusApi {
    private var call: FlutterMethodCall
    private var result: FlutterResult
    
    init(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.call = call
        self.result = result
    }
    
    func request() {
        guard let dicts = call.arguments as? [String: Any],
              let jsonString = dicts["transactionStatusRequest"] as? String
        else {
            result(FlutterError.init(code: "998", message: "Arguments exception", details: nil))
            return
        }
        guard
            let request = mappingRequest(json: jsonString) else {
            result(FlutterError.init(code: "900", message: "Json exception", details: nil))
            return
        }
        
        PGWSDK.shared.transactionStatus(transactionStatusRequest: request, { (response: TransactionStatusResponse) in
            if response.responseCode == APIResponseCode.TransactionNotFound ||
                response.responseCode == APIResponseCode.TransactionCompleted {
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
    private func mappingRequest(json: String) -> TransactionStatusRequest? {
        do {
            let jsonData = json.data(using: .utf8)!
            let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any?]
            let paymentToken = jsonDict?["paymentToken"] as? String ?? ""
            
            let request: TransactionStatusRequest = TransactionStatusRequest(paymentToken: paymentToken)
            request.additionalInfo = true
            
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
    private func mappingResposne(_ response: TransactionStatusResponse) -> String? {
        let responseDict: [String : Any?] = [
            "channelCode": response.channelCode!,
            "invoiceNo": response.invoiceNo!,
            "additionalInfo": [
                "transactionDetails": [
                    "dateTime": response.additionalInfo.transactionInfo.dateTime!,
                    "agentCode": response.additionalInfo.transactionInfo.agentCode!,
                    "channelCode": response.additionalInfo.transactionInfo.channelCode!,
                    "data": response.additionalInfo.transactionInfo.data!,
                    "interestType": response.additionalInfo.transactionInfo.interestType!,
                    "interestRate": response.additionalInfo.transactionInfo.interestRate,
                    "monthlyAmount": response.additionalInfo.transactionInfo.monthlyAmount,
                    "installmentPeriod": response.additionalInfo.transactionInfo.installmentPeriod,
                    "amount": response.additionalInfo.transactionInfo.amount!,
                    "currencyCode": response.additionalInfo.transactionInfo.currencyCode!,
                    "invoiceNo": response.additionalInfo.transactionInfo.invoiceNo!,
                    "productDescription": response.additionalInfo.transactionInfo.productDescription!,
                ],
                "merchantDetails": [
                    "id": response.additionalInfo.merchantInfo.id!,
                    "name": response.additionalInfo.merchantInfo.name!,
                    "address": response.additionalInfo.merchantInfo.address!,
                    "email": response.additionalInfo.merchantInfo.email!,
                    "logoUrl": response.additionalInfo.merchantInfo.logoUrl!,
                    "bannerUrl": response.additionalInfo.merchantInfo.bannerUrl!,
                ],
                "paymentResultDetails": [
                    "code": response.additionalInfo.resultInfo.responseCode!,
                    "description": response.additionalInfo.resultInfo.responseDescription!,
                    "autoRedirectTimer": response.additionalInfo.resultInfo.autoRedirectTimer,
                    "frontendReturnUrl": response.additionalInfo.resultInfo.frontendReturnUrl!,
                    "frontendReturnData": response.additionalInfo.resultInfo.frontendReturnData!,
                ],
            ],
            "responseCode": response.responseCode,
            "responseDescription": response.responseDescription,
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
