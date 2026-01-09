// import 'package:easy_date_timeline/easy_date_timeline.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shiftzeal/screens/my_hours/my_hours_screen.dart';
// import 'package:shiftzeal/screens/shift_details/shift_details_screen.dart';
//
// import '../../apis/api_constants/api_key_constants.dart';
// import '../../apis/api_methods/api_methods.dart';
// import '../../apis/api_models/get_my_shift_byDate_model.dart';
// import '../../common/common_widgets.dart';
// import '../../common/navigation_methos.dart';
//
// class ScheduleController extends ChangeNotifier {
//   int selectedValue = 0;
//   bool inAsyncCall = true;
//   List<DateWiseShiftData> dateWiseShiftList = [];
//   final EasyInfiniteDateTimelineController calender =
//       EasyInfiniteDateTimelineController();
//   DateTime focusDate = DateTime.now();
//
//   List<Map<String, String>> listOfData = [
//     {'title': 'MEMBER NAME', 'value': 'Jon Altomy'},
//     {'title': 'GROUP NAME', 'value': 'Zenefits Mobile Beta Test'},
//     {'title': 'GROUP ID', 'value': '24245818'},
//     {'title': 'EFFECTIVE DATE', 'value': 'May 1, 2016'},
//     {'title': 'PLAN', 'value': 'Gold PPO 750 80-50'},
//     {'title': 'RX BIN/PCN', 'value': '610502/00670000'},
//     {'title': 'DEPENDENTS', 'value': 'Johhny Testtest'},
//   ];
//
//   List<Map<String, String>> listOfDataAlert = [
//     {'title': 'Time-Off Request Status'},
//     {'title': 'Swap/Drop Requests'},
//     {'title': 'Open Shift Requests'},
//     {'title': 'Schedule Updates'},
//     {'title': 'Clock In/Out Reminders'},
//   ];
//   List<Map<String, String>> listOfDataAlert2 = [
//     {'title': 'Clock In/Out Reminders'},
//     {'title': 'Badge App Icon'},
//     {'title': 'In-App Notifications'},
//   ];
//
//   final List<Map<String, String>> data = [
//     {
//       "image": "https://randomuser.me/api/portraits/women/1.jpg",
//       "time": "7:00a–9:00a",
//       "date": "MON, AUG 19, 2024",
//       "description":
//           "Johan Smiths at 23-0617.1 M – Benchmark Construction – Portland, ME – Conroy-Tully Walker Funeral Home as Concrete Placement",
//     },
//     {
//       "image": "https://randomuser.me/api/portraits/men/2.jpg",
//       "time": "7:00a–9:00a",
//       "date": "MON, AUG 19, 2024",
//       "description":
//           "Johan Smiths at 23-0617.1 M – Benchmark Construction – Portland, ME – Conroy-Tully Walker Funeral Home as Concrete Placement",
//     },
//     {
//       "image": "https://randomuser.me/api/portraits/men/3.jpg",
//       "time": "7:00a–9:00a",
//       "date": "MON, AUG 19, 2024",
//       "description":
//           "Johan Smiths at 23-0617.1 M – Benchmark Construction – Portland, ME – Conroy-Tully Walker Funeral Home as Concrete Placement",
//     },
//     {
//       "image": "https://randomuser.me/api/portraits/women/4.jpg",
//       "time": "7:00a–9:00a",
//       "date": "MON, AUG 19, 2024",
//       "description":
//           "Johan Smiths at 23-0617.1 M – Benchmark Construction – Portland, ME – Conroy-Tully Walker Funeral Home as Concrete Placement",
//     },
//   ];
//
//   void changeDates(DateTime selectedDate) {
//     focusDate = selectedDate;
//     notifyListeners();
//   }
//
//   getUserTripApiMethod({required BuildContext context}) async {
//     inAsyncCall = true;
//     notifyListeners();
//     inAsyncCall = false;
//     notifyListeners();
//   }
//
//   clickOnTap({required int value}) {
//     selectedValue = value;
//     notifyListeners();
//   }
//
//   clickOnMyShiftCard({required BuildContext context, required int index}) {
//     NavigationMethods.pushMethod(
//         context: context,
//         widget: ShiftDetailsScreen(
//           shiftId: "!",
//         ));
//   }
//
//   clickOnTotalHours({required BuildContext context}) {
//     NavigationMethods.pushMethod(context: context, widget: MyHoursScreen());
//   }
//
//   Future<void> getDateWiseShifts({required BuildContext context}) async {
//     inAsyncCall = true;
//     notifyListeners();
//
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     String userId = sp.getString(ApiKeyConstants.userId) ?? "0";
//
//     try {
//       final bodyParam = {
//         ApiKeyConstants.userId: userId,
//         ApiKeyConstants.shiftDate: "2025-06-16"
//       };
//
//       GetMyShiftsByDataModel? getDateWiseShiftModel =
//           await ApiMethods.getDateWiseShiftsApi(
//         context: context,
//         bodyParams: bodyParam,
//       );
//
//       if (getDateWiseShiftModel != null &&
//           getDateWiseShiftModel.status != null &&
//           getDateWiseShiftModel.status != "0") {
//         dateWiseShiftList = getDateWiseShiftModel.data ?? [];
//       } else {
//         final msg = getDateWiseShiftModel?.message ?? "Something went wrong";
//         CommonWidgets.showMyToastMessage(msg);
//       }
//     } catch (e) {
//       CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
//     } finally {
//       inAsyncCall = false;
//       notifyListeners();
//     }
//   }
// }
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/get_my_shift_byDate_model.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../screens/my_hours/my_hours_screen.dart';
import '../../screens/shift_details/shift_details_screen.dart';

