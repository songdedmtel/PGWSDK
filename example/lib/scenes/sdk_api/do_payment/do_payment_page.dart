import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/utils/transaction.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';
import 'package:pgw_sdk_example/widgets/custom_submit_button.dart';

class DoPaymentPage extends StatefulWidget {
  const DoPaymentPage({Key? key}) : super(key: key);

  @override
  _DoPaymentPageState createState() => _DoPaymentPageState();
}

class _DoPaymentPageState extends State<DoPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Do Payment'),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {});
        },
        child: CustomSubmitButton(
          label: 'test',
          onPressed: () {
            Transaction.proceed(
              paymentChannel: 'IMBANK',
              agentCode: 'SCB',
              agentChannelCode: 'IBANKING',
              firstName: 'a',
              lastName: 'b',
              email: 'wer@ff.com',
              mobileNo: '0800000000',
              paymentToken: 'kSAops9Zwhos8hSTSeLTUfy9LDHcd15uvFwDnsg6e/duWw+pyvr7K7i6Vikz9lRhk1mCbVZCzRRFGsUfYaq7Ywf8SRkdf0/6DHN0lh9LB4g=',
            );
          },
        ),
      ),
    );
  }
}
