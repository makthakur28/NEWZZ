// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webviewwidget extends StatefulWidget {
  final String webUrl;
  const Webviewwidget({
    super.key,
    required this.webUrl,
  });

  @override
  State<Webviewwidget> createState() => _WebviewwidgetState();
}

class _WebviewwidgetState extends State<Webviewwidget> {
  // late final _controller;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  bool isLoading = true;
  String url = '';
  @override
  void initState() {
    super.initState();
    if (widget.webUrl.contains('http://')) {
      url = widget.webUrl.replaceAll('http://', 'https://');
    } else {
      url = widget.webUrl;
    }
    isLoading = true;
    // if (WebViewPlatform.instance == null) {
    //   if (defaultTargetPlatform == TargetPlatform.android) {
    //     WebViewPlatform.instance = AndroidWebViewPlatform();
    //   } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    //     WebViewPlatform.instance = WebKitWebViewPlatform();
    //   }
    // }

    // _controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.disabled)
    //   ..loadRequest(Uri.parse(widget.webUrl));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Got URL HERE : $url');
    return Scaffold(
        appBar: AppBar(),
        body: Hero(
          tag: 'Card${widget.webUrl}',
          child: Container(
            // height: 500,
            // color: Color.fromARGB(255, 0, 107, 195),
            child: Stack(
              children: [
                WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  // onPageStarted: (url) {
                  //   setState(() {
                  //     isLoading = true;
                  //   });
                  // },
                  onPageFinished: (url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  // onProgress: (progress) => const CircularProgressIndicator(),
                  onWebViewCreated: (WebViewController webViewController) {
                    // isLoading = false;
                    setState(() {
                      controller.complete(webViewController);
                    });
                  },
                ),
                if (isLoading) const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ));
  }
}
