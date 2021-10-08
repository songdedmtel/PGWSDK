import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/models/payment_option/payment_option_request.dart';
import 'package:pgw_sdk/models/payment_option/payment_option_response.dart';
import 'package:pgw_sdk/models/payment_option_detail/payment_option_detail_request.dart';
import 'package:pgw_sdk/models/payment_option_detail/payment_option_detail_response.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/models/transaction_status/transaction_status_request.dart';
import 'package:pgw_sdk/models/transaction_status/transaction_status_response.dart';

class PGWSDK {
  PGWSDK._();

  static const MethodChannel _channel = const MethodChannel('pgw_sdk');

  static Future<String> get sdkVersion async {
    final String version = await _channel.invokeMethod('sdkVersion');
    return version;
  }

  /// Before performing any payment transaction, your application is required to initialize 2C2P PGW SDK
  /// The 2C2P PGW SDK should be initialize on main class
  static Future<void> initialize(APIEnvironment environment) async {
    return await _channel.invokeMethod('initialize', {'apiEnvironment': environment.value});
  }

  static Future<TransactionResultResponse> proceedTransaction(TransactionResultRequestBuilder builder) async {
    final String jsonResponse = await _channel.invokeMethod('proceedTransaction', {
      'request': builder.toJson(),
    });
    final result = TransactionResultResponse.fromJson(jsonResponse);
    result.raw = jsonResponse;
    return result;
  }

  static Future<PaymentOptionResponse> paymentOption(PaymentOptionRequest request) async {
    final String jsonResponse = await _channel.invokeMethod('paymentOption', {
      'paymentOptionRequest': request.toJson(),
    });
    final result = PaymentOptionResponse.fromJson(jsonResponse);
    return result;
  }

  static Future<PaymentOptionDetailResponse> paymentOptionDetail(PaymentOptionDetailRequest request) async {
    final String jsonResponse = await _channel.invokeMethod('paymentOptionDetail', {
      'paymentOptionDetailRequest': request.toJson(),
    });
    final result = PaymentOptionDetailResponse.fromJson(jsonResponse);
    return result;
  }

  static Future<TransactionStatusResponse> transactionStatus(TransactionStatusRequest request) async {
    final String jsonResponse = await _channel.invokeMethod('transactionStatus', {
      'transactionStatusRequest': request.toJson(),
    });
    final result = TransactionStatusResponse.fromJson(jsonResponse);
    return result;
  }
}
