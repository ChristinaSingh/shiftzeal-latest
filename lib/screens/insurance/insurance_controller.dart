import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/get_employee_insurance_model.dart';
import '../../common/common_widgets.dart';

class InsuranceController extends ChangeNotifier {
  int selectedValue = 0;
  bool inAsyncCall = true;

  List<InsuranceData> medicalInsuranceList = [];
  List<InsuranceData> otherInsuranceList = [];

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

  clickOnTap({required int value}) {
    selectedValue = value;
    notifyListeners();
  }

  /// Reusable method -> pass type dynamically
  Future<void> fetchEmployeeInsurance({
    required BuildContext context,
    required String type,
  }) async {
    inAsyncCall = true;
    notifyListeners();

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    final body = {
      "user_id": userId,
      "type": type,
    };

    final response = await ApiMethods.getEmployeeInsurance(
      context: context,
      bodyParams: body,
    );

    inAsyncCall = false;
    notifyListeners();

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
      notifyListeners();
    } else {
      CommonWidgets.showMyToastMessage(response.message ?? "Error occurred");
    }
  }

  Future<void> fetchAllInsurance(BuildContext context) async {
    await fetchEmployeeInsurance(context: context, type: "Medical");
    await fetchEmployeeInsurance(context: context, type: "Other");
  }
}
