import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart'
    show
        WebViewWidget,
        WebViewController,
        JavaScriptMode,
        NavigationDelegate,
        NavigationRequest,
        NavigationDecision;

class WebPayPage extends StatelessWidget {
  final String paymentUrl;

  const WebPayPage({super.key, required this.paymentUrl});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
        
          onNavigationRequest: (NavigationRequest request) {
              Navigator.pop(
                context,
                true,
              ); // Return to previous screen with success
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(paymentUrl));
    return Scaffold(
      appBar: AppBar(title:  Text(LocaleKeys.checkout_payment.tr())),
      body: WebViewWidget(controller: controller),
    );
  }
}
