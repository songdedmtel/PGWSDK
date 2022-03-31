import 'package:flutter/material.dart';
import 'package:pgw_sdk/models/transaction_status/transaction_status_response.dart';
import 'package:pgw_sdk_example/constant/colours.dart';
import 'package:pgw_sdk_example/constant/styles.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/transaction_status_inquiry/transaction_status_inquiry_interactor.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/transaction_status_inquiry/transaction_status_inquiry_router.dart';

class TransactionStatusInquiryPage extends StatefulWidget {
  TransactionStatusInquiryPage({required this.paymentToken}) : super();

  final String paymentToken;

  @override
  _TransactionStatusInquiryPageState createState() => _TransactionStatusInquiryPageState();
}

class _TransactionStatusInquiryPageState extends State<TransactionStatusInquiryPage> {
  late TransactionStatusInquiryInteractor _interactor;
  late TransactionStatusInquiryRouter _router;

  Future<TransactionStatusResponse?>? _futureResponse;

  @override
  void initState() {
    super.initState();

    _interactor = TransactionStatusInquiryInteractor(context);
    _router = TransactionStatusInquiryRouter(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xFFE5E5E5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 2C2P Logo
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.arrow_back, color: primaryColor),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 20),
                    Text('Transaction Status Inquiry', style: textTitle),
                  ],
                ),
              ),

              /// View
              Expanded(
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: FutureBuilder(
                      future: _futureResponse,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: _inquiryView(snapshot.data as TransactionStatusResponse),
                          );
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Container(
                                  child: Image.asset(
                                    'assets/icons/ic_transaction.png',
                                    height: 80,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Container(
                                  child: Text(
                                    'Get status and information\nfrom last transaction',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20),
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
                                      setState(() {
                                        _futureResponse = _interactor.proceed(widget.paymentToken);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inquiryView(TransactionStatusResponse response) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 13,
        itemBuilder: (BuildContext context, int index) {
          final label =
              (index < _interactor.labelsMerchantInfo.length) ? _interactor.labelsMerchantInfo[index] : _interactor.labelsTransactionInfo[index - 5];
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (index == 0)
                    ? Container(
                        padding: EdgeInsets.only(top: 20, bottom: 8),
                        child: Text('Merchant Info', style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    : Container(),
                (index == 6)
                    ? Container(
                        padding: EdgeInsets.only(top: 20, bottom: 8),
                        child: Text('Transaction Info', style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    : Container(),
                Row(
                  children: [
                    Text(label),
                    Expanded(
                      child: Text(
                        (index < _interactor.labelsMerchantInfo.length)
                            ? _interactor.getMerchantInfoFrom(index, response)
                            : _interactor.getTransactionInfoFrom(index - 5, response),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
