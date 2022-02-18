import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/models/card_token_info/card_token_info_request.dart';
import 'package:pgw_sdk/models/card_token_info/card_token_info_response.dart';
import 'package:pgw_sdk/models/exchange_rate/exchange_rate_request.dart';
import 'package:pgw_sdk/models/exchange_rate/exchange_rate_response.dart';
import 'package:pgw_sdk/models/payment_option/payment_option_request.dart';
import 'package:pgw_sdk/models/payment_option/payment_option_response.dart';
import 'package:pgw_sdk/models/payment_option_detail/payment_option_detail_request.dart';
import 'package:pgw_sdk/models/payment_option_detail/payment_option_detail_response.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/models/transaction_status/transaction_status_request.dart';
import 'package:pgw_sdk/models/transaction_status/transaction_status_response.dart';
import 'package:pgw_sdk/ui/constants/payment_method_type.dart';
import 'package:pgw_sdk/ui/scenes/proceed/proceed_page.dart';

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
    print(jsonResponse);
    final result = TransactionResultResponse.fromJson(jsonResponse);
    result.raw = jsonResponse;
    return result;
  }

  static Future<TransactionResultResponse> paymentWithCardToken(TransactionResultRequestBuilder request) async {
    final String jsonResponse = await _channel.invokeMethod('paymentWithCardToken', {
      'request': request.toJson(),
    });
    final result = TransactionResultResponse.fromJson(jsonResponse);
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

  static Future<CardTokenInfoResponse> cardTokenInfo(CardTokenInfoRequest request) async {
    final String jsonResponse = await _channel.invokeMethod('cardTokenInfo', {
      'cardTokenInfoRequest': request.toJson(),
    });
    final result = CardTokenInfoResponse.fromJson(jsonResponse);
    return result;
  }

  static Future<ExChangeRateResponse> exchangeRate(ExChangeRateRequest request) async {
    final String jsonResponse = await _channel.invokeMethod('exchangeRate', {
      'exChangeRateRequest': request.toJson(),
    });
    final result = ExChangeRateResponse.fromJson(jsonResponse);
    return result;
  }

  static Future<TransactionResultResponse?> openCreditCardUI(BuildContext context, {required String paymentToken}) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProceedPage(
                  paymentToken: paymentToken,
                  methodType: PaymentMethodType.creditDebitCard,
                )));
  }
}
