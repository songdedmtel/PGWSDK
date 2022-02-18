import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context, {bool dismissible = false}) {
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
