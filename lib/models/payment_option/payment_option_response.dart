import 'dart:convert';

class PaymentOptionResponse {
  PaymentOptionResponse({
    this.paymentToken,
    this.merchantInfo,
    this.userInfo,
    this.channels,
    this.transactionInfo,
    this.configurationInfo,
    this.responseCode,
    this.responseDescription,
  });

  String? paymentToken;
  MerchantInfo? merchantInfo;
  UserInfo? userInfo;
  List<PaymentChannelCategory>? channels;
  TransactionInfo? transactionInfo;
  ConfigurationInfo? configurationInfo;
  String? responseCode;
  String? responseDescription;

  factory PaymentOptionResponse.fromJson(String str) => PaymentOptionResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory PaymentOptionResponse.fromMap(Map<String, dynamic> json) => PaymentOptionResponse(
        paymentToken: json["paymentToken"] == null ? null : json["paymentToken"],
        merchantInfo: json["merchantInfo"] == null ? null : MerchantInfo.fromMap(json["merchantInfo"]),
        userInfo: json["userInfo"] == null ? null : UserInfo.fromMap(json["userInfo"]),
        channels: json["channels"] == null
            ? null
            : List<PaymentChannelCategory>.from(json["channels"].map((x) => PaymentChannelCategory.fromMap(x))),
        transactionInfo: json["transactionInfo"] == null ? null : TransactionInfo.fromMap(json["transactionInfo"]),
        configurationInfo:
            json["configurationInfo"] == null ? null : ConfigurationInfo.fromMap(json["configurationInfo"]),
        responseCode: json["responseCode"] == null ? null : json["responseCode"],
        responseDescription: json["responseDescription"] == null ? null : json["responseDescription"],
      );

  Map<String, dynamic> toMap() => {
        "paymentToken": paymentToken == null ? null : paymentToken,
        "merchantInfo": merchantInfo == null ? null : merchantInfo?.toMap(),
        "userInfo": userInfo == null ? null : userInfo?.toMap(),
        "channels": channels == null ? null : List<dynamic>.from(channels!.map((x) => x.toMap())),
        "transactionInfo": transactionInfo == null ? null : transactionInfo?.toMap(),
        "configurationInfo": configurationInfo == null ? null : configurationInfo?.toMap(),
        "responseCode": responseCode == null ? null : responseCode,
        "responseDescription": responseDescription == null ? null : responseDescription,
      };
}

class MerchantInfo {
  MerchantInfo({
    this.id,
    this.name,
    this.address,
    this.email,
    this.logoUrl,
    this.bannerUrl,
  });

  String? id;
  String? name;
  String? address;
  String? email;
  String? logoUrl;
  String? bannerUrl;

  factory MerchantInfo.fromJson(String str) => MerchantInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MerchantInfo.fromMap(Map<String, dynamic> json) => MerchantInfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        email: json["email"] == null ? null : json["email"],
        logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
        bannerUrl: json["bannerUrl"] == null ? null : json["bannerUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "email": email == null ? null : email,
        "logoUrl": logoUrl == null ? null : logoUrl,
        "bannerUrl": bannerUrl == null ? null : bannerUrl,
      };
}

class UserInfo {
  UserInfo({
    this.userAddress,
  });

  UserAddress? userAddress;

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        userAddress: json["userAddress"] == null ? null : UserAddress.fromMap(json["userAddress"]),
      );

  Map<String, dynamic> toMap() => {
        "userAddress": userAddress == null ? null : userAddress?.toMap(),
      };
}

class UserAddress {
  UserAddress({
    this.userBillingAddress,
  });
  UserBillingAddress? userBillingAddress;

  factory UserAddress.fromJson(String str) => UserAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserAddress.fromMap(Map<String, dynamic> json) => UserAddress(
        userBillingAddress:
            json["userBillingAddress"] == null ? null : UserBillingAddress.fromMap(json["userBillingAddress"]),
      );

  Map<String, dynamic> toMap() => {
        "userBillingAddress": userBillingAddress == null ? null : userBillingAddress?.toMap(),
      };
}

class UserBillingAddress {
  UserBillingAddress({
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.state,
    this.postalCode,
    this.countryCode,
  });

  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? state;
  String? postalCode;
  String? countryCode;

