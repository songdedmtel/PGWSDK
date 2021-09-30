import Flutter
import UIKit
import PGW

public class SwiftPgwSdkPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "pgw_sdk", binaryMessenger: registrar.messenger())
        let instance = SwiftPgwSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "sdkVersion":
            result("4.4.0")
            break;
        case "initialize":
            initialize(call, result: result)
            break;
        case "proceedTransaction":
            proceedTransaction(call, result: result)
            break;
        default:
            result(FlutterMethodNotImplemented)
            break;
        }
    }
    
    /// Initialize PGW
    private func initialize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let dicts = call.arguments as? [String: Any],
              let env = dicts["apiEnvironment"] as? String,
              let apiEnv = getApiEnvironmentFrom(value: env)
        else {
            result(FlutterError.init(code: "998", message: "Arguments exception", details: nil))
            return
        }
        let pgwsdkParams: PGWSDKParams = PGWSDKParamsBuilder(apiEnvironment: apiEnv).build()
        PGWSDK.initialize(params: pgwsdkParams)
    }
    
    private func proceedTransaction(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
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
//                guard let redirectUrl: String = response.data else { return } //Open WebView
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
                        return result(string)
                    }
                } catch let error as NSError {
                        print(error)
                }
//            } else if response.responseCode == APIResponseCode.TransactionCompleted {
//                //Inquiry payment result by using invoice no.
            } else {
                //Get error response and display error.
                result(FlutterError.init(code: response.responseCode, message: response.responseDescription, details: nil))
            }
        }) { (error: NSError) in
            //Get error response and display error.
            result(FlutterError.init(code: "\(error.code)", message: error.localizedDescription, details: nil))
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
            
            return TransactionResultRequestBuilder(paymentToken: paymentToken)
                .with(paymentRequest)
                .build()
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    func getPaymentRequest(_ paymentCode: PaymentCode, jsonDict: [String: Any?]) -> PaymentRequest? {
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
    
    private func getApiEnvironmentFrom(value: String) -> APIEnvironment? {
        switch value {
        case "Sandbox":
            return APIEnvironment.Sandbox
        case "Production":
            return APIEnvironment.Production
        case "ProductionIndonesia":
            return APIEnvironment.ProductionIndonesia
        default:
            return nil
        }
    }
}
