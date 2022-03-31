import 'package:pgw_sdk_example/models/enums/agent_channel_code.dart';
import 'package:pgw_sdk_example/models/enums/country_code.dart';
import 'package:pgw_sdk_example/models/enums/group_code.dart';

import 'enums/category_code.dart';

class PaymentChannel {
  CategoryCode categoryCode;
  GroupCode groupCode;
  String channelCode;
  String name;
  AgentChannelCode? agentChannelCode;
  String? agentCode;
  CountryCode? countryCode;
  String? logo;

  PaymentChannel({
    required this.categoryCode,
    required this.groupCode,
    required this.channelCode,
    required this.name,
    this.agentChannelCode,
    this.agentCode,
    this.countryCode,
    this.logo,
  });
  @override
  String toString() {
    // TODO: implement toString
    String formatPaymentChannel = '${this.categoryCode.toString().split('.').last}: ${this.name}';

    return formatPaymentChannel;
  }
}
