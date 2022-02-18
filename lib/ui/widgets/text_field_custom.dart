import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgw_sdk/ui/constants/colours.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom({
    Key? key,
    this.hight,
    this.maxLines,
    this.vertical,
    this.enabled,
    this.hintText,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.controller,
    this.formatters,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.validator,
  }) : super(key: key);

  final double? hight;
  final int? maxLines;
  final double? vertical;
  final bool? enabled;
  final String? hintText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final String? errorText;
  final TextStyle? errorStyle;
  final int? errorMaxLines;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        // color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled ?? true,
        style: TextStyle(
          decoration: TextDecoration.none,
        ),
        maxLines: maxLines ?? 1,
        cursorColor: primaryColor,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText ?? '',
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
          // errorBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFCECECE)),
          ),
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: vertical ?? 11,
          ),
          errorText: errorText,
          errorStyle: errorStyle,
          errorMaxLines: errorMaxLines,
        ),
        inputFormatters: formatters,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
