import 'dart:convert';

import 'package:pgw_sdk/models/payment_option/payment_option_response.dart';

class TransactionStatusResponse {
  TransactionStatusResponse({
    this.channelCode,
    this.invoiceNo,
    this.additionalInfo,
    this.responseCode,
    this.responseDescription,
  });

  String? channelCode;
  String? invoiceNo;
  TransactionStatusAdditionalInfo? additionalInfo;
  String? responseCode;
  String? responseDescription;

  factory TransactionStatusResponse.fromJson(String str) => TransactionStatusResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory TransactionStatusResponse.fromMap(Map<String, dynamic> json) => TransactionStatusResponse(
        channelCode: json["channelCode"] == null ? null : json["channelCode"],
        invoiceNo: json["invoiceNo"] == null ? null : json["invoiceNo"],
        additionalInfo: json["additionalInfo"] == null ? null : TransactionStatusAdditionalInfo.fromMap(json["additionalInfo"]),
        responseCode: json["responseCode"] == null ? null : json["responseCode"],
        responseDescription: json["responseDescription"] == null ? null : json["responseDescription"],
      );

  Map<String, dynamic> toMap() => {
        "channelCode": channelCode == null ? null : channelCode,
        "invoiceNo": invoiceNo == null ? null : invoiceNo,
        "additionalInfo": additionalInfo == null ? null : additionalInfo?.toMap(),
        "responseCode": responseCode == null ? null : responseCode,
        "responseDescription": responseDescription == null ? null : responseDescription,
      };
}

class TransactionStatusAdditionalInfo {
  TransactionStatusAdditionalInfo({
    this.merchantInfo,
    this.transactionInfo,
    this.resultInfo,
  });

  MerchantInfo? merchantInfo;
  TransactionAdditionalInfo? transactionInfo;
  PaymentResultAdditionalInfo? resultInfo;

  factory TransactionStatusAdditionalInfo.fromJson(String str) => TransactionStatusAdditionalInfo.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory TransactionStatusAdditionalInfo.fromMap(Map<String, dynamic> json) => TransactionStatusAdditionalInfo(
        merchantInfo: json["merchantInfo"] == null ? null : MerchantInfo.fromMap(json["merchantInfo"]),
        transactionInfo: json["transactionInfo"] == null ? null : TransactionAdditionalInfo.fromMap(json["transactionInfo"]),
        resultInfo: json["userInfo"] == null ? null : PaymentResultAdditionalInfo.fromMap(json["userInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "merchantInfo": merchantInfo == null ? null : merchantInfo?.toMap(),
        "transactionInfo": transactionInfo == null ? null : transactionInfo?.toMap(),
        "resultInfo": resultInfo == null ? null : resultInfo?.toMap(),
      };
}

class TransactionAdditionalInfo {
  TransactionAdditionalInfo({
    this.dateTime,
    this.agentCode,
    this.channelCode,
    this.data,
    this.interestType,
    this.interestRate,
    this.monthlyAmount,
    this.installmentPeriod,
    this.amount,
    this.currencyCode,
    this.invoiceNo,
    this.productDescription,
  });

  String? dateTime;
  String? agentCode;
  String? channelCode;
  String? data;
  String? interestType;
  String? interestRate;
  String? monthlyAmount;
  String? installmentPeriod;
  String? amount;
  String? currencyCode;
  String? invoiceNo;
  String? productDescription;

  factory TransactionAdditionalInfo.fromJson(String str) => TransactionAdditionalInfo.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory TransactionAdditionalInfo.fromMap(Map<String, dynamic> json) => TransactionAdditionalInfo(
        dateTime: json["dateTime"] == null ? null : json["dateTime"],
        agentCode: json["agentCode"] == null ? null : json["agentCode"],
        channelCode: json["channelCode"] == null ? null : json["channelCode"],
        data: json["data"] == null ? null : json["data"],
        interestType: json["interestType"] == null ? null : json["interestType"],
        interestRate: json["interestRate"] == null ? null : json["interestRate"],
        monthlyAmount: json["monthlyAmount"] == null ? null : json["monthlyAmount"],
        installmentPeriod: json["installmentPeriod"] == null ? null : json["installmentPeriod"],
        amount: json["amount"] == null ? null : json["amount"],
        currencyCode: json["currencyCode"] == null ? null : json["currencyCode"],
        invoiceNo: json["invoiceNo"] == null ? null : json["invoiceNo"],
        productDescription: json["productDescription"] == null ? null : json["productDescription"],
      );

  Map<String, dynamic> toMap() => {
        "dateTime": dateTime == null ? null : dateTime,
        "agentCode": agentCode == null ? null : agentCode,
        "channelCode": channelCode == null ? null : channelCode,
        "data": data == null ? null : data,
        "interestType": interestType == null ? null : interestType,
        "interestRate": interestRate == null ? null : interestRate,
        "monthlyAmount": monthlyAmount == null ? null : monthlyAmount,
        "installmentPeriod": installmentPeriod == null ? null : installmentPeriod,
        "amount": amount == null ? null : amount,
        "currencyCode": currencyCode == null ? null : currencyCode,
        "invoiceNo": invoiceNo == null ? null : invoiceNo,
        "productDescription": productDescription == null ? null : productDescription,
      };
}

class PaymentResultAdditionalInfo {
  PaymentResultAdditionalInfo({
    this.responseCode,
    this.responseDescription,
    this.autoRedirectTimer,
    this.frontendReturnUrl,
    this.frontendReturnData,
  });

  String? responseCode;
  String? responseDescription;
  String? autoRedirectTimer;
  String? frontendReturnUrl;
  String? frontendReturnData;

  factory PaymentResultAdditionalInfo.fromJson(String str) => PaymentResultAdditionalInfo.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory PaymentResultAdditionalInfo.fromMap(Map<String, dynamic> json) => PaymentResultAdditionalInfo(
        responseCode: json["code"] == null ? null : json["code"],
        responseDescription: json["description"] == null ? null : json["description"],
        autoRedirectTimer: json["autoRedirectTimer"] == null ? null : json["autoRedirectTimer"],
        frontendReturnUrl: json["frontendReturnUrl"] == null ? null : json["frontendReturnUrl"],
        frontendReturnData: json["frontendReturnData"] == null ? null : json["frontendReturnData"],
      );

  Map<String, dynamic> toMap() => {
        "code": responseCode == null ? null : responseCode,
        "description": responseDescription == null ? null : responseDescription,
        "autoRedirectTimer": autoRedirectTimer == null ? null : autoRedirectTimer,
        "frontendReturnUrl": frontendReturnUrl == null ? null : frontendReturnUrl,
        "frontendReturnData": frontendReturnData == null ? null : frontendReturnData,
      };
}
