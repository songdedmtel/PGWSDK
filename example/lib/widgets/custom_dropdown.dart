import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/constant/styles.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    this.label,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.enabled,
    Key? key,
  }) : super(key: key);
  final String? label;
  final String? value;
  final List<String> items;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
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
          DropdownButtonFormField<String>(
            decoration: customInputDecoration,
            value: value ?? null,
            items: items.map((String item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: onChanged ?? null,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
