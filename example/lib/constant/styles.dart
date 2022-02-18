import 'package:flutter/cupertino.dart';

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
  color: Color(0xFF064F5C),
  fontSize: 18,
  fontWeight: FontWeight.bold,
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
