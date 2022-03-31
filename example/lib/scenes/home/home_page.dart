import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
import 'package:pgw_sdk_example/models/enums/sdk_api_type.dart';
import 'package:pgw_sdk_example/scenes/home/home_interactor.dart';
import 'package:pgw_sdk_example/scenes/home/home_router.dart';
import 'package:pgw_sdk_example/widgets/dialog_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeInteractor _interactor;
  late HomeRouter _router;

  String _platformVersion = 'Unknown';

  List<String> _sdkApiTitles = [
    'Payment Option',
    'Payment Option Detail',
    'Do Payment',
    'Transaction Status Inquiry',
    'PGW Initialization',
    'Card Tokens Information',
    'Exchange Rate',
    'User Preference',
    'Payment Notification',
    'Cancel Transaction',
  ];

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await PGWSDK.sdkVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  void initState() {
    super.initState();
    _interactor = HomeInteractor(context);
    _router = HomeRouter(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFFE5E5E5),
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// 2C2P Logo
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(30),
                  child: Image.asset(
                    'assets/images/logo_green.png',
                    width: 110,
                  ),
                ),

                /// Body
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Payment Methods',
                              style: TextStyle(
                                color: Color(0xFF064F5C),
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                        thickness: 0.5,
                      ),

                      /// Payment Methods
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _iconPayment(
                              iconPath: 'assets/icons/ic_credit_card.png',
                              title: 'Credit/Debit\nCard',
                              onTap: () {
                                _interactor.creditCardPayment();
                              },
                            ),
                            _iconPayment(
                              iconPath: 'assets/icons/ic_internet_banking.png',
                              title: 'Internet\nBanking',
                              onTap: () {
                                _router.toInternetBankingPage();
                              },
                            ),
                            _iconPayment(
                              iconPath: 'assets/icons/ic_qr_code.png',
                              title: 'QR\nPayment',
                              onTap: () {
                                DialogView.show(
                                  context,
                                  title: 'Coming Soon',
                                  message: 'Please check future releases for upcoming QR Payment examples',
                                );
                                //_router.toQRPaymentPage();
                              },
                            ),
                            _iconPayment(
                              iconPath: 'assets/icons/ic_over_the_counter.png',
                              title: 'Over the\nCounter',
                              onTap: () {
                                _router.toOverTheCounterPage();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _iconPayment(
                              iconPath: 'assets/icons/ic_credit_card.png',
                              title: 'Stored Card',
                              onTap: () {
                                _interactor.paymentWithCardToken();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'SDK API',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color(0xFF064F5C),
                            fontSize: 16,
                          ),
                        ),
                        Divider(
                          height: 30,
                          thickness: 0.5,
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: SDKAPIType.values.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(SDKAPIType.values[index].name),
                                trailing: Icon(Icons.arrow_forward_ios_sharp),
                                onTap: () {
                                  DialogView.show(
                                    context,
                                    title: 'Coming Soon',
                                    message: 'Please check future releases for upcoming SDK API option examples',
                                  );
                                  // switch (SDKAPIType.values[index]) {
                                  //   case SDKAPIType.paymentOptions:
                                  //     _router.toPaymentOptionsPage();
                                  //     break;
                                  //   case SDKAPIType.paymentOptionDetails:
                                  //     _router.toPaymentOptionDetailsPage();
                                  //     break;
                                  //   case SDKAPIType.doPayment:
                                  //     _router.toDoPaymentPage();
                                  //     break;
                                  //   case SDKAPIType.transactionStatusInquiry:
                                  //     _router.toTransactionStatusInquiryPage(_interactor.paymentToken);
                                  //     break;
                                  //   case SDKAPIType.pgwInitialization:
                                  //     _router.toPGWInitializationPage();
                                  //     break;
                                  //   case SDKAPIType.cardTokensInformation:
                                  //     _router.toCardTokensInformationPage();
                                  //     break;
                                  //   case SDKAPIType.exchangeRate:
                                  //     _router.toExchangeRatePage();
                                  //     break;
                                  //   case SDKAPIType.userPreference:
                                  //     _router.toUserPreferencePage();
                                  //     break;
                                  //   case SDKAPIType.paymentNotification:
                                  //     _router.toPaymentNotificationPage();
                                  //     break;
                                  //   case SDKAPIType.cancelTransaction:
                                  //     _router.toCancelTransactionPage();
                                  //     break;
                                  // }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconPayment({
    required String iconPath,
    required String title,
    Function? onTap,
  }) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        child: Column(
          children: [
            Image.asset(
              iconPath,
              width: 40,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
