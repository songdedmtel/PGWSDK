import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/models/channels/internet_banking.dart';
import 'package:pgw_sdk_example/models/channels/pay_at_counter.dart';
import 'package:pgw_sdk_example/models/channels/qr_payment.dart';
import 'package:pgw_sdk_example/models/enums/agent_channel_code.dart';
import 'package:pgw_sdk_example/scenes/payment_methods/payment_methods_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/cancel_transaction/cancel_transaction_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/card_tokens_information/card_tokens_information_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/do_payment/do_payment_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/exchange_rate/exchange_rate_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_notification/payment_notification_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_option_details/pages/payment_option_details_form_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_options/pages/payment_options_form_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/pgw_initialization/pgw_initialization_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/transaction_status_inquiry/transaction_status_inquiry_page.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/user_preference/user_preference_page.dart';
import 'package:pgw_sdk_example/widgets/dialog_view.dart';

class HomeRouter {
  late BuildContext _context;

  HomeRouter(BuildContext context) {
    _context = context;
  }

  void toOverTheCounterPage() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodsPage(
          title: 'Over the Counter',
          paymentAgentList: payAtCounterList.where((e) => e.agentChannelCode == AgentChannelCode.OVERTHECOUNTER).toList(),
          paymentChannel: 'COUNTER',
        ),
      ),
    );
  }

  void toInternetBankingPage() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodsPage(
          title: 'Internet Banking',
          paymentAgentList: internetBankingList,
          paymentChannel: 'IMBANK',
        ),
      ),
    );
  }

  void toQRPaymentPage() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodsPage(
          title: 'QR Payment',
          paymentAgentList: qrPaymentList,
          paymentChannel: 'QR',
        ),
      ),
    );
  }

  void toPaymentOptionsPage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => PaymentOptionsFormPage()));
  }

  void toPaymentOptionDetailsPage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => PaymentOptionDetailsFormPage()));
  }

  void toDoPaymentPage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => DoPaymentPage()));
  }

  void toTransactionStatusInquiryPage(String? paymentToken) {
    if (paymentToken == null) {
      DialogView.show(_context, title: 'Error', message: 'No Payment Token');
      return;
    }
    Navigator.push(_context, MaterialPageRoute(builder: (context) => TransactionStatusInquiryPage(paymentToken: paymentToken)));
  }

  void toPGWInitializationPage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => PGWInitializationPage()));
  }

  void toCardTokensInformationPage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => CardTokensInformationPage()));
  }

  void toExchangeRatePage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => ExchangeRatePage()));
  }

  void toUserPreferencePage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => UserPreferencePage()));
  }

  void toPaymentNotificationPage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => PaymentNotificationPage()));
  }

  void toCancelTransactionPage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => CancelTransactionPage()));
  }
}
