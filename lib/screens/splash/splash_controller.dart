import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/admin_screens/admin_nav_bar/admin_nav_bar_screen.dart';
import 'package:shiftzeal/screens/get_starts/get_starts_screen.dart';
import 'package:shiftzeal/screens/login/login_screen.dart';
import 'package:shiftzeal/screens/nav_bar/nav_bar_screen.dart';
// SupervisorDashboardScreen का इम्पोर्ट जोड़ें (सुनिश्चित करें कि पथ सही है)
// import 'package:shiftzeal/supervisor_screens/supervisor_dashboard/supervisor_dashboard_screen.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';
import '../supervisor/supervisor_dashboard/supervisor_dashboard_screen.dart';

class SplashController extends ChangeNotifier {
  Future<void> manage({required BuildContext context}) async {
    Timer(
      const Duration(seconds: 3),
          () async {
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

        final String? userType = sharedPreferences.getString(ApiKeyConstants.userType);
        final String? token = sharedPreferences.getString(ApiKeyConstants.token);
        final String? position = sharedPreferences.getString(ApiKeyConstants.position); // <--- पोजीशन प्राप्त करें

        print('UserType: $userType');
        print('Token: $token');
        print('Position: $position');

        if (token == null) {
          // 1. यदि टोकन नहीं है, तो GetStartsScreen पर जाएं
          NavigationMethods.pushReplacementMethod(
            context: context,
            widget: const GetStartsScreen(),
          );
        } else {
          // 2. यदि टोकन है, तो userType और position के आधार पर रूट करें
          if (userType == StringConstants.user) {
            // 2a. यदि User Type 'user' है, तो Position चेक करें
            if (position == 'Supervisor') { // <--- पोजीशन चेक
              NavigationMethods.pushAndRemoveUntilMethod(
                context: context,
                widget: const SupervisorDashboardScreen(), // Supervisor Dashboard पर जाएं
              );
            } else {
              NavigationMethods.pushAndRemoveUntilMethod(
                context: context,
                widget: const NavBarScreen(), // सामान्य User NavBar पर जाएं
              );
            }
          } else {
            // 2b. यदि User Type 'business' या कोई और है (Admin)
            NavigationMethods.pushAndRemoveUntilMethod(
                context: context, widget: const AdminNavBarScreen());
          }
        }
      },
    );
  }
}