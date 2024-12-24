import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../widgets/bars/app_bars/specific/view_call_app_bar.dart';

class ConferencePage extends StatelessWidget {
  final String conferenceName;

  const ConferencePage({super.key, required this.conferenceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CallAppBar(conference_name: conferenceName),
      body: WebView(
        initialUrl: 'https://example.com', 
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
