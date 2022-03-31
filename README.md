# PGW SDK

The **2C2P Payment Gateway (PGW) SDK** allows merchants to build an excellent payment experience within their mobile apps by integrating easily with 2C2P's payment gateway. As 2C2P provides omnichannel payment processing, the Payment Gateway SDK gives merchants access to a full suite of payment options.

With 2C2P's Payment Gateway SDK, merchants do not need to undertake a complex and time-consuming PCI-DSS certification process. All sensitive information is protected at 2C2P with the most advanced security that is compliant with PCI-DSS standards. 
## Table of Contents

1. [Getting Started](#getting-started)
2. [System Requirements](#system-requirements)
3. [Initializing the PGW SDK](#initializing-the-pgw-sdk)
4. [Payment Methods](#payment-methods)
   * [Credit or Debit Card](#credit-or-debit-card)
   * [Internet Banking](#internet-banking)
   * [QR Payment](#qr-payment)
   * [Over the Counter](#over-the-counter)
5. [Constructing Transaction Requests](#constructing-transaction-requests)
6. [Executing Transactions](#executing-transactions)
   * [Payment with Card Token](#payment-with-card-token)
   * [Proceed Transaction](#proceed-transaction) 

## Getting Started

Add this to your package's pubspec.yaml file:
```yaml
dependencies:
  pgw_sdk: ^0.0.3
```

## System Requirements

The SDK has been developed using `Dart version >=2.12.0`, `iOS Deployment Target 12.0`, and `Android Version 6 (API Level 23)`. To ensure you can actually compile the sdk smoothly, we recommend to use the developed versions. However if needed, you can convert to your preferred version.

| Platform | Minimum Version |
| :-----: | :-----: |
| iOS | 11.0 |
| Android | 6 (API Level 23) | 
| Dart SDK | 2.12.0 |

## Initializing the PGW SDK

Merchants must initialize the 2C2P PGW SDK in their main.dart file before performing any payment transactions. To do so, refer to the sample code below.

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PGWSDK.initialize(APIEnvironment.Production);
  runApp(...);
}
```
** For testing purposes, use `APIEnvironment.Sandbox` to initialize the PGW SDK. For more info, please refer to this [link](https://developer.2c2p.com/docs/sandbox).

## Payment Methods

### Credit or Debit Card
Import the following libraries into your file:
```dart
import 'package:pgw_sdk/builder/card_payment_builder.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_request.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
```
\
Prepare a payment token request by referring to the guidelines [here](https://developer.2c2p.com/docs/api-payment-token).
```json
{
  "merchantID": "JT04",
  "invoiceNo": "1595219400",
  "description": "2 days 1 night hotel room",
  "amount": 10.0,
  "currencyCode": "THB",
  "nonceStr": "a8092512-b144-41b0-8284-568bb5e9264c",
  "paymentChannel": ["GCARD"],
  "request3DS" : "Y"
}
```
\
The payment token API will return response data that will contain the payment token ID which must be passed to the merchant application:
```dart
String paymentToken = "roZG9I1hk/GYjNt+BYPYbxQtKElbZDs9M5cXuEbE+Z0QTr/yUcl1oG7t0AGoOJlBhzeyBtf5mQi1UqGbjC66E85S4m63CfV/awwNbbLbkxsvfgzn0KSv7JzH3gcs/OIL";
```
\
Construct payment request and payment code: 
```dart
PaymentCode paymentCode = PaymentCode(channelCode: 'CC');
PaymentRequest paymentRequest = CardPaymentBuilder(paymentCode: paymentCode, cardNo: '4111111111111111')
    .setExpiryMonth(12)
    .setExpiryYear(2021)
    .setSecurityCode('123')
    .build();
```
\
Use the payment token, payment code, and payment request to build a [transaction request](#payment-with-card-token), which can be used to execute the transaction using [card token payment](#payment-with-card-token).

### Internet Banking
Import the following libraries into your file:
```dart
import 'package:pgw_sdk/builder/internet_banking_builder.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_request.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
```
\
Prepare a payment token request by referring to the guidelines [here](https://developer.2c2p.com/docs/api-payment-token).
```json
{
  "merchantID": "JT04",
  "invoiceNo": "1595219400",
  "description": "2 days 1 night hotel room",
  "amount": 10.0,
  "currencyCode": "THB",
  "nonceStr": "a8092512-b144-41b0-8284-568bb5e9264c",
  "paymentChannel": ["IMBANK"]
}

```
\
The payment token API will return response data that will contain the payment token ID which must be passed to the merchant application:
```dart
String paymentToken = "roZG9I1hk/GYjNt+BYPYbxQtKElbZDs9M5cXuEbE+Z0QTr/yUcl1oG7t0AGoOJlBhzeyBtf5mQi1UqGbjC66E85S4m63CfV/awwNbbLbkxsvfgzn0KSv7JzH3gcs/OIL";
```
\
Construct payment request and payment code:
```dart
PaymentCode paymentCode = new PaymentCode("123", "UOB", "IBANKING");
PaymentRequest paymentRequest = new InternetBankingBuilder(paymentCode)
    .setName("DavidBilly")
    .setEmail("davidbilly@2c2p.com")
    .setMobileNo("08888888")
    .build();

```
\
Use the payment token, payment code, and payment request to build a [transaction request](#constructing-transaction-requests), which can be used to execute the transaction by calling [proceed transaction](#payment-with-card-token).

### QR Payment 

Import the following libraries into your file:
```dart
import 'package:pgw_sdk/builder/qr_payment_builder.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_request.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
```
\
Prepare a payment token request by referring to the guidelines [here](https://developer.2c2p.com/docs/api-payment-token).
```json
{
  "merchantID": "JT04",
  "invoiceNo": "1595219400",
  "description": "2 days 1 night hotel room",
  "amount": 10.0,
  "currencyCode": "THB",
  "nonceStr": "a8092512-b144-41b0-8284-568bb5e9264c",
  "paymentChannel": ["QR"]
}
```
\
The payment token API will return response data that will contain the payment token ID which must be passed to the merchant application:
```dart
String paymentToken = "roZG9I1hk/GYjNt+BYPYbxQtKElbZDs9M5cXuEbE+Z0QTr/yUcl1oG7t0AGoOJlBhzeyBtf5mQi1UqGbjC66E85S4m63CfV/awwNbbLbkxsvfgzn0KSv7JzH3gcs/OIL";
```
\
Construct payment request and payment code:
```dart
PaymentCode paymentCode = new PaymentCode("VEMVQR");

PaymentRequest paymentRequest = new QRPaymentBuilder(paymentCode)
    .setType(QRTypeCode.URL)
    .setName("DavidBilly")
    .setEmail("davidbilly@2c2p.com")
    .setMobileNo("08888888")
    .build();
```
\
Use the payment token, payment code, and payment request to build a [transaction request](#constructing-transaction-requests), which can be used to execute the transaction by calling [proceed transaction](#payment-with-card-token).

### Over the Counter
Import the following libraries into your file:
```dart
import 'package:pgw_sdk/builder/pay_at_counter_builder.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/payment_request.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
```
\
Prepare a payment token request by referring to the guidelines [here](https://developer.2c2p.com/docs/api-payment-token).
```json
{
  "merchantID": "JT04",
  "invoiceNo": "1595219400",
  "description": "2 days 1 night hotel room",
  "amount": 10.0,
  "currencyCode": "THB",
  "nonceStr": "a8092512-b144-41b0-8284-568bb5e9264c",
  "paymentChannel": ["COUNTER"]
}
```
\
The payment token API will return response data that will contain the payment token ID which must be passed to the merchant application:
```dart
String paymentToken = "roZG9I1hk/GYjNt+BYPYbxQtKElbZDs9M5cXuEbE+Z0QTr/yUcl1oG7t0AGoOJlBhzeyBtf5mQi1UqGbjC66E85S4m63CfV/awwNbbLbkxsvfgzn0KSv7JzH3gcs/OIL";
```
\
Construct payment request and payment code:
```dart
PaymentCode paymentCode = new PaymentCode("123", "BIGC", "OVERTHECOUNTER");

PaymentRequest paymentRequest = new PayAtCounterBuilder(paymentCode)
    .setName("DavidBilly")
    .setEmail("davidbilly@2c2p.com")
    .setMobileNo("08888888")
    .build();
```
\
Use the payment token, payment code, and payment request to build a [transaction request](#constructing-transaction-requests), which can be used to execute the transaction by calling [proceed transaction](#payment-with-card-token).

## Constructing Transaction Requests
Use the payment request and code, along with the payment token to prepare the transaction request:
```dart
TransactionResultRequestBuilder request = TransactionResultRequestBuilder(
  paymentToken: paymentToken,
  paymentRequest: paymentRequest,
);
```
Merchants can use this request to call  ```PGWSDK.paymentWithCardToken(request)``` or ```PGWSDK.proceedTransaction(request)```. More info in [the next section](#executing-transactions).

## Executing Transactions
Execute the transaction request to receive a redirect URL. 

### Payment with Card Token
```dart
TransactionResultResponse response = await PGWSDK.paymentWithCardToken(request);
String redirectUrl = response.data;
```
### Proceed Transaction 
```dart
TransactionResultResponse response = await PGWSDK.proceedTransaction(request);
String redirectUrl = response.data;
```
\
2c2p supports a list of payment methods. Refer to this [link](https://developer.2c2p.com/docs/sdk-payment-methods) for more payment options. 

See the full 2c2p PGW SDK documentation [here](https://developer.2c2p.com/docs/sdk-how-to-integrate)

## Payment Features Examples

An example app is also provided to test SDK functions and features.

- [Example Stored Card Usage](EXAMPLE_STORED_CARD_USAGE.md) 
- [Example Pay at Counter Usage](EXAMPLE_PAY_AT_COUNTER_USAGE.md)
- [Example Internet Banking Usage](EXAMPLE_INTERNET_BANKING_USAGE.md)
- [Example QR Payment Usage](EXAMPLE_QR_PAYMENT_USAGE.md)

## Contributing
2C2P

## License
[MIT](/LICENSE)