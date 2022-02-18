import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pgw_sdk/ui/constants/colours.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  WebviewPage({required this.url});

  final String url;

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(widget.url);
    return Scaffold(
      appBar: AppBar(
        // title: Text('2c2p'),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: primaryColor),
        actionsIconTheme: IconThemeData(color: primaryColor),
        elevation: 0,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '2c2p\n',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
            children: <TextSpan>[
              TextSpan(
                text: uri.host,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        // actions: [
        //   NavigationControls(controller: controller),
        // ],
      ),
      body: Column(
        children: [
          Container(color: Colors.grey, height: 0.5),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (webViewController) {
                controller.complete(webViewController);
              },
            ),
          ),
        ],
      ),
    );
  }
}
