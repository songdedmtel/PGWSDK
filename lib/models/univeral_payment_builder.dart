/*
 * Created by Nonthawatt Phongwittayapanu on 21/9/21 2:23 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:pgw_sdk/models/payment_info.dart';
import 'package:pgw_sdk/models/payment_request.dart';

abstract class UniversalPaymentBuilder<T> extends PaymentInfo<T> {
  @protected
  int? expiryMonth;
  @protected
  int? expiryYear;
  @protected
  String? securityCode;
  @protected
  String? pin;
  @protected
  String? installmentInterestType;
  @protected
  int? installmentPeriod;

  PaymentRequest build();

  T setExpiryMonth(int month) {
    this.expiryMonth = month;
    return this as T;
  }

  T setExpiryYear(int year) {
    this.expiryYear = year;
    return this as T;
  }

  T setSecurityCode(String securityCode) {
    this.securityCode = securityCode;
    return this as T;
  }

  T setPin(String pin) {
    this.pin = pin;
    return this as T;
  }

  T setInstallmentInterestType(String installmentInterestType) {
    this.installmentInterestType = installmentInterestType;
    return this as T;
  }

  T setInstallmentPeriod(int installmentPeriod) {
    this.installmentPeriod = installmentPeriod;
    return this as T;
  }
}
