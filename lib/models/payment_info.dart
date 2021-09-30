/*
 * Created by Nonthawatt Phongwittayapanu on 21/9/21 2:20 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:pgw_sdk/models/payment_data.dart';

class PaymentInfo<T> {
  @protected
  String? fxRateId;

  @protected
  String? name;

  @protected
  String? email;

  @protected
  String? mobileNo;

  T setFXRateId(String fxRateId) {
    this.fxRateId = fxRateId;
    return this as T;
  }

  T setName(String name) {
    this.name = name;
    return this as T;
  }

  T setEmail(String email) {
    this.email = email;
    return this as T;
  }

  T setMobileNo(String mobileNo) {
    this.mobileNo = mobileNo;
    return this as T;
  }

  @protected
  PaymentData buildData() {
    var data = PaymentData()
      ..name = this.name
      ..email = this.email
      ..mobileNo = this.mobileNo
      ..fxRateId = this.fxRateId;

    return data;
  }
}
