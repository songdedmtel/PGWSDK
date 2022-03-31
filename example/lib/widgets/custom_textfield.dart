import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgw_sdk_example/constant/colours.dart';
import 'package:pgw_sdk_example/constant/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.label,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.controller,
    this.validator,
    this.formatters,
    this.enabled,
  }) : super(key: key);

  final String? label;
  final String? hintText;
  final String? errorText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatters;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(
              label ?? '',
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: controller ?? null,
            enabled: enabled ?? true,
            style: TextStyle(
              decoration: TextDecoration.none,
            ),
            validator: validator ?? null,
            onChanged: onChanged,
            cursorColor: primaryColor,
            decoration: customInputDecoration,
            inputFormatters: formatters,
          ),
        ],
      ),
    );
  }
}
