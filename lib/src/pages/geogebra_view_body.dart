import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalHtmlViewer extends StatefulWidget {
  const LocalHtmlViewer({super.key, required this.urlToLaunch});
  final String urlToLaunch;

  @override
  State<LocalHtmlViewer> createState() => _LocalHtmlViewerState();
}

class _LocalHtmlViewerState extends State<LocalHtmlViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Libro Geogebra')),
      body: const WebView(
        initialUrl: 'https://www.geogebra.org/m/hg3femjc',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
