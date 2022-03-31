import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/models/enums/country_code.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_options/pages/payment_options_page.dart';

class PaymentOptionsRouter {
  late BuildContext _context;

  PaymentOptionsRouter(BuildContext context) {
    _context = context;
  }

  void toPaymentOptionsPage({required CountryCode countryCode}) {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => PaymentOptionsPage(countryCode: countryCode)));
  }
}
