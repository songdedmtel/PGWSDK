import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk_example/models/enums/category_code.dart';
import 'package:pgw_sdk_example/models/enums/group_code.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_option_details/payment_option_details_interactor.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_option_details/payment_option_details_router.dart';
import 'package:pgw_sdk_example/utils/validator.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';
import 'package:pgw_sdk_example/widgets/custom_dropdown.dart';
import 'package:pgw_sdk_example/widgets/custom_submit_button.dart';

class PaymentOptionDetailsFormPage extends StatefulWidget {
  const PaymentOptionDetailsFormPage({Key? key}) : super(key: key);

  @override
  _PaymentOptionDetailsFormPageState createState() => _PaymentOptionDetailsFormPageState();
}

class _PaymentOptionDetailsFormPageState extends State<PaymentOptionDetailsFormPage> {
  late PaymentOptionDetailsInteractor _interactor;
  late PaymentOptionDetailsRouter _router;
  GlobalKey<FormState> _form = GlobalKey();
  String? _groupCodeName, _categoryCodeName;
  List<String> _categoryCodeList = CategoryCode.values.map((e) => e.name).toList();
  List<String> _groupCodeList = [];
  bool isValid = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _interactor = PaymentOptionDetailsInteractor(context);
    _router = PaymentOptionDetailsRouter(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Option Details'),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
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
                    label: 'Category Code',
                    value: _categoryCodeName,
                    items: _categoryCodeList,
                    onChanged: (value) {
                      _categoryCodeName = value;
                      _groupCodeName = null;
                      _groupCodeList = CategoryCode.values
                          .where((CategoryCode e) => e.name == value)
                          .first
                          .availableGroupCodes
                          .map((GroupCode e) => e.name)
                          .toList();
                    },
                    validator: Validator.validDropdown,
                  ),
                  SizedBox(height: 20),
                  CustomDropdown(
                    label: 'Group Code',
                    value: _groupCodeName,
                    items: _groupCodeList,
                    onChanged: (value) {
                      _groupCodeName = value;
                    },
                    enabled: _categoryCodeName != null,
                    validator: Validator.validDropdown,
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 40),
                  CustomSubmitButton(
                    label: 'View payment option details',
                    onPressed: () {
                      CategoryCode categoryCode = CategoryCode.values.where((e) => e.name == _categoryCodeName).first;
                      GroupCode groupCode = GroupCode.values.where((e) => e.name == _groupCodeName).first;
                      _router.toPaymentOptionDetailsPage(categoryCode: categoryCode, groupCode: groupCode);
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
