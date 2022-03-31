import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pgw_sdk/models/transaction_status/transaction_status_request.dart';
import 'package:pgw_sdk/models/transaction_status/transaction_status_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:pgw_sdk_example/widgets/dialog_view.dart';

class TransactionStatusInquiryInteractor {
  late BuildContext _context;

  final List<String> labelsMerchantInfo = [
    'Merchant ID:',
    'Name:',
    'Address:',
    'Email:',
    'Logo:',
  ];

  final List<String> labelsTransactionInfo = [
    'Transaction:',
    'Invoice No.:',
    'Amount:',
    'Agent Code:',
    'Channel Code:',
    'Currency Code:',
    'Response Code:',
    'Response Description:',
  ];

  TransactionStatusInquiryInteractor(BuildContext context) {
    _context = context;
  }

  Future<TransactionStatusResponse?> proceed(String paymentToken) async {
    try {
      final request = TransactionStatusRequest(paymentToken: paymentToken);
      final result = await PGWSDK.transactionStatus(request);

      log('Responses =>> ${result.toJson()}');
      return result;
    } catch (e) {
      print(e);

      DialogView.show(_context, title: 'Error', message: '$e');
      return null;
    }
  }

  String getMerchantInfoFrom(int index, TransactionStatusResponse response) {
    switch (index) {
      case 0:
        return response.additionalInfo?.merchantInfo?.id ?? 'null';
      case 1:
        return response.additionalInfo?.merchantInfo?.name ?? 'null';
      case 2:
        return response.additionalInfo?.merchantInfo?.address ?? 'null';
      case 3:
        return response.additionalInfo?.merchantInfo?.email ?? 'null';
      case 4:
        return response.additionalInfo?.merchantInfo?.logoUrl ?? 'null';
      default:
        return '';
    }
  }

  String getTransactionInfoFrom(int index, TransactionStatusResponse response) {
    switch (index) {
      case 0:
        return response.additionalInfo?.transactionInfo?.productDescription ?? 'null';
      case 1:
        return response.invoiceNo ?? 'null';
      case 2:
        return response.additionalInfo?.transactionInfo?.amount ?? 'null';
      case 3:
        return response.additionalInfo?.transactionInfo?.agentCode ?? 'null';
      case 4:
        return response.channelCode ?? 'null';
      case 5:
        return response.additionalInfo?.transactionInfo?.currencyCode ?? 'null';
      case 6:
        return response.responseCode ?? 'null';
      case 7:
        return response.responseDescription ?? 'null';
      default:
        return '';
    }
  }
}
