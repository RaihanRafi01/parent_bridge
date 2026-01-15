import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/widgets/custom_snackbar.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  late final String successUrl = 'https://yourdomain.com/wallet/success';
  late final String cancelUrl = 'https://yourdomain.com/wallet/cancel';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.liteGreenBg)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optionally show progress
            debugPrint('WebView loading progress: $progress%');
          },
          onPageStarted: (String url) {
            debugPrint('WebView page started: $url');
          },
          onPageFinished: (String url) {
            debugPrint('WebView page finished: $url');
            if (url.startsWith(successUrl)) {
              Get.back();
              kSnackBar(
                title: 'Success',
                message: 'Payment completed successfully!',
                bgColor: AppColors.appColor,
              );
            } else if (url.startsWith(cancelUrl)) {
              Get.back();
              kSnackBar(
                title: 'Payment Cancelled',
                message: 'The payment was cancelled.',
                bgColor: AppColors.snackBarWarning,
              );
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('WebView navigation request: ${request.url}');
            if (request.url.startsWith(successUrl)) {
              Get.back();
              kSnackBar(
                title: 'Success',
                message: 'Payment completed successfully!',
                bgColor: AppColors.appColor,
              );
              return NavigationDecision.prevent;
            } else if (request.url.startsWith(cancelUrl)) {
              Get.back();
              kSnackBar(
                title: 'Payment Cancelled',
                message: 'The payment was cancelled.',
                bgColor: AppColors.snackBarWarning,
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 20.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
            kSnackBar(
              title: 'Payment Cancelled',
              message: 'The payment was cancelled.',
              bgColor: AppColors.snackBarWarning,
            );
          },
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
