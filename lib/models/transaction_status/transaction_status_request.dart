import 'dart:convert';

class TransactionStatusRequest {
  TransactionStatusRequest({
    required this.paymentToken,
    this.clientId,
    this.locale,
  });

  String? paymentToken;
  String? clientId;
  String? locale;

  factory TransactionStatusRequest.fromJson(String str) => TransactionStatusRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionStatusRequest.fromMap(Map<String, dynamic> json) => TransactionStatusRequest(
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
