import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_data.dart';
import 'package:pgw_sdk/models/payment_info.dart';
import 'package:pgw_sdk/models/payment_request.dart';

class QRPaymentBuilder extends PaymentInfo<QRPaymentBuilder> {
  QRPaymentBuilder({
    required PaymentCode paymentCode,
  }) : _paymentCode = paymentCode;

  PaymentCode? _paymentCode;
  String _type = QRTypeCode.url;

  QRPaymentBuilder setType(String type) {
    this._type = type;
    return this;
  }

  PaymentRequest build() {
    PaymentData data = this.buildData()..qrType = _type;
    PaymentRequest request = PaymentRequest()
      ..code = _paymentCode
      ..data = data;
    return request;
  }
}

class QRTypeCode {
  QRTypeCode._();
  static String raw = "RAW";
  static String base64 = "BASE64";
  static String url = "URL";
}
