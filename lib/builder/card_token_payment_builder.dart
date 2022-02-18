/*
 * Created by Nonthawatt Phongwittayapanu on 8/2/22 2:27 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_data.dart';
import 'package:pgw_sdk/models/payment_request.dart';
import 'package:pgw_sdk/models/univeral_payment_builder.dart';

class CardTokenPaymentBuilder extends UniversalPaymentBuilder<CardTokenPaymentBuilder> {
  CardTokenPaymentBuilder({
    required PaymentCode paymentCode,
    required String cardToken,
  })   : _paymentCode = paymentCode,
        _cardToken = cardToken;

  PaymentCode _paymentCode;
  String _cardToken;

  @override
  PaymentRequest build() {
    PaymentData data = this.buildData()
      ..token = this._cardToken
      ..expiryMonth = this.expiryMonth
      ..expiryYear = this.expiryYear
      ..securityCode = this.securityCode
      ..pin = this.pin
      ..interestType = this.installmentInterestType
      ..installmentPeriod = this.installmentPeriod;

    PaymentRequest request = PaymentRequest()
      ..code = _paymentCode
      ..data = data;
    return request;
  }
}
