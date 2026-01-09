import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    var loginController = Provider.of<LoginController>(context, listen: false);
    loginController.startListener();
  }

  void showDialogFunction(LoginController controller) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            StringConstants.accountInactive,
            style: TextStyle(
              color: Color(0xffE60001),
              fontWeight: FontWeight.bold,
              fontSize: 18.px,
            ),
          ),
          content: Text(
            StringConstants.contactAdminToActivateAccount,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 15.px,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                controller.activeStatus = true;
                _isDialogShown = false;
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color(0xffE60001),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        if (!controller.activeStatus && !_isDialogShown) {
          _isDialogShown = true;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialogFunction(controller);
          });
        }

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.px),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.px),
                      Center(
                        child: CommonMethods.appIcons(
                          assetName: IconConstants.icSplashLogo,
                          height: 104.px,
                          width: 100.px,
                        ),
                      ),
                      SizedBox(
                        height: 30.px,
                      ),
                      Center(
                        child: Text(
                          StringConstants.welcomMassage,
                          maxLines: 2,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25.px,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10.px,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: Text(
                            StringConstants.welcomMassage2,
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: 38.px),
                      CommonWidgets.normalTextFieldForLoginSignUP(
                        focusNode: controller.focusEmail,
                        controller: controller.emailController,
                        isCard: controller.isEmail,
                        hintText: StringConstants.email,
                        keyboardType: TextInputType.emailAddress,
                        borderRadius: 15.px,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        context: context,
                      ),
                      SizedBox(height: 20.px),
                      CommonWidgets.normalTextFieldForLoginSignUP(
                          obscureText: controller.passwordHide,
                          maxLines: 1,
                          focusNode: controller.focusPassword,
                          hintText: StringConstants.password,
                          controller: controller.passwordController,
                          isCard: controller.isPassword,
                          suffixIcon: GestureDetector(
                            onTap: () => controller.clickOnPasswordEyeButton(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonMethods.iconLinearGradient(
                                    assetName: controller.passwordHide
                                        ? IconConstants.icHide
                                        : IconConstants.icView,
                                    value: controller.isPassword,
                                    context: context),
                              ],
                            ),
                          ),
                          context: context,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20)),
                      SizedBox(height: 20.px),
                      GestureDetector(
                        onTap: () => controller.clickOnForgotYourPassword(
                            context: context),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(StringConstants.forgotYourPassword,
                              style: Theme.of(context).textTheme.labelMedium),
                        ),
                      ),
                      SizedBox(height: 20.px),
                      CommonWidgets.commonCustumeButton(
                        onPressed: () async {
                          controller.clickOnLogin(context: context);
                        },
                        borderRadius: 15.px,
                        buttonColor: Theme.of(context).primaryColor,
                        child: Text(
                          StringConstants.login,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        showLoading: controller.inAsyncCall,
                        context: context,
                      ),
                      SizedBox(height: 22.px),
                      Align(
                        alignment: Alignment.center,
                        child: Text(StringConstants.orContinueWithSocialAccount,
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(height: 22.px),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  controller.clickOnSignInWithGoogleButton(
                                      context: context),
                              child: Container(
                                height: 50.px,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                    Theme.of(context).colorScheme.surface,
                                  ),
                                  borderRadius: BorderRadius.circular(15.px),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    CommonMethods.appIcons(
                                        assetName: IconConstants.icGoogleLogo),
                                    SizedBox(width: 8.px),
                                    Text(
                                      StringConstants.signInWithGoogle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                          fontSize: 14.px,
                                          color: Colors.black
                                              .withOpacity(0.5)),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.px,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  controller.clickOnSignInWithAppleButton(
                                      context: context),
                              child: Container(
                                height: 50.px,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                    Theme.of(context).colorScheme.surface,
                                  ),
                                  borderRadius: BorderRadius.circular(15.px),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    CommonMethods.appIcons(
                                        assetName: IconConstants.icApple),
                                    SizedBox(width: 8.px),
                                    Text(
                                      StringConstants.signInWithApple,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                          fontSize: 14.px,
                                          color: Colors.black
                                              .withOpacity(0.5)),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.px),
                      GestureDetector(
                        onTap: () => controller.clickOnSignUp(context: context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              StringConstants.doNotHaveAnAccountYet,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                  fontSize: 14.px,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(width: 4.px),
                            CommonMethods.textViewLinearGradient(
                                text: StringConstants.signUp,
                                primaryColor: true,
                                value: true,
                                context: context),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.px),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}