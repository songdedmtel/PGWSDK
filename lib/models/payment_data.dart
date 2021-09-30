/*
 * Created by Nonthawatt Phongwittayapanu on 21/9/21 4:20 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

class PaymentData {
  PaymentData({
    this.name,
    this.email,
    this.mobileNo,
    this.accountNo,
    this.cardNo,
    this.expiryMonth,
    this.expiryYear,
    this.securityCode,
    this.pin,
    this.cardBank,
    this.cardCountry,
    this.cardTokenize,
    this.interestType,
    this.installmentPeriod,
    this.token,
    this.qrType,
    this.fxRateId,
    this.billingAddress1,
    this.billingAddress2,
    this.billingAddress3,
    this.billingCity,
    this.billingState,
    this.billingPostalCode,
    this.billingCountryCode,
  });

  String? name;
  String? email;
  String? mobileNo;
  String? accountNo;
  String? cardNo;
  int? expiryMonth;
  int? expiryYear;
  String? securityCode;
  String? pin;
  String? cardBank;
  String? cardCountry;
  bool? cardTokenize;
  String? interestType;
  int? installmentPeriod;
  String? token;
  String? qrType;
  String? fxRateId;
  String? billingAddress1;
  String? billingAddress2;
  String? billingAddress3;
  String? billingCity;
  String? billingState;
  String? billingPostalCode;
  String? billingCountryCode;

  factory PaymentData.fromJson(String str) => PaymentData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentData.fromMap(Map<String, dynamic> json) => PaymentData(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        mobileNo: json["mobileNo"] == null ? null : json["mobileNo"],
        accountNo: json["accountNo"] == null ? null : json["accountNo"],
        cardNo: json["cardNo"] == null ? null : json["cardNo"],
        expiryMonth: json["expiryMonth"] == null ? null : json["expiryMonth"],
        expiryYear: json["expiryYear"] == null ? null : json["expiryYear"],
        securityCode: json["securityCode"] == null ? null : json["securityCode"],
        pin: json["pin"] == null ? null : json["pin"],
        cardBank: json["cardBank"] == null ? null : json["cardBank"],
        cardCountry: json["cardCountry"] == null ? null : json["cardCountry"],
        cardTokenize: json["cardTokenize"] == null ? null : json["cardTokenize"],
        interestType: json["interestType"] == null ? null : json["interestType"],
        installmentPeriod: json["installmentPeriod"] == null ? null : json["installmentPeriod"],
        token: json["token"] == null ? null : json["token"],
        qrType: json["qrType"] == null ? null : json["qrType"],
        fxRateId: json["fxRateID"] == null ? null : json["fxRateID"],
        billingAddress1: json["billingAddress1"] == null ? null : json["billingAddress1"],
        billingAddress2: json["billingAddress2"] == null ? null : json["billingAddress2"],
        billingAddress3: json["billingAddress3"] == null ? null : json["billingAddress3"],
        billingCity: json["billingCity"] == null ? null : json["billingCity"],
        billingState: json["billingState"] == null ? null : json["billingState"],
        billingPostalCode: json["billingPostalCode"] == null ? null : json["billingPostalCode"],
        billingCountryCode: json["billingCountryCode"] == null ? null : json["billingCountryCode"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "mobileNo": mobileNo == null ? null : mobileNo,
        "accountNo": accountNo == null ? null : accountNo,
        "cardNo": cardNo == null ? null : cardNo,
        "expiryMonth": expiryMonth == null ? null : expiryMonth,
        "expiryYear": expiryYear == null ? null : expiryYear,
        "securityCode": securityCode == null ? null : securityCode,
        "pin": accountNo == null ? null : pin,
        "cardBank": cardBank == null ? null : cardBank,
        "cardCountry": cardCountry == null ? null : cardCountry,
        "cardTokenize": cardTokenize == null ? null : cardTokenize,
        "interestType": interestType == null ? null : interestType,
        "installmentPeriod": installmentPeriod == null ? null : installmentPeriod,
        "token": token == null ? null : token,
        "qrType": qrType == null ? null : qrType,
        "fxRateID": fxRateId == null ? null : fxRateId,
        "billingAddress1": billingAddress1 == null ? null : billingAddress1,
        "billingAddress2": billingAddress2 == null ? null : billingAddress2,
        "billingAddress3": billingAddress3 == null ? null : billingAddress3,
        "billingCity": billingCity == null ? null : billingCity,
        "billingState": billingState == null ? null : billingState,
        "billingPostalCode": billingPostalCode == null ? null : billingPostalCode,
        "billingCountryCode": billingCountryCode == null ? null : billingCountryCode,
      };
}
