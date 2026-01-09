import 'package:flutter/material.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/pay_periods/pay_periods_screen.dart';

class TrackTimeController extends ChangeNotifier {
  int selectedYear = DateTime.now().year;

  final List<Map<String, dynamic>> leaveData = [
    {'date': '22/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '23/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '24/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '25/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '30/05/2023', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '31/05/2023', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '01/06/2023', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '02/06/2023', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '09/07/2023', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '22/05/2023', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '22/05/2023', 'type': 'Annual Leave', 'value': 1.0},
  ];

  void changeYear(int offset) {
    selectedYear += offset;
    notifyListeners();
  }

  clickOnTile(
      {required int index,
      required int index2,
      required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: PayPeriodsScreen());
  }
}
