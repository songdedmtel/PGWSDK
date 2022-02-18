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
            TransactionApi(call, result: result).proceed()
            break;
        case "paymentWithCardToken":
            PaymentWithCardToken(call, result: result).proceed()
            break;
        case "paymentOption":
            PaymentOptionApi(call, result: result).request()
            break;
        case "paymentOptionDetail":
            PaymentOptionDetailApi(call, result: result).request()
            break;
        case "transactionStatus":
            TransactionStatusApi(call, result: result).request()
            break;
        case "cardTokenInfo":
            TransactionStatusApi(call, result: result).request()
            break;
        default:
            result(FlutterMethodNotImplemented)
            break;
        }
    }
    
    /** ======================================== Initialize PGW ======================================== **/
    // MARK: - Initialize PGW
    
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
