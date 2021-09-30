import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_data.dart';
import 'package:pgw_sdk/models/payment_info.dart';
import 'package:pgw_sdk/models/payment_request.dart';

class DigitalPaymentBuilder extends PaymentInfo<DigitalPaymentBuilder> {
  DigitalPaymentBuilder({required PaymentCode paymentCode}) : _paymentCode = paymentCode;

  DigitalPaymentBuilder.from({required String channelCode}) : _paymentCode = PaymentCode(channelCode: channelCode);

  PaymentCode? _paymentCode;
  String? _accountNo;
  String? _token;

  DigitalPaymentBuilder setAccountNo(String accountNo) {
    this._accountNo = accountNo;
    return this;
  }

  DigitalPaymentBuilder setToken(String token) {
    this._token = token;
    return this;
  }

  PaymentRequest build() {
    PaymentData data = this.buildData()
      ..accountNo = _accountNo
      ..token = _token;
    PaymentRequest request = PaymentRequest()
      ..code = _paymentCode
      ..data = data;
    return request;
  }
}
