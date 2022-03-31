import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';

class CardTokensInformationPage extends StatefulWidget {
  const CardTokensInformationPage({Key? key}) : super(key: key);

  @override
  _CardTokensInformationPageState createState() => _CardTokensInformationPageState();
}

class _CardTokensInformationPageState extends State<CardTokensInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Card Tokens Information'),
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
