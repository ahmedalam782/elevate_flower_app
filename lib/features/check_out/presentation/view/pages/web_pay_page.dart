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
      appBar: AppBar(title: const Text('Payment')),
      body: WebViewWidget(controller: controller),
    );
  }
}
