import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddShiftController extends ChangeNotifier {
  clickOnSaveButton({required BuildContext context}) {}

  int selectedIndex = -1;
  List<String> shifts = [
    '12:00a - 8:00a\nas Dsp',
    '8:00a - 4:00p\nas Dsp',
    '4:00p - 12:00a\nas Dsp',
    '12:00a - 8:00a\nas Dsp',
    '8:00a - 4:00p\nas Dsp',
    '4:00p - 12:00a\nas Dsp',
    '12:00a - 8:00a\nas Dsp',
    '8:00a - 4:00p\nas Dsp',
    '4:00p - 12:00a\nas Dsp',
  ];
}
