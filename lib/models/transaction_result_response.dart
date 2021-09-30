/*
 * Created by Nonthawatt Phongwittayapanu on 23/9/21 3:41 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

class TransactionResultResponse {
  TransactionResultResponse({
    this.channelCode,
    this.invoiceNo,
    this.type,
    this.data,
    this.fallbackData,
    this.expiryTimer,
    this.expiryDescription,
    this.responseCode,
    this.responseDescription,
  });

  String? channelCode;
  String? invoiceNo;
  String? type;
  String? data;
  String? fallbackData;
  int? expiryTimer;
  String? expiryDescription;
  String? responseCode;
  String? responseDescription;
  String? raw;

  factory TransactionResultResponse.fromJson(String str) => TransactionResultResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionResultResponse.fromMap(Map<String, dynamic> json) => TransactionResultResponse(
        channelCode: json["channelCode"] == null ? null : json["channelCode"],
        invoiceNo: json["invoiceNo"] == null ? null : json["invoiceNo"],
        type: json["type"] == null ? null : json["type"],
        data: json["data"] == null ? null : json["data"],
        fallbackData: json["fallbackData"] == null ? null : json["fallbackData"],
        expiryTimer: json["expiryTimer"] == null ? null : json["expiryTimer"],
        expiryDescription: json["expiryDescription"] == null ? null : json["expiryDescription"],
        responseCode: json["responseCode"] == null ? null : json["responseCode"],
        responseDescription: json["responseDescription"] == null ? null : json["responseDescription"],
      );

  Map<String, dynamic> toMap() => {
        "channelCode": channelCode == null ? null : channelCode,
        "invoiceNo": invoiceNo == null ? null : invoiceNo,
        "type": type == null ? null : type,
        "data": data == null ? null : data,
        "fallbackData": fallbackData == null ? null : fallbackData,
        "expiryTimer": expiryTimer == null ? null : expiryTimer,
        "expiryDescription": expiryDescription == null ? null : expiryDescription,
        "responseCode": responseCode == null ? null : responseCode,
        "responseDescription": responseDescription == null ? null : responseDescription,
      };
}
