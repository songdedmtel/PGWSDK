import 'dart:convert';

class ExChangeRateRequest {
  ExChangeRateRequest({
    required this.paymentToken,
    this.clientId,
    this.locale,
  });
  String paymentToken;
  String? clientId;
  String? locale;

  factory ExChangeRateRequest.fromJson(String str) => ExChangeRateRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExChangeRateRequest.fromMap(Map<String, dynamic> json) => ExChangeRateRequest(
        paymentToken: json["paymentToken"] == null ? null : json["paymentToken"],
        clientId: json["clientID"] == null ? null : json["clientID"],
        locale: json["locale"] == null ? null : json["locale"],
      );

  Map<String, dynamic> toMap() => {
        "paymentToken": paymentToken,
        "clientID": clientId == null ? null : clientId,
        "locale": locale == null ? null : locale,
      };
}
