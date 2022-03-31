import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/models/enums/category_code.dart';
import 'package:pgw_sdk_example/models/enums/group_code.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_option_details/pages/payment_option_details_page.dart';

class PaymentOptionDetailsRouter {
  late BuildContext _context;

  PaymentOptionDetailsRouter(BuildContext context) {
    _context = context;
  }
  void toPaymentOptionDetailsPage({required CategoryCode categoryCode, required GroupCode groupCode}) {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => PaymentOptionDetailsPage(categoryCode: categoryCode, groupCode: groupCode)));
  }
}
