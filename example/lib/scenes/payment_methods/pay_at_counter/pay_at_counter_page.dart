import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgw_sdk_example/constant/colours.dart';
import 'package:pgw_sdk_example/constant/styles.dart';
import 'package:pgw_sdk_example/models/channels/pay_at_counter.dart';
import 'package:pgw_sdk_example/models/enums/agent_channel_code.dart';
import 'package:pgw_sdk_example/models/enums/country_code.dart';
import 'package:pgw_sdk_example/models/payment_channel.dart';
import 'package:pgw_sdk_example/utils/transaction.dart';
import 'package:pgw_sdk_example/utils/validator.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';
import 'package:pgw_sdk_example/widgets/custom_dropdown.dart';
import 'package:pgw_sdk_example/widgets/custom_textfield.dart';

class PayAtCounterPage extends StatefulWidget {
  @override
  _PayAtCounterPageState createState() => _PayAtCounterPageState();
}

class _PayAtCounterPageState extends State<PayAtCounterPage> {
  GlobalKey<FormState> _form = GlobalKey();
  String? _firstName, _lastName, _email, _mobileNo, _country, _agent;
  List<String> _countryList = ['Thailand', 'Myanmar', 'Indonesia', 'Malaysia', 'Phillipines'];
  List<String> _paymentAgentList = [];
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Pay at Counter'),
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
                  customDropdown(
                    label: 'Country',
                    hintText: 'Select country',
                    value: _country,
                    items: _countryList,
                    onChanged: (value) {
                      _country = value;
                      _agent = null;
                      _paymentAgentList = payAtCounterList.where((PaymentChannel e) => e.countryCode!.name == _country).map((e) => e.name).toList();
                    },
                    validator: Validator.validDropdownCountry,
                  ),
                  SizedBox(height: 20),
                  customDropdown(
                    label: 'Payment Agent',
                    hintText: 'Select payment agent',
                    value: _agent,
                    items: _paymentAgentList,
                    onChanged: (value) {
                      _agent = value;
                    },
                    enabled: _country != null,
                    validator: Validator.validDropdownAgent,
                  ),
                  SizedBox(height: 20),
                  customTextField(
                    label: 'First name',
                    validator: Validator.validName,
                    onChanged: (value) => setState(() {
                      _firstName = value;
                    }),
                    formatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                  ),
                  SizedBox(height: 20),
                  customTextField(
                    label: 'Last name',
                    validator: Validator.validName,
                    onChanged: (value) => setState(() {
                      _lastName = value;
                    }),
                    formatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                  ),
                  SizedBox(height: 20),
                  customTextField(
                    label: 'Email',
                    validator: Validator.validEmail,
                    onChanged: (value) => setState(() {
                      _email = value;
                    }),
                    formatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                  ),
                  SizedBox(height: 20),
                  customTextField(
                    label: 'Mobile No.',
                    validator: Validator.validMobileNo,
                    onChanged: (value) => setState(() {
                      _mobileNo = value;
                    }),
                    formatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Proceed',
                        style: textHeaderInverse,
                      ),
                      onPressed: () async {
                        print(_country);
                        if (_form.currentState!.validate()) {
                          print(_country);
                          print(_agent);
                          print(_firstName);
                          print(_lastName);
                          print(_mobileNo);
                          print(_email);
                          CountryCode _countryCode = CountryCode.values.where((CountryCode e) => e.name == _country).first;
                          PaymentChannel _agentChannel = payAtCounterList.where((PaymentChannel e) => e.name == _agent).first;
                          print(_countryCode);
                          String payload = Transaction.encodePayload(
                            merchantId: _countryCode.merchantId,
                            invoiceNo: (Random().nextInt(3000000000) + 1000000000).toString(),
                            description: "Example Description",
                            amount: 10.0,
                            currencyCode: _countryCode.currencyCode,
                            nonceStr: "a8092512-b144-41b0-8284-568bb5e9264c",
                            paymentChannel: "COUNTER",
                            merchantKey: _countryCode.merchantSecretKey,
                          );

                          String token = await Transaction.getToken(payload: payload);

                          Transaction.proceed(
                            firstName: _firstName,
                            lastName: _lastName,
                            email: _email,
                            mobileNo: _mobileNo,
                            agentCode: _agentChannel.agentCode,
                            agentChannelCode: _agentChannel.agentChannelCode == AgentChannelCode.OVERTHECOUNTER ? 'OVERTHECOUNTER' : 'BANKCOUNTER',
                            token: token,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
