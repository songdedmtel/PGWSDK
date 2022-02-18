import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/constant/colours.dart';

Widget customDropdown({
  Key? key,
  String? label,
  String? hintText,
  String? value,
  required List<String> items,
  required void Function(String?) onChanged,
  String? Function(String?)? validator,
  bool enabled = true,
}) {
  return Container(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        label ?? '',
      ),
      SizedBox(height: 5),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
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
          fillColor: Colors.white,
          filled: true,
        ),
        value: value ?? null,
        items: items.map((String item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: enabled ? onChanged : null,
        validator: validator,
      ),
    ]),
  );
}
