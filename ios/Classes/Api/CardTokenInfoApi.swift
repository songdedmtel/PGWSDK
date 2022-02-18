//
//  CardTokenInfoApi.swift
//  pgw_sdk
//
//  Created by Nonthawatt Phongwittayapanu on 20/10/2564 BE.
//

import UIKit
import PGW

class CardTokenInfoApi {
    private var call: FlutterMethodCall
    private var result: FlutterResult
    
    init(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.call = call
        self.result = result
    }
    
    func request() {
        guard let dicts = call.arguments as? [String: Any],
              let jsonString = dicts["cardTokenInfoRequest"] as? String
        else {
            result(FlutterError.init(code: "998", message: "Arguments exception", details: nil))
            return
        }
        guard let request = mappingRequest(json: jsonString) else {
            result(FlutterError.init(code: "900", message: "Json exception", details: nil))
            return
        }
        
        PGWSDK.shared.cardTokenInfo(cardTokenInfoRequest: request, { (response: CardTokenInfoResponse) in
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
    private func mappingRequest(json: String) -> CardTokenInfoRequest? {
        do {
            let jsonData = json.data(using: .utf8)!
            let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any?]
            let paymentToken = jsonDict?["paymentToken"] as? String ?? ""
            
            let request = CardTokenInfoRequest(paymentToken: paymentToken)
            
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
    private func mappingResposne(_ response: CardTokenInfoResponse) -> String? {
        
        var cardTokens: [[String: Any?]] = []
        response.cardTokens.forEach { (it: CardTokenInfo) in
            cardTokens.append(
                [
                    "token": it.token,
                    "cardNo": it.cardNo,
                    "expiryDate": it.expiryDate,
                    "name": it.name,
                    "email": it.email,
                    "status": it.status,
                    "iconUrl": it.iconUrl,
                    "logoUrl": it.logoUrl,
                ]
            )
        }
        
        let responseDict: [String : Any?] = [
            "paymentToken": response.paymentToken,
            "cardTokens": cardTokens,
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
