import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:pgw_sdk/builder/card_payment_builder.dart';
import 'package:pgw_sdk/builder/internet_banking_builder.dart';
import 'package:pgw_sdk/builder/pay_at_counter_builder.dart';
import 'package:pgw_sdk/builder/qr_payment_builder.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_request.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:pgw_sdk_example/models/token_response.dart';

class Transaction {
  Transaction._();

  static String encodePayload({
    required String merchantId,
    required String invoiceNo,
    required String description,
    required double amount,
    required String currencyCode,
    required String nonceStr,
    required String paymentChannel,
    required String merchantKey,
  }) {
    final jwt = JWT({
      "merchantID": "$merchantId",
      "invoiceNo": "$invoiceNo",
      "description": "$description",
      "amount": amount,
      "currencyCode": "$currencyCode",
      "nonceStr": "$nonceStr",
      "paymentChannel": ["$paymentChannel"],
    }, header: {
      "alg": "HS256",
      "typ": "JWT"
    });

    String token = jwt.sign(SecretKey(merchantKey));
    return token;
  }

  static Future<TokenResponse> getToken({required String payload}) {
    return http.post(
      Uri.parse('https://sandbox-pgw.2c2p.com/payment/4.1/PaymentToken'),
      body: jsonEncode({'payload': payload}),
      headers: {
        'Accept': 'text/plain',
        'Content-Type': 'application/*+json',
        'Host': 'sandbox-pgw.2c2p.com',
      },
    ).then((value) {
      String encodedResponse = jsonDecode(value.body)["payload"].split('.')[1];
      print('Encode ' + encodedResponse);
      if (encodedResponse.length % 4 != 0) encodedResponse += '=' * (4 - encodedResponse.length % 4);
      String decodedResponse = utf8.decode(base64Url.decode(encodedResponse));
      print('Decode ' + decodedResponse);
      String paymentToken = jsonDecode(decodedResponse)["paymentToken"];
      String webPaymentUrl = jsonDecode(decodedResponse)["webPaymentUrl"];
      print('Response token ' + paymentToken);
      return TokenResponse(webPaymentUrl: '$webPaymentUrl', paymentToken: '$paymentToken');
    });
  }

  static Future<TransactionResultResponse> proceed({
    required String paymentChannel,
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNo,
    String? agentCode,
    String? agentChannelCode,
    String? channelCode,
    String? paymentToken,
    String? webPaymentUrl,
  }) async {
    PGWSDK.initialize(APIEnvironment.Sandbox);
    PaymentCode? paymentCode;
    PaymentRequest? paymentRequest;
    switch (paymentChannel) {
      case 'COUNTER':
        // Not all agents work
        paymentCode = PaymentCode(channelCode: '123', agentCode: '$agentCode', agentChannelCode: 'OVERTHECOUNTER');
        paymentRequest =
            PayAtCounterBuilder(paymentCode: paymentCode).setName('$firstName$lastName').setEmail('$email').setMobileNo('$mobileNo').build();
        break;
      case 'QR':
        // Not all agents work
        print(channelCode);
        paymentCode = PaymentCode(channelCode: 'VEMVQR');
        paymentRequest = QRPaymentBuilder(paymentCode: paymentCode)
            .setType(QRTypeCode.url)
            .setName('$firstName$lastName')
            .setEmail('$email')
            .setMobileNo('$mobileNo')
            .build();
        break;
      case 'IMBANK':
        // Not all agents work
        paymentCode = PaymentCode(channelCode: '123', agentCode: '$agentCode', agentChannelCode: 'IBANKING');
        paymentRequest =
            InternetBankingBuilder(paymentCode: paymentCode).setName('$firstName$lastName').setEmail('$email').setMobileNo('$mobileNo').build();
        break;
      case 'GCARD':
        // Not all agents work
        paymentCode = PaymentCode(channelCode: 'CC');
        paymentRequest =
            CardPaymentBuilder(paymentCode: paymentCode).setName('$firstName$lastName').setEmail('$email').setMobileNo('$mobileNo').build();
        break;
      default:
        paymentRequest = null;
    }
    TransactionResultRequestBuilder transactionResultRequest =
        TransactionResultRequestBuilder(paymentRequest: paymentRequest, paymentToken: paymentToken);
    print(transactionResultRequest.toJson());
    return PGWSDK.proceedTransaction(transactionResultRequest);
  }
}
