import 'package:pgw_sdk_example/models/enums/category_code.dart';
import 'package:pgw_sdk_example/models/enums/country_code.dart';
import 'package:pgw_sdk_example/models/enums/group_code.dart';
import 'package:pgw_sdk_example/models/payment_channel.dart';

List<PaymentChannel> qrPaymentList = [
  PaymentChannel(
    categoryCode: CategoryCode.QR,
    groupCode: GroupCode.QRC,
    channelCode: 'GIPQR',
    name: 'GIP QR',
    countryCode: CountryCode.TH,
  ),
  PaymentChannel(
    categoryCode: CategoryCode.QR,
    groupCode: GroupCode.QRC,
    channelCode: 'DOLFINQR',
    name: 'Dolfin QR',
    countryCode: CountryCode.TH,
    logo: 'logo_dolfin.png',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.QR,
    groupCode: GroupCode.THQR,
    channelCode: 'PPQR',
    name: 'Prompt Pay QR',
    countryCode: CountryCode.TH,
    logo: 'logo_prompt_pay.png',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.QR,
    groupCode: GroupCode.THQR,
    channelCode: 'GPTHQR',
    name: 'GrabPay TH QR',
    countryCode: CountryCode.TH,
    logo: 'logo_grabpay.png',
  ),
  PaymentChannel(
    categoryCode: CategoryCode.QR,
    groupCode: GroupCode.THQR,
    channelCode: 'APQR',
    name: 'AirPay QR (ShopeePay QR)',
    countryCode: CountryCode.TH,
    logo: 'logo_airpay.png',
  ),
];
