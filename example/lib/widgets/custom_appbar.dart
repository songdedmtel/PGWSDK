import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/constant/colours.dart';
import 'package:pgw_sdk_example/constant/styles.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    shape: Border(bottom: BorderSide(color: primaryColor, width: 2)),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: primaryColor,
      ),
    ),
    title: Text(
      'Pay at Counter',
      style: textTitle,
    ),
    backgroundColor: backgroundColor,
    elevation: 0,
  );
}
