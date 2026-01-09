import 'package:flutter/material.dart';

class PdfViewerProvider with ChangeNotifier {
  String _pdfUrl = 'https://server-php-8-3.technorizen.com/ShiftRoster/public/uploads/users/68adb65143043_1756214865.pdf';

  String get pdfUrl => _pdfUrl;

  void setPdfUrl(String url) {
    _pdfUrl = url;
    notifyListeners();
  }
}
