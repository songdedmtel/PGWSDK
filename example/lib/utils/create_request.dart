import 'package:pgw_sdk/builder/card_payment_builder.dart';
import 'package:pgw_sdk/builder/digital_payment_builder.dart';
import 'package:pgw_sdk/builder/internet_banking_builder.dart';
import 'package:pgw_sdk/builder/pay_at_counter_builder.dart';
import 'package:pgw_sdk/builder/qr_payment_builder.dart';
import 'package:pgw_sdk/builder/self_service_machine_builder.dart';
import 'package:pgw_sdk/builder/web_payment_builder.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_request.dart';

enum PaymentChannelType {
  CREDIT_CARD,
  QR,
  WEBPAY,
  DPAY,
  COUNTER,
  SSM,
  IMBANK,

  GCASH,
  GRAB,
  TNG,
  TRUEMONEY,
  WAVE,
  OKDOLLAR,
  BOOST,
  PAYPAL,
  MPS,
  SPA,
  KPY,
  CBY,
  OVO,
  LINKAJA,
  MPASS,
  ALIPAY,
  KBZ,
}

class CreateRequest {
  CreateRequest._();
  static PaymentRequest? from(PaymentChannelType type) {
    switch (type) {
      case PaymentChannelType.CREDIT_CARD:
        var paymentCode = PaymentCode(channelCode: 'CC');
        return CardPaymentBuilder(paymentCode: paymentCode, cardNo: '4111111111111111')
            .setExpiryMonth(12)
            .setExpiryYear(2021)
            .setSecurityCode('123')
            .build();
      case PaymentChannelType.QR:
        var paymentCode = PaymentCode(channelCode: 'VEMVQR');
        return QRPaymentBuilder(paymentCode: paymentCode)
            .setType(QRTypeCode.url)
            .setName('DavidBilly')
            .setEmail('davidbilly@2c2p.com')
            .setMobileNo('08888888')
            .build();
      case PaymentChannelType.WEBPAY:
        var paymentCode = PaymentCode(channelCode: '123', agentCode: 'SCB', agentChannelCode: 'WEBPAY');
        return WebPaymentBuilder(paymentCode: paymentCode)
            .setName('DavidBilly')
            .setEmail('davidbilly@2c2p.com')
            .setMobileNo('08888888')
            .build();
      case PaymentChannelType.DPAY:
        var paymentCode = PaymentCode(channelCode: 'GRAB');
        return DigitalPaymentBuilder(paymentCode: paymentCode)
            .setName('DavidBilly')
            .setEmail('davidbilly@2c2p.com')
            .setAccountNo('0070000001')
            .build();
      case PaymentChannelType.COUNTER:
        var paymentCode = PaymentCode(channelCode: '123', agentCode: 'BIGC', agentChannelCode: 'OVERTHECOUNTER');
        return PayAtCounterBuilder(paymentCode: paymentCode)
            .setName('DavidBilly')
            .setEmail('davidbilly@2c2p.com')
            .setMobileNo('08888888')
            .build();
      case PaymentChannelType.SSM:
        var paymentCode = PaymentCode(channelCode: '123', agentCode: 'UOB', agentChannelCode: 'ATM');
        return SelfServiceMachineBuilder(paymentCode: paymentCode)
            .setName('DavidBilly')
            .setEmail('davidbilly@2c2p.com')
            .setMobileNo('08888888')
            .build();
      case PaymentChannelType.IMBANK:
        var paymentCode = PaymentCode(channelCode: '123', agentCode: 'UOB', agentChannelCode: 'IBANKING');
        return InternetBankingBuilder(paymentCode: paymentCode)
            .setName('DavidBilly')
            .setEmail('davidbilly@2c2p.com')
            .setMobileNo('08888888')
            .build();
    }
  }
}
