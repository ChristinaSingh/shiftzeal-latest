import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_methods/api_methods.dart';
import '../../../apis/api_constants/api_key_constants.dart';
import '../../../apis/api_models/supervisor_employee_model.dart';

class SupervisorDashboardController extends ChangeNotifier {
  bool inAsyncCall = false;

  List<EmployeesData> employees = [];

  String username = "User";
  String userImage = "";
  String userPosition = "";
  String id = '';

  /// ---------------------------
  /// LOAD USER DETAILS
  /// ---------------------------
  Future<void> getUserDetails({required BuildContext context}) async {
    try {
      inAsyncCall = true;
      notifyListeners();

      SharedPreferences sp = await SharedPreferences.getInstance();

      username = sp.getString(ApiKeyConstants.name) ?? "User";
      userImage = sp.getString(ApiKeyConstants.image) ?? "";
      userPosition = sp.getString(ApiKeyConstants.position) ?? "Supervisor";
      id = sp.getString(ApiKeyConstants.userId) ?? "";
      if(id.isNotEmpty){
        getAssignedEmployeesList(context: context); 
      }
    } catch (e) {
      debugPrint("GetUserDetails Error: $e");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  /// ---------------------------
  /// GET ASSIGNED EMPLOYEES LIST
  /// ---------------------------
  Future<void> getAssignedEmployeesList({required BuildContext context}) async {
    try {
      inAsyncCall = true;
      notifyListeners();

      SupervisorEmployeeModel? employeeData =
          await ApiMethods.getSupervisorEmployeeList(
              context: context, bodyParams: {"supervisor_id": id});

      if (employeeData != null &&
          employeeData.status != null &&
          employeeData.status != "0") {
        employees = employeeData.data ?? [];
      } else {
        employees = [];
      }
    } catch (e) {
      debugPrint("getAssignedEmployeesList Error: $e");
      employees = [];
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }
}
