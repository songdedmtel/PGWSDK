import 'package:pgw_sdk_example/models/enums/agent_channel_code.dart';
import 'package:pgw_sdk_example/models/enums/category_code.dart';
import 'package:pgw_sdk_example/models/enums/country_code.dart';
import 'package:pgw_sdk_example/models/enums/group_code.dart';
import 'package:pgw_sdk_example/models/payment_channel.dart';

List<PaymentChannel> internetBankingList = [
  PaymentChannel(
    categoryCode: CategoryCode.IMBANK,
    groupCode: GroupCode.IBANK,
    channelCode: '123',
    agentCode: 'BAY',
    agentChannelCode: AgentChannelCode.IBANKING,
    name: 'Bank of Ayudhya (Krungsri)',
    countryCode: CountryCode.TH,
    logo: 'logo_krungsri.png',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.IMBANK,
    groupCode: GroupCode.IBANK,
    channelCode: '123',
    agentCode: 'BBL',
    agentChannelCode: AgentChannelCode.IBANKING,
    name: 'Bangkok Bank',
    countryCode: CountryCode.TH,
    logo: 'logo_bangkok_bank.png',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.IMBANK,
    groupCode: GroupCode.IBANK,
    channelCode: '123',
    agentCode: 'KTB',
    agentChannelCode: AgentChannelCode.IBANKING,
    name: 'Krung Thai Bank',
    countryCode: CountryCode.TH,
    logo: 'logo_krungthai.jpeg',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.IMBANK,
    groupCode: GroupCode.IBANK,
    channelCode: '123',
    agentCode: 'SCB',
    agentChannelCode: AgentChannelCode.IBANKING,
    name: 'Siam Commercial Bank',
    countryCode: CountryCode.TH,
    logo: 'logo_scb.jpeg',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.IMBANK,
    groupCode: GroupCode.IBANK,
    channelCode: '123',
    agentCode: 'UOB',
    agentChannelCode: AgentChannelCode.IBANKING,
    name: 'United Overseas Bank',
    countryCode: CountryCode.TH,
    logo: 'logo_uob.png',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.IMBANK,
    groupCode: GroupCode.IBANK,
    channelCode: '123',
    agentCode: 'KBANK',
    agentChannelCode: AgentChannelCode.IBANKING,
    name: 'Kasikorn Bank',
    countryCode: CountryCode.TH,
    logo: 'logo_kasikorn.jpeg',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.IMBANK,
    groupCode: GroupCode.IBANK,
    channelCode: '123',
    agentCode: 'CIMB',
    agentChannelCode: AgentChannelCode.IBANKING,
    name: 'CIMB Thai Bank',
    countryCode: CountryCode.TH,
    logo: 'logo_cimb.png',
  ),
];
