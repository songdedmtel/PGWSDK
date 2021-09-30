/*
 * Created by Nonthawatt Phongwittayapanu on 21/9/21 1:20 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

class PaymentCode {
  PaymentCode({
    this.channelCode,
    this.agentCode,
    this.agentChannelCode,
  });

  String? channelCode;
  String? agentCode;
  String? agentChannelCode;

  factory PaymentCode.fromJson(String str) => PaymentCode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentCode.fromMap(Map<String, dynamic> json) => PaymentCode(
        channelCode: json["channelCode"] == null ? null : json["channelCode"],
        agentCode: json["agentCode"] == null ? null : json["agentCode"],
        agentChannelCode: json["agentChannelCode"] == null ? null : json["agentChannelCode"],
      );

  Map<String, dynamic> toMap() => {
        "channelCode": channelCode == null ? null : channelCode,
        "agentCode": agentCode == null ? null : agentCode,
        "agentChannelCode": agentChannelCode == null ? null : agentChannelCode,
      };
}
