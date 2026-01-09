import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_constants/api_key_constants.dart';
import 'package:shiftzeal/apis/api_methods/api_methods.dart';
import 'package:shiftzeal/apis/api_models/get_directory_list_model.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/employee_detail/employee_detail_screen.dart';

class DirectoryController extends ChangeNotifier {
  int selectedValue = 0;
  bool inAsyncCall = false;
  List<Map<String, String>> filteredUsers = [];
  /// Store employees fetched from API
  List<UserData> membersList = [];

  /// Store mapped data for UI Grid/List
  List<Map<String, String>> users = [];

  /// List of details for a selected user
  List<Map<String, String>> listOfData = [
    {'title': 'Name', 'value': 'None'},
    {'title': 'Phone', 'value': 'None'},
    {'title': 'Email', 'value': 'None'},
    {'title': 'Employee ID', 'value': 'None'},
    {'title': 'Role', 'value': 'Employee'},
    {'title': 'Max Hours/Week', 'value': 'None'},
    {'title': 'Privacy', 'value': 'None'},
    {'title': 'Two-Step Verification', 'value': 'None'},
    {'title': 'Timezone', 'value': 'None'},
  ];

  /// Fetch Employee Directory from API
  Future<void> fetchEmployeeDirectory({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();

    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

      final body = {ApiKeyConstants.userId: userId};
      final response = await ApiMethods.getEmployeeDirectory(
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
        // Store all employees
        membersList = response.data!;

        // Map employees for UI
        users = membersList.map((user) {
          return {
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

  /// Update selected tab
  void clickOnTap({required int value}) {
    selectedValue = value;
    notifyListeners();
  }

  /// Navigate to Employee Detail Screen
  void clickOnDirectoryItem({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: EmployeeDetailScreen(),
    );
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers = List.from(users);
    } else {
      filteredUsers = users.where((user) {
        final name = user['name']!.toLowerCase();
        final role = user['role']!.toLowerCase();
        final search = query.toLowerCase();
        return name.contains(search) || role.contains(search);
      }).toList();
    }
    notifyListeners();
  }
}
