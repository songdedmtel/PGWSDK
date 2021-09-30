/*
 * Created by Nonthawatt Phongwittayapanu on 23/9/21 4:30 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_data.dart';

class PaymentRequest {
  PaymentRequest({
    this.code,
    this.data,
  });

  PaymentCode? code;
  PaymentData? data;

  factory PaymentRequest.fromJson(String str) => PaymentRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentRequest.fromMap(Map<String, dynamic> json) => PaymentRequest(
        code: json["code"] == null ? null : PaymentCode.fromMap(json["code"]),
        data: json["data"] == null ? null : PaymentData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code?.toMap(),
        "data": data == null ? null : data?.toMap(),
      };
}
