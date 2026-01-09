import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/admin_screens/add_shift/add_shift_screen.dart';
import 'package:shiftzeal/apis/api_models/add_shift_for_employee_model.dart';
import 'package:shiftzeal/screens/my_hours/my_hours_screen.dart';
import 'package:shiftzeal/screens/shift_details/shift_details_screen.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/get_all_shifts_model.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../organization_screens/add_shift/add_shift_screen.dart';
import '../../screens/task/task_screen.dart';
import '../publish_shifts/publish_shifts_screen.dart';

class AdminScheduleController extends ChangeNotifier {
  final EasyInfiniteDateTimelineController calender =
      EasyInfiniteDateTimelineController();
  DateTime focusDate = DateTime.now();
  int selectedValue = 0;
  bool inAsyncCall = true;

  // 1. API से प्राप्त ShiftData को स्टोर करने के लिए नया लिस्ट वेरिएबल
  List<ShiftData> allShiftsList = [];

  int _selectedTabIndex = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // NOTE: 'SchedulerProvider' कंस्ट्रक्टर को 'AdminScheduleController' में बदल दिया गया है
  AdminScheduleController() {
    _selectedDay = _focusedDay;
  }

  int get selectedTabIndex => _selectedTabIndex;
  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  void changeTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  void selectDay(DateTime selected, DateTime focused) {
    _selectedDay = selected;
    _focusedDay = focused;
    notifyListeners();
  }

  List<Map<String, String>> listOfData = [
    {'title': 'MEMBER NAME', 'value': 'Jon Altomy'},
    {'title': 'GROUP NAME', 'value': 'Zenefits Mobile Beta Test'},
    {'title': 'GROUP ID', 'value': '24245818'},
    {'title': 'EFFECTIVE DATE', 'value': 'May 1, 2016'},
    {'title': 'PLAN', 'value': 'Gold PPO 750 80-50'},
    {'title': 'RX BIN/PCN', 'value': '610502/00670000'},
    {'title': 'DEPENDENTS', 'value': 'Johhny Testtest'},
  ];

  List<Map<String, String>> listOfDataAlert = [
    {'title': 'Time-Off Request Status'},
    {'title': 'Swap/Drop Requests'},
    {'title': 'Open Shift Requests'},
    {'title': 'Schedule Updates'},
    {'title': 'Clock In/Out Reminders'},
  ];
  List<Map<String, String>> listOfDataAlert2 = [
    {'title': 'Clock In/Out Reminders'},
    {'title': 'Badge App Icon'},
    {'title': 'In-App Notifications'},
  ];
  void clickOnAddIcon({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const AddEmployeeShiftScreen());
  }

  getUserTripApiMethod({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();
    inAsyncCall = false;
    notifyListeners();
  }

  clickOnTap({required int value, required BuildContext context}) {
    selectedValue = value;
    notifyListeners();
  }

  // Shift ID का उपयोग करने के लिए अपडेट किया गया, allShiftsList से ShiftData ऑब्जेक्ट लें
  clickOnMyShiftCard({required BuildContext context, required int index}) {
    // सुनिश्चित करें कि इंडेक्स allShiftsList की सीमा के भीतर है
    if (index >= 0 && index < allShiftsList.length) {
      String shiftId = allShiftsList[index].id?.toString() ?? "1";
      NavigationMethods.pushMethod(
          context: context, widget: ShiftDetailsScreen(shiftId: shiftId));
    }
  }

  clickOnTotalHours({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: MyHoursScreen());
  }

  Future<void> getAllShifts({required BuildContext context}) async {
    inAsyncCall = true;
    allShiftsList.clear();
    notifyListeners();

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    try {
      final bodyParam = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.shiftDate:
            focusDate.toIso8601String().split("T")[0], // Format: yyyy-MM-dd
      };

      AllShiftsModel? getDateWiseShiftModel =
          await ApiMethods.getMyShiftsApiAdmin(
        context: context,
        bodyParams: bodyParam,
      );

      if (getDateWiseShiftModel != null &&
          getDateWiseShiftModel.status != null &&
          getDateWiseShiftModel.status != "0") {
        final data = getDateWiseShiftModel.data;
        // 3. API से प्राप्त डेटा को allShiftsList में सेव करें
        if (data != null) {
          allShiftsList = data;
        }
      } else {
        final msg = getDateWiseShiftModel?.message ?? "Something went wrong";
        // CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  void changeDates(DateTime selectedDate, BuildContext context) {
    // SharedPreferences sharedPreferences = await  SharedPreferences.getInstance();
    // String? token = sharedPreferences.getString(ApiKeyConstants.token);
    focusDate = selectedDate;
    getAllShifts(context: context);
    notifyListeners();
  }

  clickOnShiftCard({required BuildContext context, required int index}) {
    String shiftId = allShiftsList[index].id?.toString() ?? "1";
    NavigationMethods.pushMethod(
        context: context, widget: TaskScreen(taskId: shiftId));
  }

  deleteShift({required BuildContext context, required String shiftId}) async {
    inAsyncCall = true;
    notifyListeners();

    try {
      final bodyParam = {
        ApiKeyConstants.shiftId: shiftId,
      };

      final response = await ApiMethods.deleteShiftApi(
        context: context,
        bodyParams: bodyParam,
      );
      if (response != null && response.status == "1") {
        CommonWidgets.showMyToastMessage('Shift deleted successfully!');
        getAllShifts(context: context);
      } else {
        CommonWidgets.showMyToastMessage(
            response?.message ?? 'Failed to delete shift');
      }
    } catch (e) {
      // CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }
}
