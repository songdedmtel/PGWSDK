import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw_sdk/models/payment_option/payment_option_response.dart';
import 'package:pgw_sdk/ui/constants/colours.dart';
import 'package:pgw_sdk_example/constant/styles.dart';
import 'package:pgw_sdk_example/models/enums/country_code.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_options/payment_options_interactor.dart';
import 'package:pgw_sdk_example/scenes/sdk_api/payment_options/payment_options_router.dart';
import 'package:pgw_sdk_example/widgets/custom_appbar.dart';

class PaymentOptionsPage extends StatefulWidget {
  const PaymentOptionsPage({Key? key, required this.countryCode}) : super(key: key);
  final CountryCode countryCode;
  @override
  _PaymentOptionsPageState createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {
  late PaymentOptionsInteractor _interactor;
  late PaymentOptionsRouter _router;
  MerchantInfo? merchantInfo;
  List<PaymentChannelCategory>? channels;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _interactor = PaymentOptionsInteractor(context);
      _router = PaymentOptionsRouter(context);
      await _interactor
          .doCallPaymentOptions(countryCode: widget.countryCode)
          .then((value) => {merchantInfo = value.merchantInfo, channels = value.channels});
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Options'),
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
              merchantInfo?.logoUrl != null ? Image.network(merchantInfo!.logoUrl!) : Container(),
              SizedBox(height: 20),
              Text('Merchant Info', style: textHeader),
              Divider(height: 30, color: primaryColor, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Merchant ID'), Text(merchantInfo?.id ?? '')],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Name'), Text(merchantInfo?.name ?? '')],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Email'), Text(merchantInfo?.email ?? '')],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Address'), Text(merchantInfo?.address ?? '')],
              ),
              SizedBox(height: 40),
              Text('Channels', style: textHeader),
              Divider(height: 30, thickness: 1, color: primaryColor),
              channels != null
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: channels?.length ?? 0,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(('${channels!.elementAt(index).name} (${channels!.elementAt(index).code})'), style: textSubHeader),
                          SizedBox(height: 10),
                          for (PaymentChannelGroup i in channels!.elementAt(index).groups!) Text(i.name!),
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