  factory UserBillingAddress.fromJson(String str) => UserBillingAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserBillingAddress.fromMap(Map<String, dynamic> json) => UserBillingAddress(
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        address3: json["address3"] == null ? null : json["address3"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        postalCode: json["postalCode"] == null ? null : json["postalCode"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
      );

  Map<String, dynamic> toMap() => {
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "address3": address3 == null ? null : address3,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "postalCode": postalCode == null ? null : postalCode,
        "countryCode": countryCode == null ? null : countryCode,
      };
}

class PaymentChannelCategory {
  PaymentChannelCategory({
    this.sequenceNo,
    this.name,
    this.code,
    this.iconUrl,
    this.logoUrl,
    this.groups,
  });

  int? sequenceNo;
  String? name;
  String? code;
  String? iconUrl;
  String? logoUrl;
  List<PaymentChannelGroup>? groups;

  factory PaymentChannelCategory.fromJson(String str) => PaymentChannelCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentChannelCategory.fromMap(Map<String, dynamic> json) => PaymentChannelCategory(
        sequenceNo: json["sequenceNo"] == null ? null : json["sequenceNo"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
        groups: json["groups"] == null
            ? null
            : List<PaymentChannelGroup>.from(json["groups"].map((x) => PaymentChannelGroup.fromMap(x))),

        // defaults: json["defaults"] == null ? null : json["defaults"],
      );

  Map<String, dynamic> toMap() => {
        "sequenceNo": sequenceNo == null ? null : sequenceNo,
        "name": name == null ? null : name,
        "code": code == null ? null : code,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "logoUrl": logoUrl == null ? null : logoUrl,
        "groups": groups == null ? null : List<dynamic>.from(groups!.map((x) => x.toMap())),
      };
}

class PaymentChannelGroup {
  PaymentChannelGroup({
    this.sequenceNo,
    this.name,
    this.code,
    this.iconUrl,
    this.logoUrl,
    // this.defaults,
  });
  int? sequenceNo;
  String? name;
  String? code;
  String? iconUrl;
  String? logoUrl;
  // bool? defaults;

  factory PaymentChannelGroup.fromJson(String str) => PaymentChannelGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentChannelGroup.fromMap(Map<String, dynamic> json) => PaymentChannelGroup(
        sequenceNo: json["sequenceNo"] == null ? null : json["sequenceNo"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
        // defaults: json["defaults"] == null ? null : json["defaults"],
      );

  Map<String, dynamic> toMap() => {
        "sequenceNo": sequenceNo == null ? null : sequenceNo,
        "name": name == null ? null : name,
        "code": code == null ? null : code,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "logoUrl": logoUrl == null ? null : logoUrl,
        // "defaults": defaults == null ? null : defaults,
      };
}

class TransactionInfo {
  TransactionInfo({
    this.amount,
    this.currencyCode,
    this.invoiceNo,
    this.productDescription,
    this.recurring,
    this.paymentItemInfo,
  });

  String? amount;
  String? currencyCode;
  String? invoiceNo;
  String? productDescription;
  RecurringInfo? recurring;
  List<PaymentItemInfo>? paymentItemInfo;

  factory TransactionInfo.fromJson(String str) => TransactionInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionInfo.fromMap(Map<String, dynamic> json) => TransactionInfo(
        amount: json["amount"] == null ? null : json["amount"],
        currencyCode: json["currencyCode"] == null ? null : json["currencyCode"],
        invoiceNo: json["invoiceNo"] == null ? null : json["invoiceNo"],
        productDescription: json["productDescription"] == null ? null : json["productDescription"],
        recurring: json["recurring"] == null ? null : RecurringInfo.fromMap(json["recurring"]),
        paymentItemInfo: json["paymentItemInfo"] == null
            ? null
            : List<PaymentItemInfo>.from(json["paymentItemInfo"].map((x) => PaymentItemInfo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "amount": amount == null ? null : amount,
        "currencyCode": currencyCode == null ? null : currencyCode,
        "invoiceNo": invoiceNo == null ? null : invoiceNo,
        "productDescription": productDescription == null ? null : productDescription,
        "recurring": recurring == null ? null : recurring?.toMap(),
        "paymentItemInfo": paymentItemInfo == null ? null : List<dynamic>.from(paymentItemInfo!.map((x) => x.toMap())),
      };
}

class RecurringInfo {
  RecurringInfo({
    this.amount,
    this.interval,
    this.count,
    this.chargeNextDate,
    this.chargeOnDate,
  });

  String? amount;
  int? interval;
  int? count;
  String? chargeNextDate;
  String? chargeOnDate;

  factory RecurringInfo.fromJson(String str) => RecurringInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecurringInfo.fromMap(Map<String, dynamic> json) => RecurringInfo(
        amount: json["amount"] == null ? null : json["amount"],
        interval: json["interval"] == null ? null : json["interval"],
        count: json["count"] == null ? null : json["count"],
        chargeNextDate: json["chargeNextDate"] == null ? null : json["chargeNextDate"],
        chargeOnDate: json["chargeOnDate"] == null ? null : json["chargeOnDate"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount == null ? null : amount,
        "interval": interval == null ? null : interval,
        "count": count == null ? null : count,
        "chargeNextDate": chargeNextDate == null ? null : chargeNextDate,
        "chargeOnDate": chargeOnDate == null ? null : chargeOnDate,
      };
}

class PaymentItemInfo {
  PaymentItemInfo({
    this.code,
    this.name,
    this.quantity,
    this.price,
  });

  String? code;
  String? name;
  int? quantity;
  double? price;

  factory PaymentItemInfo.fromJson(String str) => PaymentItemInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentItemInfo.fromMap(Map<String, dynamic> json) => PaymentItemInfo(
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
      };
}

class ConfigurationInfo {
  ConfigurationInfo({
    this.payment,
    this.notification,
  });

  PaymentConfiguration? payment;
  PaymentNotification? notification;

  factory ConfigurationInfo.fromJson(String str) => ConfigurationInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConfigurationInfo.fromMap(Map<String, dynamic> json) => ConfigurationInfo(
        payment: json["payment"] == null ? null : PaymentConfiguration.fromMap(json["payment"]),
        notification: json["notification"] == null ? null : PaymentNotification.fromMap(json["notification"]),
      );

  Map<String, dynamic> toMap() => {
        "payment": payment == null ? null : payment?.toMap(),
        "notification": notification == null ? null : notification?.toMap(),
      };
}

class PaymentConfiguration {
  PaymentConfiguration({
    this.immediatePayment,
    this.tokenize,
    this.tokenizeOnly,
    this.cardTokenOnly,
  });

  bool? immediatePayment;
  bool? tokenize;
  bool? tokenizeOnly;
  bool? cardTokenOnly;

  factory PaymentConfiguration.fromJson(String str) => PaymentConfiguration.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentConfiguration.fromMap(Map<String, dynamic> json) => PaymentConfiguration(
        immediatePayment: json["immediatePayment"] == null ? null : json["immediatePayment"],
        tokenize: json["tokenize"] == null ? null : json["tokenize"],
        tokenizeOnly: json["tokenizeOnly"] == null ? null : json["tokenizeOnly"],
        cardTokenOnly: json["cardTokenOnly"] == null ? null : json["cardTokenOnly"],
      );

  Map<String, dynamic> toMap() => {
        "immediatePayment": immediatePayment == null ? null : immediatePayment,
        "tokenize": tokenize == null ? null : tokenize,
        "tokenizeOnly": tokenizeOnly == null ? null : tokenizeOnly,
        "cardTokenOnly": cardTokenOnly == null ? null : cardTokenOnly,
      };
}

class PaymentNotification {
  PaymentNotification({
    this.facebook,
    this.whatsApp,
    this.line,
  });

  bool? facebook;
  bool? whatsApp;
  bool? line;

  factory PaymentNotification.fromJson(String str) => PaymentNotification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentNotification.fromMap(Map<String, dynamic> json) => PaymentNotification(
        facebook: json["facebook"] == null ? null : json["facebook"],
        whatsApp: json["whatsApp"] == null ? null : json["whatsApp"],
        line: json["line"] == null ? null : json["line"],
      );

  Map<String, dynamic> toMap() => {
        "facebook": facebook == null ? null : facebook,
        "whatsApp": whatsApp == null ? null : whatsApp,
        "line": line == null ? null : line,
      };
}

class ExchangeRate {
  ExchangeRate({
    this.multipleCurrencyPricing,
    this.dynamicCurrencyConversion,
    this.alternativePaymentMethodMultipleCurrencyConversion,
  });

  MultipleCurrencyPricing? multipleCurrencyPricing;
  DynamicCurrencyConversion? dynamicCurrencyConversion;
  AlternativePaymentMethodMultipleCurrencyConversion? alternativePaymentMethodMultipleCurrencyConversion;

  factory ExchangeRate.fromJson(String str) => ExchangeRate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExchangeRate.fromMap(Map<String, dynamic> json) => ExchangeRate(
        multipleCurrencyPricing:
            json["mcp"] == null ? null : ExchangeRate.fromMap(json["mcp"]) as MultipleCurrencyPricing,
        dynamicCurrencyConversion:
            json["dcc"] == null ? null : ExchangeRate.fromMap(json["dcc"]) as DynamicCurrencyConversion,
        alternativePaymentMethodMultipleCurrencyConversion: json["apmMcc"] == null
            ? null
            : ExchangeRate.fromMap(json["apmMcc"]) as AlternativePaymentMethodMultipleCurrencyConversion,
      );

  Map<String, dynamic> toMap() => {
        "mcp": multipleCurrencyPricing ?? null,
        "dcc": dynamicCurrencyConversion ?? null,
        "apmMcc": alternativePaymentMethodMultipleCurrencyConversion ?? null,
      };
}

class MultipleCurrencyPricing extends BaseExchangeRate {}

class DynamicCurrencyConversion extends BaseExchangeRate {}

class AlternativePaymentMethodMultipleCurrencyConversion extends BaseExchangeRate {}

class BaseExchangeRate {
  BaseExchangeRate({
    this.active,
    this.terms,
  });

  bool? active;
  String? terms;

  factory BaseExchangeRate.fromJson(String str) => BaseExchangeRate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static fromMap(Map<String, dynamic> json) => BaseExchangeRate(
        active: json["active"] == null ? null : json["active"],
        terms: json["terms"] == null ? null : json["terms"],
      );

  Map<String, dynamic> toMap() => {
        "active": active == null ? null : active,
        "terms": terms == null ? null : terms,
      };
}
