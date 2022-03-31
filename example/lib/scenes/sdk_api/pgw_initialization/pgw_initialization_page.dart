import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';

class PGWInitializationPage extends StatefulWidget {
  const PGWInitializationPage({Key? key}) : super(key: key);

  @override
  _PGWInitializationPageState createState() => _PGWInitializationPageState();
}

class _PGWInitializationPageState extends State<PGWInitializationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'PGW Initialization'),
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
