import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';

class PaymentNotificationPage extends StatefulWidget {
  const PaymentNotificationPage({Key? key}) : super(key: key);

  @override
  _PaymentNotificationPageState createState() => _PaymentNotificationPageState();
}

class _PaymentNotificationPageState extends State<PaymentNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Notification'),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {});
        },
        child: Container(),
      ),
    );
  }
}
