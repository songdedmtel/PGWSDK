import 'dart:convert';

class PaymentOptionDetailRequest {
  PaymentOptionDetailRequest({
    required this.paymentToken,
    this.clientId,
    this.locale,
    this.categoryCode,
    this.groupCode,
  });

  String? paymentToken;
  String? clientId;
  String? locale;
  String? categoryCode;
  String? groupCode;

  factory PaymentOptionDetailRequest.fromJson(String str) => PaymentOptionDetailRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentOptionDetailRequest.fromMap(Map<String, dynamic> json) => PaymentOptionDetailRequest(
        paymentToken: json["paymentToken"] == null ? null : json["paymentToken"],
        clientId: json["clientID"] == null ? null : json["clientID"],
        locale: json["locale"] == null ? null : json["locale"],
        categoryCode: json["categoryCode"] == null ? null : json["categoryCode"],
        groupCode: json["groupCode"] == null ? null : json["groupCode"],
      );

  Map<String, dynamic> toMap() => {
        "paymentToken": paymentToken == null ? null : paymentToken,
        "clientID": clientId == null ? null : clientId,
        "locale": locale == null ? null : locale,
        "categoryCode": categoryCode == null ? null : categoryCode,
        "groupCode": groupCode == null ? null : groupCode,
      };
}
