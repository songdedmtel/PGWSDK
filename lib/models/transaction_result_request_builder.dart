/*
 * Created by Nonthawatt Phongwittayapanu on 20/9/21 3:11 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

import 'package:pgw_sdk/models/payment_request.dart';

class TransactionResultRequestBuilder {
  TransactionResultRequestBuilder({
    required this.paymentToken,
    required this.paymentRequest,
    this.clientId,
    this.locale,
  });

  String? paymentToken;
  String? clientId;
  String? locale;
  PaymentRequest? paymentRequest;

  factory TransactionResultRequestBuilder.fromJson(String str) =>
      TransactionResultRequestBuilder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionResultRequestBuilder.fromMap(Map<String, dynamic> json) => TransactionResultRequestBuilder(
        paymentToken: json["paymentToken"] == null ? null : json["paymentToken"],
        clientId: json["clientID"] == null ? null : json["clientID"],
        locale: json["locale"] == null ? null : json["locale"],
        paymentRequest: json["payment"] == null ? null : PaymentRequest.fromMap(json["payment"]),
      );

  Map<String, dynamic> toMap() => {
        "paymentToken": paymentToken == null ? null : paymentToken,
        "clientID": clientId == null ? null : clientId,
        "locale": locale == null ? null : locale,
        "payment": paymentRequest == null ? null : paymentRequest?.toMap(),
      };
}