class ScheduleController extends ChangeNotifier {
  int selectedValue = 0;
  bool inAsyncCall = true;

  List<ShiftData> dateWiseShiftList = [];
  List<ShiftData> myShifts = [];
  List<ShiftData> onShiftLater = [];
  List<ShiftData> onShiftNow = [];
  List<ShiftData> openShifts = [];
  final EasyInfiniteDateTimelineController calender =
  EasyInfiniteDateTimelineController();

  DateTime focusDate = DateTime.now();

  void changeDates(DateTime selectedDate, BuildContext context) {
    focusDate = selectedDate;
    getDateWiseShifts(context: context);
    notifyListeners();
  }

  Future<void> getDateWiseShifts({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    try {
      final bodyParam = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.shiftDate: focusDate.toIso8601String().split("T")[0], // Format: yyyy-MM-dd
      };

      GetMyShiftsByDataModel? getDateWiseShiftModel =
      await ApiMethods.getDateWiseShiftsApi(
        context: context,
        bodyParams: bodyParam,
      );

      if (getDateWiseShiftModel != null &&
          getDateWiseShiftModel.status != null &&
          getDateWiseShiftModel.status != "0") {
        final data = getDateWiseShiftModel.data;

        // Separate lists
        myShifts = data?.myShifts ?? [];
        onShiftLater = data?.onShiftLater ?? [];
        onShiftNow = data?.onShiftNow ?? [];
        openShifts = data?.openShifts ?? [];
      } else {
        myShifts.clear();
        onShiftLater.clear();
        onShiftNow.clear();
        openShifts.clear();
        final msg = getDateWiseShiftModel?.message ?? "Something went wrong";
        CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
      dateWiseShiftList.clear(); // clear list on exception
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  void clickOnTap({required int value}) {
    selectedValue = value;
    notifyListeners();
  }

  void clickOnMyShiftCard({required BuildContext context, required int index}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: ShiftDetailsScreen(
        shiftId: dateWiseShiftList[index].id.toString(),
      ),
    );
  }

  void clickOnTotalHours({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: MyHoursScreen(),
    );
  }





}

