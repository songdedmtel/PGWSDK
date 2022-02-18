import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgw_sdk/ui/constants/colours.dart';
import 'package:pgw_sdk/ui/scenes/credit_card/credit_card_interactor.dart';
import 'package:pgw_sdk/ui/scenes/credit_card/credit_card_router.dart';
import 'package:pgw_sdk/ui/utils/input_formatters.dart';
import 'package:pgw_sdk/ui/widgets/text_field_custom.dart';

class CreditCardPage extends StatefulWidget {
  CreditCardPage({required this.paymentToken});

  final String paymentToken;

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  late CreditCardInteractor _interactor;
  late CreditCardRouter _router;

  bool _storedCard = false;

  @override
  void initState() {
    super.initState();

    _interactor = CreditCardInteractor(context);
    _router = CreditCardRouter(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
      child: Form(
        key: _interactor.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Card Number'),
            ),
            SizedBox(height: 8),
            TextFieldCustom(
              controller: _interactor.cardNumberController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) => value == null || value.isEmpty ? 'Card Number is required' : null,
              formatters: [
                LengthLimitingTextInputFormatter(22),
                FilteringTextInputFormatter.digitsOnly,
                CardNumberInputFormatter(),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Expire Date'),
                      ),
                      SizedBox(height: 8),
                      TextFieldCustom(
                        controller: _interactor.expController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) => value == null || value.isEmpty ? 'Expire Date is required' : null,
                        formatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly,
                          CardMonthInputFormatter(),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('CVV'),
                      ),
                      SizedBox(height: 8),
                      TextFieldCustom(
                        controller: _interactor.cvvController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        validator: (value) => value == null || value.isEmpty ? 'CVV is required' : null,
                        formatters: [
                          LengthLimitingTextInputFormatter(3),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Card Holder'),
            ),
            SizedBox(height: 8),
            TextFieldCustom(
              controller: _interactor.cardHolderController,
              validator: (value) => value == null || value.isEmpty ? 'Card Holder is required' : null,
              formatters: [
                LengthLimitingTextInputFormatter(50),
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text('Save card data for future payments'),
                ),
                Switch(
                  value: _storedCard,
                  onChanged: (value) {
                    setState(() {
                      _storedCard = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Proceed'),
                onPressed: () async {
                  _interactor.onClickProceed(widget.paymentToken, _storedCard);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
