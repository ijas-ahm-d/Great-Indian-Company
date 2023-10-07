import 'package:flutter/material.dart';
import 'package:great_gpt/utils/constants.dart';
import 'package:great_gpt/utils/global_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  int loadingPercentage = 0;
  final controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kblack,
      body: WillPopScope(
        child: SafeArea(
          child: WebViewWidget(
              controller: controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(
            AppColors.kblack,
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (progress) {
                setState(() {
                  loadingPercentage = progress;
                });
              },
              onPageStarted: (url) {
                setState(() {
                  loadingPercentage = 0;
                });
              },
              onPageFinished: (String url) {
                loadingPercentage = 100;
              },
              onNavigationRequest: (NavigationRequest request) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebViewScreen(),
                  ),
                );
                return NavigationDecision.prevent;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(Constants.url),
          ),
            ),
        ),
        onWillPop: () {
          return exitApp(context);
        },
      ),
    );
  }

  Future<bool> exitApp(BuildContext context) async {
    bool? exitApp = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Are you sure?',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            "Do you want to exit the app",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
    return exitApp ?? false;
  }
}
