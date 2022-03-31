import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogLoading {
  static show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  static hide(BuildContext context) {
    Navigator.pop(context);
  }
}
