import 'dart:convert';

class PaymentOptionRequest {
  PaymentOptionRequest({
    required this.paymentToken,
    this.clientId,
    this.locale,
  });

  String? paymentToken;
  String? clientId;
  String? locale;

  factory PaymentOptionRequest.fromJson(String str) => PaymentOptionRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentOptionRequest.fromMap(Map<String, dynamic> json) => PaymentOptionRequest(
        paymentToken: json["paymentToken"] == null ? null : json["paymentToken"],
        clientId: json["clientID"] == null ? null : json["clientID"],
        locale: json["locale"] == null ? null : json["locale"],
      );

  Map<String, dynamic> toMap() => {
        "paymentToken": paymentToken == null ? null : paymentToken,
        "clientID": clientId == null ? null : clientId,
        "locale": locale == null ? null : locale,
      };
}
