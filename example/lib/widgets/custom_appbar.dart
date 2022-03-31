import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/constant/colours.dart';
import 'package:pgw_sdk_example/constant/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: Border(bottom: BorderSide(color: primaryColor, width: 2)),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: primaryColor,
        ),
      ),
      title: Text(
        title,
        style: textTitle,
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
    );
  }
}
