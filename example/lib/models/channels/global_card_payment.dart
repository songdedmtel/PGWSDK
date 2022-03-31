import 'package:pgw_sdk_example/models/enums/category_code.dart';
import 'package:pgw_sdk_example/models/enums/group_code.dart';
import 'package:pgw_sdk_example/models/payment_channel.dart';

List<PaymentChannel> globalCardPaymentList = [
  PaymentChannel(
    categoryCode: CategoryCode.GCARD,
    groupCode: GroupCode.CC,
    channelCode: 'CC',
    name: 'Visa',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.GCARD,
    groupCode: GroupCode.CC,
    channelCode: 'CC',
    name: 'Mastercard',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.GCARD,
    groupCode: GroupCode.CC,
    channelCode: 'CC',
    name: 'Amex',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.GCARD,
    groupCode: GroupCode.CC,
    channelCode: 'CC',
    name: 'JCB',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.GCARD,
    groupCode: GroupCode.CC,
    channelCode: 'CC',
    name: 'Diners',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.GCARD,
    groupCode: GroupCode.CC,
    channelCode: 'CC',
    name: 'Discover',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.GCARD,
    groupCode: GroupCode.CC,
    channelCode: 'CC',
    name: 'RUPAY',
  ),
];
