import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/time_card_entry/time_card_entry_screen.dart';

class PayPeriodsController extends ChangeNotifier {
  List<Map<String, dynamic>> list = [
    {
      'title': '2023',
      'list': [
        'Aug 18-31',
        'Aug 4-17',
        'Jul 21-Aug 3',
        'Jul 7-20',
        'Jun 23-Jul 6',
        'Jun 9-22',
        'May 26-Jun 8'
      ]
    },
    {
      'title': '2024',
      'list': ['Aug 18-31', 'Aug 4-17', 'Jul 21-Aug 3']
    }
  ];

  clickOnRow({required BuildContext context, required int index}) {
    NavigationMethods.pushMethod(
        context: context, widget: TimeCardEntryScreen());
  }

  DateTime fromDate = DateTime(2024, 11, 1);
  DateTime toDate = DateTime(2024, 11, 30);

  final List<Map<String, dynamic>> shifts = List.generate(
      4,
      (index) => {
            'shift': '8:00 AM – 4:00 PM At Avalon 2 as DSP',
            'hours': 8,
            'pay': 100.00,
            'date': '01/11/2023 Morning',
          });

  String formatCustomDate(DateTime date) {
    return DateFormat("dd MMM yy").format(date); // Example: 01_Nov_24
  }

  Future<void> selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).colorScheme.secondary,
            // header background color
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor, // header text color
              onPrimary: Colors.white, // selected day text color
              onSurface: Colors.black, // default text color
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context)
                    .colorScheme
                    .secondary, // Button text color
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isFromDate) {
        fromDate = picked;
      } else {
        toDate = picked;
      }
      notifyListeners();
    }
  }
}
