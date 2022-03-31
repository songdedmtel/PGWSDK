import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/models/enums/country_code.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_options/payment_options_interactor.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_options/payment_options_router.dart';
import 'package:pgw_sdk_example/utils/validator.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';
import 'package:pgw_sdk_example/widgets/custom_dropdown.dart';
import 'package:pgw_sdk_example/widgets/custom_submit_button.dart';

class PaymentOptionsFormPage extends StatefulWidget {
  const PaymentOptionsFormPage({Key? key}) : super(key: key);

  @override
  _PaymentOptionsFormPageState createState() => _PaymentOptionsFormPageState();
}

class _PaymentOptionsFormPageState extends State<PaymentOptionsFormPage> {
  late PaymentOptionsInteractor _interactor;
  late PaymentOptionsRouter _router;
  GlobalKey<FormState> _form = GlobalKey();
  String? _merchantId;
  List<String> _merchantIdList = ['JT01', 'JT02', 'JT03', 'JT04', 'JT05', 'JT06', 'JT07', 'JT08'];
  bool isValid = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _interactor = PaymentOptionsInteractor(context);
    _router = PaymentOptionsRouter(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Options'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            if (_form.currentState!.mounted) {
              isValid = _form.currentState!.validate();
            }
          });
        },
        child: Container(
          padding: EdgeInsets.all(35),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomDropdown(
                    label: 'Merchant ID',
                    value: _merchantId,
                    items: _merchantIdList,
                    onChanged: (value) {
                      _merchantId = value;
                    },
                    validator: Validator.validDropdown,
                  ),
                  SizedBox(height: 40),
                  CustomSubmitButton(
                    label: 'View payment options',
                    onPressed: () {
                      CountryCode _countryCode = CountryCode.values.where((CountryCode e) => e.merchantId == _merchantId).first;
                      _router.toPaymentOptionsPage(countryCode: _countryCode);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
