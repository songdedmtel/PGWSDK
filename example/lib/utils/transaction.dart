import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:pgw_sdk/builder/pay_at_counter_builder.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_request.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static Future<String> getToken({required String payload}) {
    String token = '';
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
      String responseToken = jsonDecode(decodedResponse)["paymentToken"];
      print('Response token ' + responseToken);
      return responseToken;
    });
  }

  static proceed(
      {String? firstName, String? lastName, String? email, String? mobileNo, String? agentCode, String? token, String? agentChannelCode}) async {
    PGWSDK.initialize(APIEnvironment.Sandbox);
    PaymentCode paymentCode = PaymentCode(channelCode: '123', agentCode: '$agentCode', agentChannelCode: '$agentChannelCode');
    PaymentRequest paymentRequest =
        PayAtCounterBuilder(paymentCode: paymentCode).setName('$firstName$lastName').setEmail('$email').setMobileNo('$mobileNo').build();
    TransactionResultRequestBuilder transactionResultRequest = TransactionResultRequestBuilder(paymentRequest: paymentRequest, paymentToken: token);

    PGWSDK.proceedTransaction(transactionResultRequest).then((res) => launch(res.data!));
  }
}
