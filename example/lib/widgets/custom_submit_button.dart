import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk/ui/constants/colours.dart';
import 'package:pgw_sdk_example/constant/styles.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({Key? key, required this.label, this.onPressed}) : super(key: key);
  final String label;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          label,
          style: textHeaderInverse,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
