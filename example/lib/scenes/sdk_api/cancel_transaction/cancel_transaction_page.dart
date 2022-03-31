import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';

class CancelTransactionPage extends StatefulWidget {
  const CancelTransactionPage({Key? key}) : super(key: key);

  @override
  _CancelTransactionPageState createState() => _CancelTransactionPageState();
}

class _CancelTransactionPageState extends State<CancelTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Cancel Transaction'),
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
