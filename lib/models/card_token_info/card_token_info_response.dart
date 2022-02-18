import 'dart:convert';

class CardTokenInfoResponse {
  CardTokenInfoResponse({
    this.paymentToken,
    this.cardTokens,
    this.responseCode,
    this.responseDescription,
  });

  String? paymentToken;
  List<CardTokenInfo>? cardTokens;
  String? responseCode;
  String? responseDescription;

  factory CardTokenInfoResponse.fromJson(String str) => CardTokenInfoResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory CardTokenInfoResponse.fromMap(Map<String, dynamic> json) => CardTokenInfoResponse(
        paymentToken: json["paymentToken"] == null ? null : json["paymentToken"],
        cardTokens: json["cardTokens"] == null ? null : List<CardTokenInfo>.from(json["cardTokens"].map((x) => CardTokenInfo.fromMap(x))),
        responseCode: json["responseCode"] == null ? null : json["responseCode"],
        responseDescription: json["responseDescription"] == null ? null : json["responseDescription"],
      );

  Map<String, dynamic> toMap() => {
        "paymentToken": paymentToken == null ? null : paymentToken,
        "cardTokens": cardTokens == null ? null : List<dynamic>.from(cardTokens!.map((x) => x.toMap())),
        "responseCode": responseCode == null ? null : responseCode,
        "responseDescription": responseDescription == null ? null : responseDescription,
      };
}

class CardTokenInfo {
  CardTokenInfo({
    this.token,
    this.cardNo,
    this.expiryDate,
    this.name,
    this.email,
    this.status,
    this.iconUrl,
    this.logoUrl,
  });

  String? token;
  String? cardNo;
  String? expiryDate;
  String? name;
  String? email;
  String? status;
  String? iconUrl;
  String? logoUrl;

  factory CardTokenInfo.fromJson(String str) => CardTokenInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardTokenInfo.fromMap(Map<String, dynamic> json) => CardTokenInfo(
        token: json["token"] == null ? null : json["token"],
        cardNo: json["cardNo"] == null ? null : json["cardNo"],
        expiryDate: json["expiryDate"] == null ? null : json["expiryDate"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        status: json["status"] == null ? null : json["status"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
      );

  Map<String, dynamic> toMap() => {
        "token": token == null ? null : token,
        "cardNo": cardNo == null ? null : cardNo,
        "expiryDate": expiryDate == null ? null : expiryDate,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "status": status == null ? null : status,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "logoUrl": logoUrl == null ? null : logoUrl,
      };
}
