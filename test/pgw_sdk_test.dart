import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pgw_sdk/models/payment_option/payment_option_request.dart';
import 'package:pgw_sdk/models/payment_option/payment_option_response.dart';
import 'package:pgw_sdk/models/payment_option_detail/payment_option_detail_request.dart';
import 'package:pgw_sdk/models/payment_option_detail/payment_option_detail_response.dart';
import 'package:pgw_sdk/models/payment_request.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';

import 'mock_native_response.dart';

void main() {
  const MethodChannel channel = MethodChannel('pgw_sdk');
  MockNativeResponse mock = MockNativeResponse();
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'sdkVersion':
          return '4.4.0';
        case 'paymentOption':
          return mock.paymentOption;
        case 'paymentOptionDetail':
          return mock.paymentOptionDetail;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('Get platform version', () async {
    expect(await PGWSDK.sdkVersion, '4.4.0');
  });

  test('Test Payment Option', () async {
    PaymentOptionRequest mockRequest = PaymentOptionRequest(paymentToken: '123');
    PaymentOptionResponse actualResponse = await PGWSDK.paymentOption(mockRequest);
    PaymentOptionResponse expectedResponse = PaymentOptionResponse.fromJson(mock.paymentOption);

    expect(actualResponse.responseCode, expectedResponse.responseCode);
    expect(actualResponse.responseDescription, expectedResponse.responseDescription);
    expect(actualResponse.paymentToken, expectedResponse.paymentToken);
  });

  test('Test Payment Option Detail', () async {
    PaymentOptionDetailRequest mockRequest = PaymentOptionDetailRequest(paymentToken: '123');
    PaymentOptionDetailResponse actualResponse = await PGWSDK.paymentOptionDetail(mockRequest);
    PaymentOptionDetailResponse expectedResponse = PaymentOptionDetailResponse.fromJson(mock.paymentOptionDetail);

    expect(actualResponse.toJson(), mock.paymentOptionDetail);
    expect(actualResponse.responseCode, expectedResponse.responseCode);
    expect(actualResponse.responseDescription, expectedResponse.responseDescription);
    expect(actualResponse.groupCode, expectedResponse.groupCode);
    expect(actualResponse.categoryCode, expectedResponse.categoryCode);
    expect(actualResponse.name, expectedResponse.name);
    expect(actualResponse.iconUrl, expectedResponse.iconUrl);
  });

  test('Test Over the Counter', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'proceedTransaction') return mock.counter;
    });
    PaymentRequest mockPaymentRequest = PaymentRequest();
    TransactionResultRequestBuilder mockTransactionRequest = TransactionResultRequestBuilder(paymentToken: '123', paymentRequest: mockPaymentRequest);
    TransactionResultResponse actualResponse = await PGWSDK.proceedTransaction(mockTransactionRequest);
    TransactionResultResponse expectedResponse = TransactionResultResponse.fromJson(mock.counter);

    expect(actualResponse.toJson(), expectedResponse.toJson());
    expect(actualResponse.responseCode, expectedResponse.responseCode);
    expect(actualResponse.responseDescription, expectedResponse.responseDescription);
    expect(actualResponse.data, expectedResponse.data);
    expect(actualResponse.invoiceNo, expectedResponse.invoiceNo);
    expect(actualResponse.channelCode, expectedResponse.channelCode);
    expect(actualResponse.expiryDescription, expectedResponse.expiryDescription);
    expect(actualResponse.expiryTimer, expectedResponse.expiryTimer);
    expect(actualResponse.type, expectedResponse.type);
    expect(actualResponse.fallbackData, expectedResponse.fallbackData);
  });

  test('Test Credit Debit Card', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'proceedTransaction') return mock.creditDebitCard;
    });
    PaymentRequest mockPaymentRequest = PaymentRequest();
    TransactionResultRequestBuilder mockTransactionRequest = TransactionResultRequestBuilder(paymentToken: '123', paymentRequest: mockPaymentRequest);
    TransactionResultResponse actualResponse = await PGWSDK.proceedTransaction(mockTransactionRequest);
    TransactionResultResponse expectedResponse = TransactionResultResponse.fromJson(mock.creditDebitCard);

    expect(actualResponse.toJson(), expectedResponse.toJson());
    expect(actualResponse.responseCode, expectedResponse.responseCode);
    expect(actualResponse.responseDescription, expectedResponse.responseDescription);
    expect(actualResponse.data, expectedResponse.data);
    expect(actualResponse.invoiceNo, expectedResponse.invoiceNo);
    expect(actualResponse.channelCode, expectedResponse.channelCode);
    expect(actualResponse.expiryDescription, expectedResponse.expiryDescription);
    expect(actualResponse.expiryTimer, expectedResponse.expiryTimer);
    expect(actualResponse.type, expectedResponse.type);
    expect(actualResponse.fallbackData, expectedResponse.fallbackData);
  });

  test('Test IBanking', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'proceedTransaction') return mock.ibanking;
    });
    PaymentRequest mockPaymentRequest = PaymentRequest();
    TransactionResultRequestBuilder mockTransactionRequest = TransactionResultRequestBuilder(paymentToken: '123', paymentRequest: mockPaymentRequest);
    TransactionResultResponse actualResponse = await PGWSDK.proceedTransaction(mockTransactionRequest);
    TransactionResultResponse expectedResponse = TransactionResultResponse.fromJson(mock.ibanking);

    expect(actualResponse.toJson(), expectedResponse.toJson());
    expect(actualResponse.responseCode, expectedResponse.responseCode);
    expect(actualResponse.responseDescription, expectedResponse.responseDescription);
    expect(actualResponse.data, expectedResponse.data);
    expect(actualResponse.invoiceNo, expectedResponse.invoiceNo);
    expect(actualResponse.channelCode, expectedResponse.channelCode);
    expect(actualResponse.expiryDescription, expectedResponse.expiryDescription);
    expect(actualResponse.expiryTimer, expectedResponse.expiryTimer);
    expect(actualResponse.type, expectedResponse.type);
    expect(actualResponse.fallbackData, expectedResponse.fallbackData);
  });

  test('Test QR Payment', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'proceedTransaction') return mock.qrPayment;
    });
    PaymentRequest mockPaymentRequest = PaymentRequest();
    TransactionResultRequestBuilder mockTransactionRequest = TransactionResultRequestBuilder(paymentToken: '123', paymentRequest: mockPaymentRequest);
    TransactionResultResponse actualResponse = await PGWSDK.proceedTransaction(mockTransactionRequest);
    TransactionResultResponse expectedResponse = TransactionResultResponse.fromJson(mock.qrPayment);

    expect(actualResponse.toJson(), expectedResponse.toJson());
    expect(actualResponse.responseCode, expectedResponse.responseCode);
    expect(actualResponse.responseDescription, expectedResponse.responseDescription);
    expect(actualResponse.data, expectedResponse.data);
    expect(actualResponse.invoiceNo, expectedResponse.invoiceNo);
    expect(actualResponse.channelCode, expectedResponse.channelCode);
    expect(actualResponse.expiryDescription, expectedResponse.expiryDescription);
    expect(actualResponse.expiryTimer, expectedResponse.expiryTimer);
    expect(actualResponse.type, expectedResponse.type);
    expect(actualResponse.fallbackData, expectedResponse.fallbackData);
  });
}
