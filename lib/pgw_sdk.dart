import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';

import 'models/transaction_result_request_builder.dart';

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
}
