import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgw_sdk_example/constant/colours.dart';

Widget customTextField({
  Key? key,
  String? label,
  String? hintText,
  Function(String)? onChanged,
  String? Function(String?)? validator,
  List<TextInputFormatter>? formatters,
  bool? enabled,
}) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
        ),
        SizedBox(height: 5),
        TextFormField(
          enabled: enabled ?? true,
          style: TextStyle(
            decoration: TextDecoration.none,
          ),
          validator: validator ?? null,
          onChanged: onChanged,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText ?? '',
            hintStyle: TextStyle(
              decoration: TextDecoration.none,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
          ),
          inputFormatters: formatters,
        ),
      ],
    ),
  );
}
