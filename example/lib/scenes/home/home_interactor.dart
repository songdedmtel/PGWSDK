import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pgw_sdk/builder/card_token_payment_builder.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:pgw_sdk_example/api/models/demo_request.dart';
import 'package:pgw_sdk_example/api/repositories/payment_inquiry_repository.dart';
import 'package:pgw_sdk_example/api/repositories/payment_token_repository.dart';
import 'package:pgw_sdk_example/scenes/webview/webview_page.dart';
import 'package:pgw_sdk_example/utils/string_helper.dart';
import 'package:pgw_sdk_example/widgets/dialog_view.dart';

class HomeInteractor {
  late BuildContext _context;
  String invoiceNo = '';
  String? paymentToken;
  String cardToken = '';

  HomeInteractor(BuildContext context) {
    _context = context;
  }

  creditCardPayment() async {
    invoiceNo = StringHelper.generateInvoiceNo();
    final jsonRequest = DemoRequest.getCCRequest(
      invoiceNo: invoiceNo,
    );

    log('\nMake new request...');
    log('Json for new payment token => $jsonRequest');

    /// Get Payment Token
    paymentToken = await PaymentTokenRepository().setRequest(jsonRequest).execute();
    if (paymentToken == null) throw 'Can\'t get paymentToken, null value.';

    // Log
    log('Payment Token => $paymentToken');

    TransactionResultResponse? result = await PGWSDK.openCreditCardUI(
      _context,
      paymentToken: this.paymentToken!,
    );

    if (result != null) {
      if (result.responseCode == '1001') {
        await Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (context) => WebviewPage(
              url: result.data!,
            ),
          ),
        );
      } else {
        DialogView.show(
          _context,
          title: 'Error',
          message: result.responseDescription ?? 'Something wrong',
          onTap: () {},
        );
      }
    } else {
      // Skip when result == null
    }
  }

  paymentWithCardToken() async {
    if (paymentToken == null || paymentToken == '') {
      _showErrorFromCardToken();
      return;
    }

    /// Log send request
    log('Inquiry request... ');
    log('Payment Token => $paymentToken');
    log('Invoice Number => $invoiceNo');

    /// Request Payment Inquiry for get card token.
    final inquiryResponse = await PaymentInquiryRepository().setRequest(paymentToken: paymentToken!, invoiceNo: invoiceNo).execute();
    log('Inquiry response => ${inquiryResponse?.toJson()}');

    cardToken = inquiryResponse?.cardToken ?? '';

    if (cardToken == '') {
      /// Show error when card token is empty.
      _showErrorFromCardToken();
    } else {
      /// Get paymentToken for request.
      final jsonRequest = DemoRequest.getCardTokenRequest(
        cardTokens: [cardToken],
      );

      log('\nMake new request...');
      log('Json for new payment token => $jsonRequest');

      /// Get Payment Token
      paymentToken = await PaymentTokenRepository().setRequest(jsonRequest).execute();
      if (paymentToken == null) throw 'Can\'t get paymentToken, null value.';

      // Log
      log('Payment Token => $paymentToken');

      /// Make request.
      var paymentCode = PaymentCode(channelCode: 'CC');
      var paymentRequest = CardTokenPaymentBuilder(paymentCode: paymentCode, cardToken: cardToken).build();
      var request = TransactionResultRequestBuilder(
        paymentToken: paymentToken,
        paymentRequest: paymentRequest,
      );

      /// Pay with card token.
      final result = await PGWSDK.paymentWithCardToken(request);
      if (result.data != null) {
        await Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (context) => WebviewPage(
              url: result.data!,
            ),
          ),
        );
      }
    }
  }

  _showErrorFromCardToken() {
    DialogView.show(
      _context,
      title: 'Error',
      message: 'Please use \'Credit/Debit Card\' and set \'Save card data for future payments\' before use this feature.',
      onTap: () {},
    );
  }

  showDialogComingSoon() {
    DialogView.show(
      _context,
      title: 'Coming soon',
      message: 'Please wait for the new update.',
      onTap: () {},
    );
  }
}
