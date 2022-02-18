import 'package:flutter/material.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:pgw_sdk_example/constant/colours.dart';
import 'package:pgw_sdk_example/scenes/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PGWSDK.initialize(APIEnvironment.Sandbox);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: HomePage(),
    );
  }
}
