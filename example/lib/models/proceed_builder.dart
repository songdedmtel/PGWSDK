import 'package:pgw_sdk_example/models/enums/payment_method_type.dart';
import 'package:pgw_sdk_example/models/enums/sdk_api_type.dart';

class ProceedBuilder {
  ProceedBuilder({
    required this.paymentMethod,
    required this.sdkapiType,
  });

  final PaymentMethodType paymentMethod;
  final SDKAPIType sdkapiType;
}
