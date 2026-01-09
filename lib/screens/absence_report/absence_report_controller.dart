import 'package:flutter/material.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/absence_report/absence_report_screen.dart';

class AbsenceReportController extends ChangeNotifier {
  List<Map<String, dynamic>> list = [
    {
      'title': '2023',
      'list': [
        'Tue, May 21',
        'Tue, May 22',
        'Tue, May 23',
      ]
    },
    {
      'title': '2024',
      'list': ['Tue, May 21', 'Tue, May 22', 'Tue, May 23']
    }
  ];

  // clickOnTile(
  //     {required int index,
  //     required int index2,
  //     required BuildContext context}) {
  //   NavigationMethods.pushMethod(context: context, widget: AbsenceReportScreen());
  // }
}
