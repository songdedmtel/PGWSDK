import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgw_sdk/builder/card_payment_builder.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/models/transaction_result_response.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:pgw_sdk/ui/widgets/loading_dialog.dart';

class CreditCardInteractor {
  late BuildContext _context;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();

  CreditCardInteractor(BuildContext context) {
    _context = context;
  }

  onClickProceed(String paymentToken, [bool isStoredCard = false]) async {
    final form = formKey.currentState;

    if (!form!.validate()) {
      return;
    }
    FocusScope.of(_context).unfocus();
    LoadingDialog.show(_context);
    TransactionResultResponse? result;
    String errorDescription = '';
    try {
      result = await proceed(paymentToken, isStoredCard);
    } on PlatformException catch (e) {
      errorDescription = e.message ?? '';
      print(e);
    } catch (e) {
      errorDescription = e.toString();
      print(e);
    }
    print('Result =>>> ${result?.toJson()}');

    LoadingDialog.hide(_context);

    if (result == null) {
      result = TransactionResultResponse(responseCode: '999', responseDescription: errorDescription);
    }
    Navigator.pop(_context, result);

    // if (result?.responseCode == '1001') {
    //   // Open webview
    //   await Navigator.push(
    //     _context,
    //     MaterialPageRoute(
    //       builder: (context) => WebviewPage(
    //         url: result!.data!,
    //       ),
    //     ),
    //   );
    //   Navigator.pop(_context);
    // } else {
    //   // Show error dialog
    //   DialogView.show(_context, title: 'Error', message: errorDescription, onTap: () {});
    // }
  }

  Future<TransactionResultResponse> proceed(String paymentToken, [bool isStoredCard = false]) async {
    // create request
    final expMonth = expController.text.split('/')[0];
    final expYear = expController.text.split('/')[1];

    var paymentCode = PaymentCode(channelCode: 'CC');
    var paymentRequest = CardPaymentBuilder(paymentCode: paymentCode, cardNo: cardNumberController.text.replaceAll(' ', ''))
        .setExpiryMonth(int.parse(expMonth))
        .setExpiryYear(int.parse('20$expYear'))
        .setSecurityCode(cvvController.text)
        .setName(cardHolderController.text)
        .setTokenize(isStoredCard)
        .build();

    var request = TransactionResultRequestBuilder(
      paymentToken: paymentToken,
      paymentRequest: paymentRequest,
    );

    var result = await PGWSDK.proceedTransaction(request);
    print('Result =>>> ${result.toJson()}');
    return result;
  }
}
