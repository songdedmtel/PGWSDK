import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk/models/payment_option_detail/payment_option_detail_response.dart';
import 'package:pgw_sdk/ui/constants/colours.dart';
import 'package:pgw_sdk_example/constant/styles.dart';
import 'package:pgw_sdk_example/models/enums/category_code.dart';
import 'package:pgw_sdk_example/models/enums/group_code.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_option_details/payment_option_details_interactor.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_option_details/payment_option_details_router.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';

class PaymentOptionDetailsPage extends StatefulWidget {
  const PaymentOptionDetailsPage({Key? key, required this.categoryCode, required this.groupCode}) : super(key: key);
  final CategoryCode categoryCode;
  final GroupCode groupCode;
  @override
  _PaymentOptionDetailsPageState createState() => _PaymentOptionDetailsPageState();
}

class _PaymentOptionDetailsPageState extends State<PaymentOptionDetailsPage> {
  late PaymentOptionDetailsInteractor _interactor;
  late PaymentOptionDetailsRouter _router;
  String? _name;
  String? _iconUrl;
  List<PaymentChannel>? _channels;
  CommonValidation? _validation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _interactor = PaymentOptionDetailsInteractor(context);
      _router = PaymentOptionDetailsRouter(context);
      await _interactor
          .doCallPaymentOptionDetails(categoryCode: widget.categoryCode, groupCode: widget.groupCode)
          .then((value) => {_name = value.name, _iconUrl = value.iconUrl, _validation = value.validation, _channels = value.channels});
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Option Details'),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 5,
              ),
            ],
          ),
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                _iconUrl != null ? Image.network(_iconUrl!, height: 75) : Container(),
                SizedBox(width: 10),
                Text(
                  _name ?? '',
                  style: textHeader,
                ),
              ]),
              SizedBox(height: 10),
              Text('Card Number Validation', style: textHeader),
              Divider(height: 30, thickness: 1, color: primaryColor),
              _validation?.cardNo?.prefixes != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prefixes'),
                        SizedBox(
                            width: 200,
                            child: Text(
                              _validation!.cardNo!.prefixes?.join(' ') ?? '',
                              textAlign: TextAlign.end,
                            )),
                      ],
                    )
                  : Container(),
              SizedBox(height: 10),
              _validation?.cardNo?.prefixes != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Regex'),
                        SizedBox(
                            width: 200,
                            child: Text(
                              _validation!.cardNo!.regex ?? '',
                              textAlign: TextAlign.end,
                            )),
                      ],
                    )
                  : Container(),
              SizedBox(height: 70),
              Text('Card Type Validation', style: textHeader),
              Divider(height: 30, thickness: 1, color: primaryColor),
              _validation?.cardTypes != null
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _validation!.cardTypes!.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(_validation!.cardTypes!.elementAt(index).iconUrl!, height: 40),
                              SizedBox(width: 10),
                              Text(('${_validation!.cardTypes!.elementAt(index).name}'), style: textSubHeader),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Prefixes'),
                              SizedBox(
                                  width: 200,
                                  child: Text(
                                    _validation!.cardTypes!.elementAt(index).prefixes?.join(' ') ?? '',
                                    textAlign: TextAlign.end,
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Regex'),
                              SizedBox(
                                  width: 200,
                                  child: Text(
                                    _validation!.cardTypes!.elementAt(index).regex ?? '',
                                    textAlign: TextAlign.end,
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      separatorBuilder: (context, index) => Divider(height: 30, thickness: 0.5, color: Colors.grey.shade600),
                    )
                  : Container(),
              SizedBox(height: 40),
              Text('Channels', style: textHeader),
              Divider(height: 30, thickness: 1, color: primaryColor),
              _channels != null
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _channels?.length ?? 0,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(_channels!.elementAt(index).iconUrl!, height: 40),
                              SizedBox(width: 10),
                              Text(('${_channels!.elementAt(index).name}'), style: textSubHeader),
                            ],
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => Divider(height: 30, thickness: 0.5, color: Colors.grey.shade600),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
