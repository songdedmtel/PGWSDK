import 'dart:convert';

import 'package:pgw_sdk/models/payment_option/payment_option_response.dart';

class PaymentOptionDetailResponse {
  PaymentOptionDetailResponse({
    this.name,
    this.categoryCode,
    this.groupCode,
    this.iconUrl,
    this.validation,
    this.channels,
    this.totalChannel,
    this.configurationInfo,
    this.responseCode,
    this.responseDescription,
  });

  String? name;
  String? categoryCode;
  String? groupCode;
  String? iconUrl;

  CommonValidation? validation;
  List<PaymentChannel>? channels;
  int? totalChannel;
  ConfigurationInfo? configurationInfo;
  String? responseCode;
  String? responseDescription;

  factory PaymentOptionDetailResponse.fromJson(String str) => PaymentOptionDetailResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentOptionDetailResponse.fromMap(Map<String, dynamic> json) => PaymentOptionDetailResponse(
        name: json["name"] == null ? null : json["name"],
        categoryCode: json["code"] == null ? null : json["code"],
        groupCode: json["code"] == null ? null : json["code"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        validation: json["validation"] == null ? null : CommonValidation.fromMap(json["validation"]),
        channels: json["channels"] == null ? null : List<PaymentChannel>.from(json["channels"].map((x) => PaymentChannel.fromMap(x))),
        totalChannel: json["totalChannel"] == null ? null : json["totalChannel"],
        configurationInfo: json["configurationInfo"] == null ? null : ConfigurationInfo.fromMap(json["configurationInfo"]),
        responseCode: json["responseCode"] == null ? null : json["responseCode"],
        responseDescription: json["responseDescription"] == null ? null : json["responseDescription"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "categoryCode": categoryCode == null ? null : categoryCode,
        "groupCode": groupCode == null ? null : groupCode,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "validation": validation == null ? null : validation?.toMap(),
        "channels": channels == null ? null : List<dynamic>.from(channels!.map((x) => x.toMap())),
        "totalChannel": totalChannel == null ? null : totalChannel,
        "configurationInfo": configurationInfo == null ? null : configurationInfo?.toMap(),
        "responseCode": responseCode == null ? null : responseCode,
        "responseDescription": responseDescription == null ? null : responseDescription,
      };
}

class PaymentChannel {
  PaymentChannel({
    this.sequenceNo,
    this.name,
    this.code,
    this.iconUrl,
    this.logoUrl,
  });

  int? sequenceNo;
  String? name;
  String? code;
  String? iconUrl;
  String? logoUrl;

  factory PaymentChannel.fromJson(String str) => PaymentChannel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentChannel.fromMap(Map<String, dynamic> json) => PaymentChannel(
        sequenceNo: json["sequenceNo"] == null ? null : json["sequenceNo"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
      );

  Map<String, dynamic> toMap() => {
        "sequenceNo": sequenceNo == null ? null : sequenceNo,
        "name": name == null ? null : name,
        "code": code == null ? null : code,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "logoUrl": logoUrl == null ? null : logoUrl,
      };
}

class CommonValidation {
  CommonValidation({
    this.cardNo,
    this.cardTypes,
  });

  CardNoValidation? cardNo;
  List<CardTypeValidation>? cardTypes;

  factory CommonValidation.fromJson(String str) => CommonValidation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommonValidation.fromMap(Map<String, dynamic> json) => CommonValidation(
        cardNo: json["cardNo"] == null ? null : CardNoValidation.fromMap(json["cardNo"]),
        cardTypes: json["cardTypes"] == null ? null : List<CardTypeValidation>.from(json["cardTypes"].map((x) => CardTypeValidation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "cardNo": cardNo == null ? null : cardNo?.toMap(),
        "cardTypes": cardTypes == null ? null : List<dynamic>.from(cardTypes!.map((x) => x.toMap())),
      };
}

class CardNoValidation {
  CardNoValidation({
    this.prefixes,
    this.regex,
  });

  List<String>? prefixes;
  String? regex;

  factory CardNoValidation.fromJson(String str) => CardNoValidation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardNoValidation.fromMap(Map<String, dynamic> json) => CardNoValidation(
        prefixes: json["prefixes"] == null ? null : List<String>.from(json["prefixes"].map((x) => x)),
        regex: json["regex"] == null ? null : json["regex"],
      );

  Map<String, dynamic> toMap() => {
        "prefixes": prefixes == null ? null : List<dynamic>.from(prefixes!.map((x) => x)),
        "regex": regex == null ? null : regex,
      };
}

class CardTypeValidation {
  CardTypeValidation({
    this.sequenceNo,
    this.name,
    this.iconUrl,
    this.regex,
    this.prefixes,
  });

  int? sequenceNo;
  String? name;
  String? regex;
  String? iconUrl;
  List<String>? prefixes;

  factory CardTypeValidation.fromJson(String str) => CardTypeValidation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardTypeValidation.fromMap(Map<String, dynamic> json) => CardTypeValidation(
        sequenceNo: json["sequenceNo"] == null ? null : json["sequenceNo"],
        name: json["name"] == null ? null : json["name"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        regex: json["regex"] == null ? null : json["regex"],
        prefixes: json["prefixes"] == null ? null : List<String>.from(json["prefixes"].map((x) => x)),

        // defaults: json["defaults"] == null ? null : json["defaults"],
      );

  Map<String, dynamic> toMap() => {
        "sequenceNo": sequenceNo == null ? null : sequenceNo,
        "name": name == null ? null : name,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "regex": regex == null ? null : regex,
        "prefixes": prefixes == null ? null : List<dynamic>.from(prefixes!.map((x) => x)),
      };
}
