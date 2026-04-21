import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebViewScreen extends StatefulWidget {
  const PaymobWebViewScreen({super.key, required this.paymentUrl});

  final String paymentUrl;

  @override
  State<PaymobWebViewScreen> createState() => _PaymobWebViewScreenState();
}

class _PaymobWebViewScreenState extends State<PaymobWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // Paymob redirects to this URL on success/fail
            if (request.url.contains('transaction_id')) {
              final uri = Uri.parse(request.url);
              final success = uri.queryParameters['success'];
              if (success == 'true') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.congrates,
                  (route) =>
                      route.settings.name == AppRoutes.bottomNavBarScreen,
                );
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment failed. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      appBar: AppBar(
        backgroundColor: context.appColors.background,
        elevation: 0,
        leading: const BackButton(),
        title: Text(
          'Secure Payment',
          style: TextStyle(color: context.appColors.textPrimary),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
