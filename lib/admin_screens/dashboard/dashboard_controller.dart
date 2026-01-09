import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/admin_screens/attendance_notices/attendance_notices_screen.dart';
import 'package:shiftzeal/admin_screens/publish_shifts/publish_shifts_screen.dart';
import 'package:shiftzeal/admin_screens/time_off_requests/time_off_requests_screen.dart';
import 'package:shiftzeal/admin_screens/user_activity/user_activity_screen.dart';
import 'package:shiftzeal/screens/my_shift/my_shift_screen.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';

// 👇 Aliased imports to avoid UserData conflicts
import '../../apis/api_models/get_all_users_list_model.dart' as allusers;
import '../../apis/api_models/get_directory_list_model.dart' as directory;

import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../organization_screens/add_shift/add_shift_screen.dart';

class DashboardController extends ChangeNotifier {
  bool clockInValue = true;
  bool inAsyncCall = false;
  List<Map<String, String>> filteredUsers = [];

  /// Store employees fetched from Directory API
  List<directory.UserData> membersList = [];

  /// Store mapped data for UI Grid/List
  List<Map<String, String>> users = [];

  clickOnTimeOffRequests({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const TimeOffRequestsScreen());
  }

  clickOnShiftRequests({required BuildContext context}) {}

  clickOnJoinARegisteredEmployer({required BuildContext context}) {}

  clickOnClockIn({required BuildContext context}) {
    clockInValue = false;
    notifyListeners();
  }

  clickOnClockOut({required BuildContext context}) {
    clockInValue = true;
    notifyListeners();
  }

  clickOnMyShift({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const MyShiftScreen());
  }

  clickOnAttendanceNotices({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const AttendanceNoticesScreen());
  }

  clickOnAddNewShift({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const AddEmployeeShiftScreen());
  }



  clickOnMySchedule({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const PublishShiftsScreen());
  }

  clickOnUserActivity({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const UserActivityScreen());
  }

  Future<void> fetchEmployeeDirectory({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();

    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

      final body = {ApiKeyConstants.userId: userId};
      final response = await ApiMethods.getOrganizationEmployees(
        context: context,
        bodyParams: body,
      );
      inAsyncCall = false;
      if (response == null) {
        CommonWidgets.showMyToastMessage("No response from server");
        notifyListeners();
        return;
      }

      if (response.success == true && response.data != null) {
        membersList = response.data!;
        users = membersList.map((user) {
          return {
            'id': user.id.toString(),
            'name': "${user.firstName ?? ''} ${user.lastName ?? ''}",
            'role': user.position ?? 'Employee',
            'image': user.image ?? 'https://i.pravatar.cc/150?img=1',
          };
        }).toList();
        filteredUsers = List.from(users);
        notifyListeners();
      } else {
        CommonWidgets.showMyToastMessage(response.message ?? "Error occurred");
        notifyListeners();
      }
    } catch (e) {
      inAsyncCall = false;
      notifyListeners();
      CommonWidgets.showMyToastMessage("Something went wrong: $e");
    }
  }
}
