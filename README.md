# PGWSDK for Flutter

A PGW SDK Flutter project.

## Getting Started

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  pgw_sdk: ^0.0.2
```

## System Requirements

The SDK has been developed using `Dart version >=2.12.0`, `iOS Deployment Target 12.0`, and `Android Version 6 (API Level 23)`. To ensure you can actually compile the sdk smoothly, we recommend to use the developed versions. However if needed, you can convert to your preferred version.

| Platform | Minimum Version |
| :-----: | :-----: |
| iOS | 11.0 |
| Android | 6 (API Level 23) | 
| Dart SDK | 2.12.0 | 


## Initialize

Add initialize to your main.dart file

```dart
PGWSDK.initialize(APIEnvironment.Production);
```

** Change to `APIEnvironment.Sandbox` if test needed. For more information follow this [link](https://developer.2c2p.com/docs/sandbox)

## Usage

Import the library to your file

```dart
import 'package:pgw_sdk/builder/card_payment_builder.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
```

After get payment token from merchant server then construct transaction request
```dart
var paymentCode = PaymentCode(channelCode: 'CC');
var paymentRequest = CardPaymentBuilder(paymentCode: paymentCode, cardNo: '4111111111111111')
    .setExpiryMonth(12)
    .setExpiryYear(2021)
    .setSecurityCode('123')
    .build();

var request = TransactionResultRequestBuilder(
  paymentToken: 'PAYMENT_TOKEN',
  paymentRequest: paymentRequest,
);
```

Execute Payment Request
```dart
var result = await PGWSDK.proceedTransaction(request);
var redirectUrl = result.data;
```
Finally got a redirect url from result.

2c2p supported a list of payment methods. Refer to this [link](https://developer.2c2p.com/docs/sdk-payment-methods)

For more information click [here](https://developer.2c2p.com/docs/sdk-how-to-integrate)

## Contributing
2C2P

## License
[MIT](/LICENSE)