import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_models/get_sign_in_model.dart';
import 'package:shiftzeal/organization_screens/orgranization_registration/organization_registration_screen.dart';
import 'package:shiftzeal/screens/forgot_password/forgot_password_screen.dart';
import 'package:shiftzeal/screens/nav_bar/nav_bar_screen.dart';
import 'package:shiftzeal/screens/sign_up/sign_up_screen.dart';
import '../../admin_screens/admin_nav_bar/admin_nav_bar_screen.dart';
import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/local_data.dart';
import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';
import '../supervisor/supervisor_dashboard/supervisor_dashboard_screen.dart';

class LoginController extends ChangeNotifier {
  bool isEmail = false;
  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();
  bool inAsyncCall = false;
  bool isPassword = false;
  bool passwordHide = true;
  bool activeStatus = true;
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

  clickOnLoginButton({required BuildContext context}) async {
    // यह फ़ंक्शन शायद अप्रयुक्त है या पुराने लॉजिक के लिए है।
    // मैं `clickOnLogin` पर ध्यान केंद्रित कर रहा हूँ।
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

  clickOnSignInWithGoogleButton({required BuildContext context}) {}

  clickOnSignUp({required BuildContext context}) {
    switch (LocalData.userType) {
      case ApiKeyConstants.user:
        {
          NavigationMethods.pushMethod(
              context: context, widget: const SignUpScreen());
        }
        break;
      case ApiKeyConstants.business:
        {
          NavigationMethods.pushMethod(
              context: context, widget: const OrganizationRegistrationScreen());
        }
        break;
    }
  }

  clickOnForgotYourPassword({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const ForgotPasswordScreen());
  }

  void clickOnLogin({required BuildContext context}) {
    switch (LocalData.userType) {
      case ApiKeyConstants.user:
        {
          print("userType:---user${LocalData.userType}");
          loginApiCalling(context: context);
        }
        break;
      case ApiKeyConstants.business:
        {
          print("userType:---business${LocalData.userType}");
          loginApiCalling(context: context);
        }
        break;
    }
  }

  clickOnSignInWithAppleButton({required BuildContext context}) {}

  loginApiCalling({required BuildContext context}) async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      inAsyncCall = true;
      notifyListeners();
      Map<String, String> bodyParam = {
        ApiKeyConstants.email: emailController.text,
        ApiKeyConstants.password: passwordController.text,
        ApiKeyConstants.type: LocalData.userType,
      };

      SignInModel? userModel =
          await ApiMethods.loginUser(context: context, bodyParams: bodyParam);
      if (userModel != null &&
          userModel.status != null &&
          userModel.status != "0") {
        activeStatus =
            userModel.data?.userData?.status == "ACTIVE" ? true : false;
        notifyListeners();
        if (activeStatus) {
          CommonWidgets.showMyToastMessage(
              userModel.message ?? 'Login Successful');

          SharedPreferences sp = await SharedPreferences.getInstance();
          String? position =
              userModel.data?.userData?.position; // <--- पोजीशन प्राप्त करें

          sp.setString(ApiKeyConstants.token, userModel.data?.token ?? "");
          sp.setString(ApiKeyConstants.userId,
              userModel.data?.userData?.id.toString() ?? "");
          sp.setString(ApiKeyConstants.name,
              "${userModel.data?.userData?.firstName ?? ""} ${userModel.data?.userData?.lastName ?? ""}");
          sp.setString(
              ApiKeyConstants.image, userModel.data?.userData?.image ?? "");
          sp.setString(ApiKeyConstants.position, position ?? "");
          sp.setString(
              ApiKeyConstants.userType, userModel.data!.userData!.type!);

          // `position` भी पास करें
          routing(userModel.data!.userData!.type!, position,
              context); // <--- `position` पास करें
        } else {
          // CommonWidgets.showMyToastMessage(
          //     'Your account is not active. Please contact admin.');
        }
      } else {
        CommonWidgets.showMyToastMessage(
            userModel?.message ?? 'Something went wrong');
      }
    } else {
      // फ़ील्ड खाली होने पर
      CommonWidgets.showMyToastMessage('Required all field!');
    }

    // 6. लोडिंग स्थिति को अपडेट करें
    inAsyncCall = false;
    notifyListeners();
  }

  void routing(String userType, String? position, BuildContext context) {
    // <--- `position` स्वीकार करें
    switch (userType) {
      case ApiKeyConstants.user:
        {
          print("routing:---user${LocalData.userType}");
          // यहाँ `position` की जाँच करें
          if (position == 'Supervisor') {
            NavigationMethods.pushAndRemoveUntilMethod(
                context: context,
                widget:
                    const SupervisorDashboardScreen()); // <--- Supervisor के लिए नेविगेट करें
          } else {
            NavigationMethods.pushAndRemoveUntilMethod(
                context: context, widget: const NavBarScreen());
          }
        }
        break;
      case ApiKeyConstants.business:
        {
          print("routing:---seller${LocalData.userType}");
          NavigationMethods.pushAndRemoveUntilMethod(
              context: context, widget: const AdminNavBarScreen());
        }
        break;
    }
  }
}
