import 'dart:developer';
import 'dart:math' as Math;

import 'package:flutter/cupertino.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/models/payment_option_detail/payment_option_detail_request.dart';
import 'package:pgw_sdk/models/payment_option_detail/payment_option_detail_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:pgw_sdk_example/models/enums/category_code.dart';
import 'package:pgw_sdk_example/models/enums/group_code.dart';
import 'package:pgw_sdk_example/models/token_response.dart';
import 'package:pgw_sdk_example/utils/transaction.dart';

class PaymentOptionDetailsInteractor {
  late BuildContext _context;

  PaymentOptionDetailsInteractor(BuildContext context) {
    _context = context;
  }
  Future<PaymentOptionDetailResponse> doCallPaymentOptionDetails({required CategoryCode categoryCode, required GroupCode groupCode}) async {
    PGWSDK.initialize(APIEnvironment.Sandbox);
    String payload = Transaction.encodePayload(
      merchantId: 'JT01',
      invoiceNo: (Math.Random().nextInt(3000000000) + 1000000000).toString(),
      description: "Example Description",
      amount: 10.0,
      currencyCode: 'SGD',
      nonceStr: "a8092512-b144-41b0-8284-568bb5e9264c",
      paymentChannel: "ALL",
      merchantKey: 'ECC4E54DBA738857B84A7EBC6B5DC7187B8DA68750E88AB53AAA41F548D6F2D9',
    );

    TokenResponse tokenResponse = await Transaction.getToken(payload: payload);
    PaymentOptionDetailRequest paymentOptionDetailRequest = PaymentOptionDetailRequest(
        paymentToken: tokenResponse.paymentToken,
        clientId: "E380BEC2BFD727A4B6845133519F3AD7",
        locale: 'en',
        categoryCode: categoryCode.name,
        groupCode: groupCode.name);
    print(paymentOptionDetailRequest);
    return PGWSDK.paymentOptionDetail(paymentOptionDetailRequest).then((value) {
      log(value.toJson());
      return value;
    });
  }
}
