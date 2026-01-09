import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_constants/api_key_constants.dart';
import 'package:shiftzeal/common/common_methods.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../add_shift_tasks/add_shift_task_screen.dart';

class AddEmployeeShiftController extends ChangeNotifier {
  // Focus states
  bool isShiftDate = false;
  bool isStartTime = false;
  bool isEndTime = false;
  bool isAdminId = false;
  bool isPosition = false;
  bool isAddress = false;
  bool isAmount = false;

  bool inAsyncCall = false;

  // 🔹 Selected user info from dropdown
  String? selectedUser; // user name (UI ke liye)

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

  /// Add Shift Button Click
  Future<void> clickAddShiftButton({required BuildContext context}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? adminId = sharedPreferences.getString(ApiKeyConstants.userId);

      // Validation
      if (selectedUser == null ||
          shiftDateController.text.isEmpty ||
          startTimeController.text.isEmpty ||
          endTimeController.text.isEmpty ||
          addressController.text.isEmpty ||
          amountController.text.isEmpty) {
        CommonWidgets.showMyToastMessage('All fields are required!');
        return;
      }

      CommonMethods.unFocsKeyBoard();

      // Show loading indicator
      inAsyncCall = true;
      notifyListeners();

      // Prepare API payload
      final Map<String, dynamic> data = {
        ApiKeyConstants.userId: selectedUser,
        ApiKeyConstants.shiftDate: shiftDateController.text,
        ApiKeyConstants.start_time: startTimeController.text, // fixed key
        ApiKeyConstants.end_time: endTimeController.text,
        ApiKeyConstants.admin_id: adminId,
        ApiKeyConstants.position: "head",
        ApiKeyConstants.address: addressController.text,
        ApiKeyConstants.amount: amountController.text,
      };

      print("Payload -> $data");

      final response = await ApiMethods.addNewShiftForEmployeesApi(
        context: context,
        bodyParams: data,
      );

      inAsyncCall = false;
      notifyListeners();

      // Check API response
      if (response != null && response.status == "1") {
        CommonWidgets.showMyToastMessage(
            'Shift added successfully!, Add shift task details now ');
        Future.delayed(Duration(seconds: 2));
        resetForm();
        NavigationMethods.pushMethod(
            context: context,
            widget: AddEmployeeShiftTaskScreen(
                shiftId: response.data!.id.toString()));
      } else {
        CommonWidgets.showMyToastMessage(
            response?.message ?? 'Failed to add shift');
      }
    } catch (e) {
      inAsyncCall = false;
      notifyListeners();
      CommonWidgets.showMyToastMessage('An error occurred: $e');
      print("Error in clickAddShiftButton: $e");
    }
  }

// Reset form method
  void resetForm() {
    shiftDateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    addressController.clear();
    amountController.clear();
    selectedUser = null;
    notifyListeners();
  }

  @override
  void dispose() {
    focusShiftDate.dispose();
    focusStartTime.dispose();
    focusEndTime.dispose();
    focusAdminId.dispose();
    focusPosition.dispose();
    focusAddress.dispose();
    focusAmount.dispose();
    shiftDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    adminIdController.dispose();
    positionController.dispose();
    addressController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
