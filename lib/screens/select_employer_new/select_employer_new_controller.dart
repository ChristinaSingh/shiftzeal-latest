import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_constants/api_key_constants.dart';
import 'package:shiftzeal/screens/login/login_screen.dart';

import '../../admin_screens/admin_nav_bar/admin_nav_bar_screen.dart';
import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';
import '../nav_bar/nav_bar_screen.dart';
import '../sendInvitation/send_Invitation_screen.dart';

class SelectEmployerNewController extends ChangeNotifier {
  clickOnIAmAnEmployee({required BuildContext context}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(ApiKeyConstants.type, StringConstants.iAmAnEmployee);
    NavigationMethods.pushMethod(context: context, widget: const NavBarScreen());
  }

  clickOnIAmSettingUpMyBusiness({required BuildContext context}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(ApiKeyConstants.type,
        StringConstants.iAmSettingUpMyBusiness);
    NavigationMethods.pushMethod(context: context, widget: const AdminNavBarScreen());
  }


  clickOnLoginButton({required BuildContext context}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString(ApiKeyConstants.type) !=
        StringConstants.iAmSettingUpMyBusiness) {
      NavigationMethods.pushMethod(
          context: context, widget: const NavBarScreen());
    } else {
      NavigationMethods.pushMethod(
          context: context, widget: const AdminNavBarScreen());
    }
  }
}
