import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late final WebViewController _controller;
  int _progress = 0;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            // progress is from 0 to 100
            setState(() {
              _progress = progress;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://morth.nic.in/sites/default/files/dd12-13_0.pdf'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_progress < 100)
            LinearProgressIndicator(
              value: _progress / 100.0,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
          if (_progress < 100)
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Loading $_progress%',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
