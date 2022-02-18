import 'package:pgw_sdk_example/api/repositories/constant_repository.dart';
import 'package:pgw_sdk_example/utils/string_helper.dart';

class DemoRequest {
  DemoRequest._();

  static Map<String, Object> getCCRequest({
    String? invoiceNo,
    String? description,
    double? amount,
    String? currencyCode,
    String? nonceStr,
    String? paymentChannel,
    bool tokenize = true,
  }) {
    return {
      "merchantID": ConstantRepository.MERCHANT_ID,
      "invoiceNo": invoiceNo ?? StringHelper.generateInvoiceNo(),
      "description": description ?? "Credit card payment",
      "amount": amount ?? 1.0,
      "currencyCode": currencyCode ?? ConstantRepository.CURRENCY_CODE,
      "nonceStr": nonceStr ?? "a8092512-b144-41b0-8284-568bb5e9264c",
      "paymentChannel": [paymentChannel ?? "CC"],
      "tokenize": tokenize,
      // "request3DS": "Y",
    };
  }

  static Map<String, Object> getCardTokenRequest({
    String? invoiceNo,
    String? description,
    double? amount,
    String? currencyCode,
    String? nonceStr,
    String? paymentChannel,
    required List<String> cardTokens,
  }) {
    return {
      "merchantID": ConstantRepository.MERCHANT_ID,
      "invoiceNo": invoiceNo ?? StringHelper.generateInvoiceNo(),
      "description": description ?? "Card token payment",
      "amount": amount ?? 1.0,
      "currencyCode": currencyCode ?? ConstantRepository.CURRENCY_CODE,
      "nonceStr": nonceStr ?? "a8092512-b144-41b0-8284-568bb5e9264c",
      "paymentChannel": [paymentChannel ?? "GCARD"],
      "cardTokens": cardTokens,
    };
  }
}
