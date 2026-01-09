import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/common/navigation_methos.dart';


import '../track_time/track_time_screen.dart';

class SendInvitationController extends ChangeNotifier {
  bool isEmail = false;
  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();

  bool isPassword = false;
  bool passwordHide = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void startListener() {
    focusPassword.addListener(onFocusChange);
    focusEmail.addListener(onFocusChange);
  }

  void onFocusChange() {
    isPassword = focusPassword.hasFocus;
    isEmail = focusEmail.hasFocus;
    notifyListeners();
  }

  clickOnPasswordEyeButton() {
    passwordHide = !passwordHide;
    notifyListeners();
  }

  // clickOnLoginButton({required BuildContext context}) async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   if (sp.getString(ApiKeyConstants.type) !=
  //       StringConstants.iAmSettingUpMyBusiness) {
  //     NavigationMethods.pushMethod(
  //         context: context, widget: const NavBarScreen());
  //   } else {
  //     NavigationMethods.pushMethod(
  //         context: context, widget: const AdminNavBarScreen());
  //   }
  // }

  clickOnSignInWithGoogleButton({required BuildContext context}) {}

  // clickOnSignUp({required BuildContext context}) {
  //   NavigationMethods.pushMethod(
  //       context: context, widget: const SignUpScreen());
  // }
  //
  // clickOnForgotYourPassword({required BuildContext context}) {
  //   NavigationMethods.pushMethod(
  //       context: context, widget: const ForgotPasswordScreen());
  // }

  clickOnSignInWithAppleButton({required BuildContext context}) {}
}
