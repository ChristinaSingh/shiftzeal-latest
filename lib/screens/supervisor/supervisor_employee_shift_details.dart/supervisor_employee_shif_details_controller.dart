import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_constants/api_key_constants.dart';
import 'package:shiftzeal/apis/api_methods/api_methods.dart';
import '../../../apis/api_models/add_shift_by_supervisor_model.dart';
import '../../../apis/api_models/get_employee_shifts_model.dart';
import '../../../common/common_methods.dart';
import '../../../common/common_widgets.dart';

class SupervisorEmployeeShiftDetailsController extends ChangeNotifier {
  bool inAsyncCall = false;
  List<EmployeeShiftData> employeeShiftsData = [];

  // Focus states
  bool isShiftDate = false;
  bool isStartTime = false;
  bool isEndTime = false;
  bool isAdminId = false;
  bool isPosition = false;
  bool isAddress = false;
  bool isAmount = false;
  // Focus nodes
  FocusNode focusShiftDate = FocusNode();
  FocusNode focusStartTime = FocusNode();
  FocusNode focusEndTime = FocusNode();
  FocusNode focusAdminId = FocusNode();
  FocusNode focusPosition = FocusNode();
  FocusNode focusAddress = FocusNode();
  FocusNode focusAmount = FocusNode();

  // Controllers
  TextEditingController shiftDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController adminIdController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  List<String> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask() {
    final task = taskController.text.trim();
    if (task.isNotEmpty) {
      tasks.add(task);
      taskController.clear();
      notifyListeners();
    }
  }

  void removeTask(String task) {
    tasks.remove(task);
    notifyListeners();
  }

  void startListener() {
    focusShiftDate.addListener(onFocusChange);
    focusStartTime.addListener(onFocusChange);
    focusEndTime.addListener(onFocusChange);
    focusAdminId.addListener(onFocusChange);
    focusPosition.addListener(onFocusChange);
    focusAddress.addListener(onFocusChange);
    focusAmount.addListener(onFocusChange);
  }

  void onFocusChange() {
    isShiftDate = focusShiftDate.hasFocus;
    isStartTime = focusStartTime.hasFocus;
    isEndTime = focusEndTime.hasFocus;
    isAdminId = focusAdminId.hasFocus;
    isPosition = focusPosition.hasFocus;
    isAddress = focusAddress.hasFocus;
    isAmount = focusAmount.hasFocus;
    notifyListeners();
  }

  /// Select Shift Date
  Future<void> selectDate({required BuildContext context}) async {
    CommonMethods.unFocsKeyBoard();
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      shiftDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      notifyListeners();
    }
  }

  /// Select Start Time
  Future<void> selectStartTime({required BuildContext context}) async {
    CommonMethods.unFocsKeyBoard();
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFE60001),
              onPrimary: Colors.white,
              surface: Colors.grey.shade200,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFE60001)),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Convert to 24-hour format
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      startTimeController.text = "$hour:$minute";
      notifyListeners();
    }
  }

  /// Select End Time
  Future<void> selectEndTime({required BuildContext context}) async {
    CommonMethods.unFocsKeyBoard();
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFE60001),
              onPrimary: Colors.white,
              surface: Colors.grey.shade200,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFE60001)),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Convert to 24-hour format
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      endTimeController.text = "$hour:$minute";
      notifyListeners();
    }
  }

  Future<void> getAssignedEmployeesShiftsList(
      {required BuildContext context, required String userId}) async {
    try {
      inAsyncCall = true;
      notifyListeners();
      SupervisorEmployeeShiftsModel? shiftData =
          await ApiMethods.getSupervisorEmployeeShiftApi(
              context: context, bodyParams: {"user_id": userId});

      if (shiftData != null &&
          shiftData.status != null &&
          shiftData.status != "0") {
        employeeShiftsData = shiftData.data ?? [];
      } else {
        employeeShiftsData = [];
      }
    } catch (e) {
      debugPrint("getAssignedEmployeesShift data Error: $e");
      employeeShiftsData = [];
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  Future<void> assignNewShift(
      {required BuildContext context, required String userId}) async {
    try {
      if (shiftDateController.text.isEmpty ||
          startTimeController.text.isEmpty ||
          endTimeController.text.isEmpty ||
          addressController.text.isEmpty ||
          amountController.text.isEmpty ||
          tasks.isEmpty) {
        CommonWidgets.showMyToastMessage("Please fill all required fields");
        return;
      }

      inAsyncCall = true;
      notifyListeners();

      // Fetch employee_id from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? employeeId = prefs.getString(ApiKeyConstants.userId);
      if (employeeId == null) {
        CommonWidgets.showMyToastMessage("Employee ID not found");
        inAsyncCall = false;
        notifyListeners();
        return;
      }

      // Convert tasks to list of maps
      List<Map<String, String>> taskList =
          tasks.map((task) => {"description": task}).toList();
      Map<String, dynamic> bodyParams = {
        "user_id": employeeId,
        "employee_id": userId,
        "status": "Pending",
        "shift_date": shiftDateController.text,
        "start_time": startTimeController.text,
        "end_time": endTimeController.text,
        "address": addressController.text,
        "lat": "22.6990",
        "lon": "75.8671",
        "amount": amountController.text,
        "tasks": jsonEncode(taskList),
      };

      AddShiftModel? addShiftModel =
          await ApiMethods.addSupervisorEmployeeShiftApi(
              context: context, bodyParams: bodyParams);

      if (addShiftModel != null && addShiftModel.status != "0") {
        CommonWidgets.showMyToastMessage("Shift assigned successfully");

        // Refresh the shift list
        await getAssignedEmployeesShiftsList(context: context, userId: userId);

        // Clear all fields
        shiftDateController.clear();
        startTimeController.clear();
        endTimeController.clear();
        addressController.clear();
        amountController.clear();
        tasks.clear();
        taskController.clear();

        notifyListeners();

        // Close BottomSheet
        Navigator.of(context).pop();
      } else {
        CommonWidgets.showMyToastMessage("Failed to assign shift");
      }
    } catch (e) {
      debugPrint("assignNewShift Error: $e");
      CommonWidgets.showMyToastMessage("Something went wrong");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }
}
