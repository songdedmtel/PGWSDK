import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_info.dart';
import 'package:pgw_sdk/models/payment_request.dart';

class WebPaymentBuilder extends PaymentInfo<WebPaymentBuilder> {
  WebPaymentBuilder({
    required PaymentCode paymentCode,
  }) : _paymentCode = paymentCode;

  WebPaymentBuilder.from({
    String? channelCode,
    String? agentCode,
    String? agentChannelCode,
  }) : _paymentCode = PaymentCode(
          channelCode: channelCode,
          agentCode: agentCode,
          agentChannelCode: agentChannelCode,
        );

  PaymentCode? _paymentCode;

  PaymentRequest build() {
    PaymentRequest request = PaymentRequest()
      ..code = _paymentCode
      ..data = this.buildData();
    return request;
  }
}
