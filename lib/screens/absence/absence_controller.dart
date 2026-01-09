import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_models/get_absent_user_shifts_model.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/absence_report/absence_report_screen.dart';
import 'package:shiftzeal/screens/track_time/track_time_screen.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';

class AbsenceController extends ChangeNotifier {
  bool inAsyncCall = false; // Flag for loading state
  List<AbsentShiftsData> absentShifts = [];

  // Sample yearly list for UI
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

  // Sample schedule list for UI
  final List<Map<String, String>> scheduleList = List.generate(
    10,
        (index) => {
      "date": "Tue, May 21",
      "time": "8:00a–4:00p as DSP",
      "location": "at Avalon 2",
    },
  );

  /// Navigate to Absence Report Screen
  void clickOnTile({
    required int index,
    required int index2,
    required BuildContext context,
  }) {
    NavigationMethods.pushMethod(
      context: context,
      widget: AbsenceReportScreen(absentShiftsData: absentShifts[index],),
    );
  }

  /// Navigate to Track Time Screen
  void clickOnTrackTimeIcon({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: TrackTimeScreen(),
    );
  }

  /// Fetch absent shifts from API
  Future<void> getAbsentShifts({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners(); // Start loading

    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

      final bodyParam = {
        ApiKeyConstants.userId: userId,
      };

      GetAbsentShiftModel? getAbsentShiftModel =
      await ApiMethods.getAbsentShiftsData(
        context: context,
        bodyParams: bodyParam,
      );

      if (getAbsentShiftModel != null &&
          getAbsentShiftModel.status != null &&
          getAbsentShiftModel.status != "0") {
        absentShifts = getAbsentShiftModel.data ?? [];
      } else {
        absentShifts.clear();
        final msg = getAbsentShiftModel?.message ?? "Something went wrong";
        CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
      absentShifts.clear();
    } finally {
      inAsyncCall = false;
      notifyListeners(); // Stop loading
    }
  }
}
