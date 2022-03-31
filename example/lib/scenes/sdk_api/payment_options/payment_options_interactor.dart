import 'dart:math' as Math;

import 'package:flutter/cupertino.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/models/payment_option/payment_option_request.dart';
import 'package:pgw_sdk/models/payment_option/payment_option_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:pgw_sdk_example/models/enums/country_code.dart';
import 'package:pgw_sdk_example/models/token_response.dart';
import 'package:pgw_sdk_example/utils/transaction.dart';

class PaymentOptionsInteractor {
  late BuildContext _context;

  PaymentOptionsInteractor(BuildContext context) {
    _context = context;
  }

  Future<PaymentOptionResponse> doCallPaymentOptions({required CountryCode countryCode}) async {
    PGWSDK.initialize(APIEnvironment.Sandbox);
    String payload = Transaction.encodePayload(
      merchantId: countryCode.merchantId,
      invoiceNo: (Math.Random().nextInt(3000000000) + 1000000000).toString(),
      description: "Example Description",
      amount: 10.0,
      currencyCode: countryCode.currencyCode,
      nonceStr: "a8092512-b144-41b0-8284-568bb5e9264c",
      paymentChannel: "ALL",
      merchantKey: countryCode.merchantSecretKey,
    );

    TokenResponse tokenResponse = await Transaction.getToken(payload: payload);
    PaymentOptionRequest paymentOptionRequest = PaymentOptionRequest(paymentToken: tokenResponse.paymentToken);
    print(countryCode);
    print(paymentOptionRequest);
    return PGWSDK.paymentOption(paymentOptionRequest);
  }
}
