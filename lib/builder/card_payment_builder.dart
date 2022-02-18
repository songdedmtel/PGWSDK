/*
 * Created by Nonthawatt Phongwittayapanu on 21/9/21 2:24 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_data.dart';
import 'package:pgw_sdk/models/payment_request.dart';
import 'package:pgw_sdk/models/univeral_payment_builder.dart';

class CardPaymentBuilder extends UniversalPaymentBuilder<CardPaymentBuilder> {
  CardPaymentBuilder({
    required PaymentCode paymentCode,
    String? cardNo,
  })  : _paymentCode = paymentCode,
        _cardNo = cardNo;

  PaymentCode? _paymentCode;

  String? _cardNo;
  String? _bank;
  String? _country;
  bool? _tokenize;

  CardPaymentBuilder setCardNo(String cardNo) {
    this._cardNo = cardNo;
    return this;
  }

  CardPaymentBuilder setBank(String bank) {
    this._bank = bank;
    return this;
  }

  CardPaymentBuilder setCountry(String country) {
    this._country = country;
    return this;
  }

  CardPaymentBuilder setTokenize(bool tokenize) {
    this._tokenize = tokenize;
    return this;
  }

  @override
  PaymentRequest build() {
    PaymentData data = this.buildData()
      ..cardNo = this._cardNo
      ..expiryMonth = this.expiryMonth
      ..expiryYear = this.expiryYear
      ..securityCode = this.securityCode
      ..pin = this.pin
      ..cardBank = this._bank
      ..cardCountry = this._country
      ..cardTokenize = _tokenize
      ..interestType = this.installmentInterestType
      ..installmentPeriod = this.installmentPeriod;

    PaymentRequest request = PaymentRequest()
      ..code = _paymentCode
      ..data = data;
    return request;
  }
}
