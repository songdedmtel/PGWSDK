import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colours.dart';

final TextStyle textTitle = TextStyle(
  color: primaryColor,
  fontSize: 20,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
);

final TextStyle textHeaderInverse = TextStyle(
  color: backgroundColor,
  fontSize: 18,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
);
final TextStyle textHeader = TextStyle(
  color: primaryColor,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

final TextStyle textSubHeader = TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w200, fontStyle: FontStyle.italic);
final TextStyle textDialogButton = TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);

final TextStyle textParagraph = TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300);

final InputDecoration customInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintStyle: TextStyle(
    decoration: TextDecoration.none,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey.shade400),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: primaryColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Color(0xFFCECECE)),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Color(0xFFCECECE)),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey),
  ),
  contentPadding: EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 11,
  ),
);

class Styles {
  static TextStyle text({
    Color? color,
    double? size,
    FontWeight weight: FontWeight.normal,
    double? letterSpacing,
    TextDecoration? line,
    // TextOverflow? flow,
  }) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'PromptRegular',
        decoration: line ?? null,
        // overflow: flow ?? null,
        // height: 1.2,
        letterSpacing: letterSpacing);
  }
}
