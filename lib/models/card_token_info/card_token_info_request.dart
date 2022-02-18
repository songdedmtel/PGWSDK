import 'dart:convert';

class CardTokenInfoRequest {
  CardTokenInfoRequest({
    required this.paymentToken,
    this.clientId,
    this.locale,
  });
  String paymentToken;
  String? clientId;
  String? locale;

  factory CardTokenInfoRequest.fromJson(String str) => CardTokenInfoRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardTokenInfoRequest.fromMap(Map<String, dynamic> json) => CardTokenInfoRequest(
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
