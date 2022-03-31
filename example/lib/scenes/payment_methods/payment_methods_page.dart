import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgw_sdk_example/constant/styles.dart';
import 'package:pgw_sdk_example/models/payment_channel.dart';
import 'package:pgw_sdk_example/models/token_response.dart';
import 'package:pgw_sdk_example/scenes/webview/webview_page.dart';
import 'package:pgw_sdk_example/utils/string_helper.dart';
import 'package:pgw_sdk_example/utils/transaction.dart';
import 'package:pgw_sdk_example/utils/validator.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';
import 'package:pgw_sdk_example/widgets/custom_submit_button.dart';
import 'package:pgw_sdk_example/widgets/custom_textfield.dart';
import 'package:pgw_sdk_example/widgets/dialog_view.dart';

class PaymentMethodsPage extends StatefulWidget {
  String title;
  List<PaymentChannel> paymentAgentList;
  String paymentChannel;

  PaymentMethodsPage({required this.title, required this.paymentAgentList, required this.paymentChannel});
  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  GlobalKey<FormState> _form = GlobalKey();
  String? _firstName, _lastName, _email, _mobileNo;
  late List<PaymentChannel> _paymentAgentList;
  late String _paymentChannel;
  bool isValid = false;
  int selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentAgentList = widget.paymentAgentList;
    _paymentChannel = widget.paymentChannel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
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
                  CustomTextField(
                    label: 'First name',
                    onChanged: (value) => setState(() {
                      _firstName = value;
                    }),
                    formatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'Last name',
                    onChanged: (value) => setState(() {
                      _lastName = value;
                    }),
                    formatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'Email',
                    onChanged: (value) => setState(() {
                      _email = value;
                    }),
                    formatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'Mobile No.',
                    onChanged: (value) => setState(() {
                      _mobileNo = value;
                    }),
                    formatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    validator: Validator.validMobileNo,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 10),
                    child: Text('Select Payment Agent'),
                  ),
                  Center(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ..._paymentAgentList.map((element) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectedIndex == _paymentAgentList.indexOf(element) ? Color(0xFF82A7AD) : Colors.transparent,
                              ),
                              height: 80,
                              width: 80,
                              child: TextButton(
                                style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: element.logo != null
                                      ? Image.asset(
                                          'assets/logos/${element.logo}',
                                        )
                                      : Container(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            '${element.name}',
                                            style: textParagraph,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = _paymentAgentList.indexOf(element);
                                  });
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  CustomSubmitButton(
                      label: 'Proceed',
                      onPressed: () async {
                        if (selectedIndex == -1) {
                          DialogView.show(
                            context,
                            title: 'Payment channel required',
                            message: 'Please select a payment channel before proceeding',
                          );
                          return;
                        }
                        if (_form.currentState!.validate()) {
                          PaymentChannel _selectedChannel = _paymentAgentList[selectedIndex];
                          String payload = Transaction.encodePayload(
                            merchantId: 'JT04',
                            invoiceNo: StringHelper.generateInvoiceNo(),
                            description: 'Example Description',
                            amount: 10.0,
                            currencyCode: 'THB',
                            nonceStr: 'a8092512-b144-41b0-8284-568bb5e9264c',
                            paymentChannel: _paymentChannel,
                            merchantKey: 'CD229682D3297390B9F66FF4020B758F4A5E625AF4992E5D75D311D6458B38E2',
                          );

                          TokenResponse tokenResponse = await Transaction.getToken(payload: payload);

                          Transaction.proceed(
                            paymentChannel: _paymentChannel,
                            firstName: _firstName,
                            lastName: _lastName,
                            email: _email,
                            mobileNo: _mobileNo,
                            channelCode: _selectedChannel.channelCode,
                            agentCode: _selectedChannel.agentCode,
                            paymentToken: tokenResponse.paymentToken,
                          ).then(
                              (value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WebviewPage(url: value.data!))));
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
