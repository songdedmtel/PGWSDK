import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:pgw_sdk/ui/constants/colours.dart';
import 'package:pgw_sdk/ui/constants/payment_method_type.dart';
import 'package:pgw_sdk/ui/constants/styles.dart';
import 'package:pgw_sdk/ui/scenes/credit_card/credit_card_page.dart';

class ProceedPage extends StatefulWidget {
  ProceedPage({required this.paymentToken, required this.methodType});

  final String paymentToken;
  final PaymentMethodType methodType;

  @override
  _ProceedPageState createState() => _ProceedPageState();
}

class _ProceedPageState extends State<ProceedPage> {
  String _getTitle() {
    switch (widget.methodType) {
      case PaymentMethodType.creditDebitCard:
        return 'Credit/Debit Card';
      default:
        return 'Payment';
    }
  }

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      PGWSDK.initialize(APIEnvironment.Sandbox);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Payment'),
      // ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xFFE5E5E5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 2C2P Logo
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.arrow_back, color: primaryColor),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 20),
                    Text(_getTitle(), style: textTitle),
                  ],
                ),
              ),

              /// View
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: widget.methodType == PaymentMethodType.creditDebitCard ? CreditCardPage(paymentToken: widget.paymentToken) : Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
