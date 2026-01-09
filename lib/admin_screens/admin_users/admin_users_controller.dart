import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/admin_screens/add_user/add_user_screen.dart';
import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../apis/api_models/get_directory_list_model.dart' as directory;

class AdminUsersController extends ChangeNotifier {
  List<directory.UserData> membersList = [];
  bool inAsyncCall = false;
  List<Map<String, String>> filteredUsers = [];

  // This list now holds the dynamic data from the API
  List<Map<String, String>> users = [];

  clickOnListTile({required BuildContext context, required int index}) {
    //NavigationMethods.pushMethod(context: context, widget: TaskDetailScreen());
  }
  clickOnAdd({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: AddUserScreen());
  }

  clickOnSaveButton({required BuildContext context}) {}

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
        // Mapping API response to the required format
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