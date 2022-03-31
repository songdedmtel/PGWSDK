import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';

class UserPreferencePage extends StatefulWidget {
  const UserPreferencePage({Key? key}) : super(key: key);

  @override
  _UserPreferencePageState createState() => _UserPreferencePageState();
}

class _UserPreferencePageState extends State<UserPreferencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'User Preference'),
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
