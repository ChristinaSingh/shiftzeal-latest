import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_models/get_completed_shifts_history_model.dart';
import 'package:shiftzeal/common/navigation_methos.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';
import '../report/report_screen.dart';
import '../track_time/track_time_screen.dart';

class MyHoursController extends ChangeNotifier {
  List<CompletedShiftsData> completedShifts = [];

  /// Loading state
  bool inAsyncCall = false;

  /// Sample schedule list (static data)
  final List<Map<String, String>> scheduleList = List.generate(
    4,
        (index) => {
      "date": "Tue, May 21",
      "time": "8:00a–4:00p as DSP",
      "location": "at Avalon 2",
    },
  );

  /// Navigate to report screen when tile is clicked
  void clickOnTile({
    required int index,
    required int index2,
    required BuildContext context,
  }) {
    NavigationMethods.pushMethod(context: context, widget: ReportScreen());
  }

  /// Navigate to TrackTime screen
  void clickOnTrackTimeIcon({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: TrackTimeScreen());
  }

  /// Fetch completed shifts from API
  Future<void> getCompletedShifts({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners(); // Start loading

    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

      final bodyParam = {ApiKeyConstants.userId: userId};

      GetCompletedShiftModel? getCompletedShiftModel =
      await ApiMethods.getCompletedShiftsData(
        context: context,
        bodyParams: bodyParam,
      );

      if (getCompletedShiftModel != null &&
          getCompletedShiftModel.status != null &&
          getCompletedShiftModel.status != "0") {
        completedShifts = getCompletedShiftModel.data ?? [];
      } else {
        completedShifts.clear();
        final msg = getCompletedShiftModel?.message ?? "Something went wrong";
        CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
      completedShifts.clear();
    } finally {
      inAsyncCall = false;
      notifyListeners(); // Stop loading
    }
  }
}
