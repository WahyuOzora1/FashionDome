import 'package:fashiondome/presentation/payment/payment_failed_page.dart';
import 'package:fashiondome/presentation/payment/payment_success_page.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class SnapWidget extends StatefulWidget {
  const SnapWidget({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  @override
  State<SnapWidget> createState() => _SnapWidgetState();
}

class _SnapWidgetState extends State<SnapWidget> {
  WebViewController? _controller;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // print("Progresss ini isinya apa : $progress");
          },
          onPageStarted: (String url) {
            // print('onPageStarted ini isinya apa: $url');
            if (url.contains('status_code=202&transaction_status=deny')) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const PaymentFailedPage();
              }));
            }
            if (url.contains('status_code=200&transaction_status=settlement')) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const PaymentSuccessPage();
              }));
            }
          },
          onPageFinished: (String url) {
            // print('onPageFiniush ini isinya apa: $url');
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller!),
    );
  }
}
