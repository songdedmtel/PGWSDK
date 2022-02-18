import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/scenes/payment_methods/pay_at_counter/pay_at_counter_page.dart';

class HomeRouter {
  late BuildContext _context;

  HomeRouter(BuildContext context) {
    _context = context;
  }

  void toPayAtCounterPage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => PayAtCounterPage()));
  }
}
