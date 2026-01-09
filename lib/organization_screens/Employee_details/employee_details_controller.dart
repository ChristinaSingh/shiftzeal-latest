import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftzeal/apis/api_constants/api_key_constants.dart';
import 'package:shiftzeal/apis/api_models/get_profile_model.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/edit_profile/edit_profile_screen.dart';
import '../../admin_screens/admin_users/admin_users_controller.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/delete_employee_model.dart';
import '../../apis/api_models/get_employee_insurance_model.dart';
import '../../common/common_widgets.dart';

class EmployeeDetailsController extends ChangeNotifier {
  int selectedValue = 0;
  bool inAsyncCall = true;
  bool isTimeForMyShift = false;
  int selectedTimeForMyShiftIndex = 0;
  bool isTime = false;
  int selectedTimeIndex = 0;
  late String userId;
  UserData? userData;
  List<InsuranceData> medicalInsuranceList = [];
  List<InsuranceData> otherInsuranceList = [];

  final List<Map<String, String>> cards = [
    {"title": "Time-Off Request Status"},
    {"title": "Swap/Drop Requests"},
    {"title": "OpenShift Requests"},
    {"title": "Schedule Updates"},
    {"title": "Clock In/Out Reminders"},
  ];

  final List<String> toggles = [
    "Time-off Approved Notifications",
    "Schedule Updated Notifications",
    "Clock In/Out Notifications",
  ];

  final List<String> timeList = [
    '11:00p   05:00p',
    '11:15p   05:15p',
    '11:30p   05:30p',
    '11:45p   05:45p',
    '12:00p   06:00p',
    '12:15p   06:15p',
    '12:30p   06:30p',
    '12:45p   06:45p',
    '01:00p   07:00p',
    '01:15p   07:15p',
  ];

  final List<String> timeForMyShift = [
    '0 hours before my shift',
    '1 hour before my shift',
    '2 hours before my shift',
    '3 hours before my shift',
    '4 hours before my shift',
    '5 hours before my shift',
    '6 hours before my shift',
    '7 hours before my shift',
    '8 hours before my shift',
    '9 hours before my shift',
    '10 hours before my shift',
    '11 hours before my shift',
    '12 hours before my shift',
  ];

  List<Map<String, String>> listOfData = [
    {'title': 'Name', 'value': 'Haylie Torff'},
    {'title': 'Phone Number', 'value': 'None'},
    {'title': 'Email', 'value': 'None'},
    {'title': 'Employee ID', 'value': 'None'},
    {'title': 'Role', 'value': 'Employee'},
    {'title': 'Max Hours/Week', 'value': 'None'},
    {'title': 'Privacy', 'value': 'None'},
    {'title': 'Two-Step Verification', 'value': 'None'},
    {'title': 'Timezone', 'value': 'None'},
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

  /// Initialize Controller with userId from Widget
  Future<void> initMethod({
    required BuildContext context,
    required String userId,
  }) async {
    this.userId = userId; // 👈 store userId
    inAsyncCall = true;
    notifyListeners();

    await getProfileApi(context: context, userDetailsId: userId);
    await fetchAllInsurance(context);

    inAsyncCall = false;
    notifyListeners();
  }

  /// Get profile details
  Future<void> getProfileApi({
    required BuildContext context,
    required String userDetailsId,
  }) async {
    GetProfileModel? userModel = await ApiMethods.getEmployeeProfileProfile(
      context: context,
      bodyParams: {
        ApiKeyConstants.userId: userDetailsId,
      },
    );

    if (userModel != null && userModel.data?.userData != null) {
      userData = userModel.data?.userData!;
    } else {
      CommonWidgets.showMyToastMessage(
          userModel?.message ?? 'Something went wrong');
    }

    notifyListeners();
  }

  /// Fetch Employee Insurance (Medical / Other)
  Future<void> fetchEmployeeInsurance({
    required BuildContext context,
    required String type,
  }) async {
    final body = {
      "user_id": userId,
      "type": type,
    };

    final response = await ApiMethods.getEmployeeInsurance(
      context: context,
      bodyParams: body,
    );

    if (response == null) {
      CommonWidgets.showMyToastMessage("No response from server");
      return;
    }

    if (response.success == true && response.data != null) {
      if (type == "Medical") {
        medicalInsuranceList = response.data!;
      } else if (type == "Other") {
        otherInsuranceList = response.data!;
      }
    } else {
      CommonWidgets.showMyToastMessage(response.message ?? "Error occurred");
    }

    notifyListeners();
  }

  /// Fetch both Medical and Other insurance
  Future<void> fetchAllInsurance(BuildContext context) async {
    await fetchEmployeeInsurance(context: context, type: "Medical");
    await fetchEmployeeInsurance(context: context, type: "Other");
  }

  /// UI Interaction methods
  void clickOnTap({required int value}) {
    selectedValue = value;
    notifyListeners();
  }

  void clickOnEdit({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: EditProfileScreen());
  }

  void clickOnTimeForMyShift() {
    isTimeForMyShift = !isTimeForMyShift;
    notifyListeners();
  }

  void clickOnTime() {
    isTime = !isTime;
    notifyListeners();
  }

  void onSelectedTimeForMyShiftIndexChanged({required int index}) {
    selectedTimeForMyShiftIndex = index;
    notifyListeners();
  }

  void onSelectedTimeIndexChanged({required int index}) {
    selectedTimeIndex = index;
    notifyListeners();
  }

  Future<void> updateInsuranceDetails({
    required BuildContext context,
    required Map<String, dynamic> bodyParams,
    required String type,
  }) async {
    inAsyncCall = true;
    notifyListeners();
    final body = bodyParams;
    final response = await ApiMethods.updateEmployeeInsurance(
      context: context,
      bodyParams: body,
    );

    inAsyncCall = false;
    notifyListeners();
    if (response == null) {
      CommonWidgets.showMyToastMessage(
          "No response from server. Please check connection.");
      return;
    }

    if (response.success == true) {
      CommonWidgets.showMyToastMessage(
          response.message ?? "$type Insurance details updated successfully.");

      await fetchEmployeeInsurance(context: context, type: type);
    } else {
      CommonWidgets.showMyToastMessage(
          response.message ?? "Failed to update $type Insurance details.");
    }
  }

  Future<void> deleteUser({
    required BuildContext context,
    required String userDetailsId,
  }) async {
    inAsyncCall = true;
    notifyListeners();
    DeleteEmployeeModel? deleteEmployeeModel = await ApiMethods.deleteUserApi(
      context: context,
      bodyParams: {
        ApiKeyConstants.userId: userDetailsId,
      },
    );

    if (deleteEmployeeModel != null && deleteEmployeeModel.status == "1") {
      inAsyncCall = false;
      CommonWidgets.showMyToastMessage(
          deleteEmployeeModel.message ?? 'User deleted successfully');
      Provider.of<AdminUsersController>(context, listen: false)
          .fetchEmployeeDirectory(context: context);

      Navigator.of(context).pop(); // Go back after deletion
    } else {
      CommonWidgets.showMyToastMessage(
          deleteEmployeeModel?.message ?? 'Something went wrong');
    }
    inAsyncCall = false;
    notifyListeners();
  }
}
