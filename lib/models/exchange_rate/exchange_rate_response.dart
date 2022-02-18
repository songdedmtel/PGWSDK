import 'dart:convert';

class ExChangeRateResponse {
  ExChangeRateResponse({
    this.paymentToken,
    this.providerCode,
    this.expire,
    this.fxRates,
    this.responseCode,
    this.responseDescription,
  });

  String? paymentToken;
  String? providerCode;
  int? expire;
  List<FXRate>? fxRates;
  String? responseCode;
  String? responseDescription;

  factory ExChangeRateResponse.fromJson(String str) => ExChangeRateResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory ExChangeRateResponse.fromMap(Map<String, dynamic> json) => ExChangeRateResponse(
        paymentToken: json["paymentToken"] == null ? null : json["paymentToken"],
        providerCode: json["providerCode"] == null ? null : json["providerCode"],
        expire: json["expire"] == null ? null : json["expire"],
        fxRates: json["fxRates"] == null ? null : List<FXRate>.from(json["fxRates"].map((x) => FXRate.fromMap(x))),
        responseCode: json["responseCode"] == null ? null : json["responseCode"],
        responseDescription: json["responseDescription"] == null ? null : json["responseDescription"],
      );

  Map<String, dynamic> toMap() => {
        "paymentToken": paymentToken == null ? null : paymentToken,
        "providerCode": providerCode == null ? null : providerCode,
        "expire": expire == null ? null : expire,
        "fxRates": fxRates == null ? null : List<dynamic>.from(fxRates!.map((x) => x.toMap())),
        "responseCode": responseCode == null ? null : responseCode,
        "responseDescription": responseDescription == null ? null : responseDescription,
      };
}

class FXRate {
  FXRate({
    this.sequenceNo,
    this.id,
    this.name,
    this.iconUrl,
    this.amount,
    this.fx,
    this.currencyCode,
  });

  int? sequenceNo;
  String? id;
  String? name;
  String? iconUrl;
  String? amount;
  int? fx;
  String? currencyCode;

  factory FXRate.fromJson(String str) => FXRate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FXRate.fromMap(Map<String, dynamic> json) => FXRate(
        sequenceNo: json["sequenceNo"] == null ? null : json["sequenceNo"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        amount: json["code"] == null ? null : json["code"],
        fx: json["fx"] == null ? null : json["fx"],
        currencyCode: json["currencyCode"] == null ? null : json["currencyCode"],
      );

  Map<String, dynamic> toMap() => {
        "sequenceNo": sequenceNo == null ? null : sequenceNo,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "amount": amount == null ? null : amount,
        "fx": fx == null ? null : fx,
        "currencyCode": currencyCode == null ? null : currencyCode,
      };
}
