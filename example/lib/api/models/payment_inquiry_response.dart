import 'dart:convert';

class PaymentInquiryResponse {
  PaymentInquiryResponse({
    this.merchantId,
    this.invoiceNo,
    this.amount,
    this.currencyCode,
    this.transactionDateTime,
    this.agentCode,
    this.channelCode,
    this.approvalCode,
    this.referenceNo,
    this.cardNo,
    this.cardToken,
    this.issuerCountry,
    this.eci,
    this.installmentPeriod,
    this.interestType,
    this.interestRate,
    this.installmentMerchantAbsorbRate,
    this.recurringUniqueId,
    this.fxAmount,
    this.fxRate,
    this.fxCurrencyCode,
    this.userDefined1,
    this.userDefined2,
    this.userDefined3,
    this.userDefined4,
    this.userDefined5,
    this.acquirerReferenceNo,
    this.acquirerMerchantId,
    this.cardType,
    this.idempotencyId,
    this.respCode,
    this.respDesc,
  });

  String? merchantId;
  String? invoiceNo;
  double? amount;
  String? currencyCode;
  String? transactionDateTime;
  String? agentCode;
  String? channelCode;
  String? approvalCode;
  String? referenceNo;
  String? cardNo;
  String? cardToken;
  String? issuerCountry;
  String? eci;
  int? installmentPeriod;
  String? interestType;
  double? interestRate;
  int? installmentMerchantAbsorbRate;
  String? recurringUniqueId;
  int? fxAmount;
  double? fxRate;
  String? fxCurrencyCode;
  String? userDefined1;
  String? userDefined2;
  String? userDefined3;
  String? userDefined4;
  String? userDefined5;
  String? acquirerReferenceNo;
  String? acquirerMerchantId;
  String? cardType;
  String? idempotencyId;
  String? respCode;
  String? respDesc;

  factory PaymentInquiryResponse.fromJson(String str) => PaymentInquiryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentInquiryResponse.fromMap(Map<String, dynamic> json) => PaymentInquiryResponse(
        merchantId: json["merchantID"] == null ? null : json["merchantID"],
        invoiceNo: json["invoiceNo"] == null ? null : json["invoiceNo"],
        amount: json["amount"] == null ? null : json["amount"],
        currencyCode: json["currencyCode"] == null ? null : json["currencyCode"],
        transactionDateTime: json["transactionDateTime"] == null ? null : json["transactionDateTime"],
        agentCode: json["agentCode"] == null ? null : json["agentCode"],
        channelCode: json["channelCode"] == null ? null : json["channelCode"],
        approvalCode: json["approvalCode"] == null ? null : json["approvalCode"],
        referenceNo: json["referenceNo"] == null ? null : json["referenceNo"],
        cardNo: json["cardNo"] == null ? null : json["cardNo"],
        cardToken: json["cardToken"] == null ? null : json["cardToken"],
        issuerCountry: json["issuerCountry"] == null ? null : json["issuerCountry"],
        eci: json["eci"] == null ? null : json["eci"],
        installmentPeriod: json["installmentPeriod"] == null ? null : json["installmentPeriod"],
        interestType: json["interestType"] == null ? null : json["interestType"],
        interestRate: json["interestRate"] == null ? null : json["interestRate"].toDouble(),
        installmentMerchantAbsorbRate: json["installmentMerchantAbsorbRate "] == null ? null : json["installmentMerchantAbsorbRate "],
        recurringUniqueId: json["recurringUniqueID"] == null ? null : json["recurringUniqueID"],
        fxAmount: json["fxAmount"] == null ? null : json["fxAmount"],
        fxRate: json["fxRate"] == null ? null : json["fxRate"].toDouble(),
        fxCurrencyCode: json["fxCurrencyCode"] == null ? null : json["fxCurrencyCode"],
        userDefined1: json["userDefined1"] == null ? null : json["userDefined1"],
        userDefined2: json["userDefined2"] == null ? null : json["userDefined2"],
        userDefined3: json["userDefined3"] == null ? null : json["userDefined3"],
        userDefined4: json["userDefined4"] == null ? null : json["userDefined4"],
        userDefined5: json["userDefined5"] == null ? null : json["userDefined5"],
        acquirerReferenceNo: json["acquirerReferenceNo"] == null ? null : json["acquirerReferenceNo"],
        acquirerMerchantId: json["acquirerMerchantId"] == null ? null : json["acquirerMerchantId"],
        cardType: json["cardType"] == null ? null : json["cardType"],
        idempotencyId: json["idempotencyID"] == null ? null : json["idempotencyID"],
        respCode: json["respCode"] == null ? null : json["respCode"],
        respDesc: json["respDesc"] == null ? null : json["respDesc"],
      );

  Map<String, dynamic> toMap() => {
        "merchantID": merchantId == null ? null : merchantId,
        "invoiceNo": invoiceNo == null ? null : invoiceNo,
        "amount": amount == null ? null : amount,
        "currencyCode": currencyCode == null ? null : currencyCode,
        "transactionDateTime": transactionDateTime == null ? null : transactionDateTime,
        "agentCode": agentCode == null ? null : agentCode,
        "channelCode": channelCode == null ? null : channelCode,
        "approvalCode": approvalCode == null ? null : approvalCode,
        "referenceNo": referenceNo == null ? null : referenceNo,
        "cardNo": cardNo == null ? null : cardNo,
        "cardToken": cardToken == null ? null : cardToken,
        "issuerCountry": issuerCountry == null ? null : issuerCountry,
        "eci": eci == null ? null : eci,
        "installmentPeriod": installmentPeriod == null ? null : installmentPeriod,
        "interestType": interestType == null ? null : interestType,
        "interestRate": interestRate == null ? null : interestRate,
        "installmentMerchantAbsorbRate ": installmentMerchantAbsorbRate == null ? null : installmentMerchantAbsorbRate,
        "recurringUniqueID": recurringUniqueId == null ? null : recurringUniqueId,
        "fxAmount": fxAmount == null ? null : fxAmount,
        "fxRate": fxRate == null ? null : fxRate,
        "fxCurrencyCode": fxCurrencyCode == null ? null : fxCurrencyCode,
        "userDefined1": userDefined1 == null ? null : userDefined1,
        "userDefined2": userDefined2 == null ? null : userDefined2,
        "userDefined3": userDefined3 == null ? null : userDefined3,
        "userDefined4": userDefined4 == null ? null : userDefined4,
        "userDefined5": userDefined5 == null ? null : userDefined5,
        "acquirerReferenceNo": acquirerReferenceNo == null ? null : acquirerReferenceNo,
        "acquirerMerchantId": acquirerMerchantId == null ? null : acquirerMerchantId,
        "cardType": cardType == null ? null : cardType,
        "idempotencyID": idempotencyId == null ? null : idempotencyId,
        "respCode": respCode == null ? null : respCode,
        "respDesc": respDesc == null ? null : respDesc,
      };
}
