import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import '../../common/navigation_methos.dart';
import '../../constants/icons_constant.dart';
import 'new_password_controller.dart';

class NewPasswordScreen extends StatefulWidget {
  Map<String, String> bodyParam;

  NewPasswordScreen({super.key, required this.bodyParam});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  void initState() {
    super.initState();
    var newPasswordController =
        Provider.of<NewPasswordController>(context, listen: false);
    newPasswordController.bodyParam = widget.bodyParam;
    newPasswordController.startListener();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewPasswordController>(
      builder: (context, controller, child) {
        return Scaffold(
          bottomSheet: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 150.px,
            child: Padding(
              padding: EdgeInsets.all(24.px),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CommonWidgets.commonElevatedButton(
                  //     context: context,
                  //     borderRadius: 15,
                  //     onPressed: () =>
                  //         controller.clickOnSendButton(context: context),
                  //     text: StringConstants.setUp),
                  CommonWidgets.commonCustumeButton(
                    onPressed: () async {
                      controller.clickOnSendButton(context: context);
                    },
                    borderRadius: 20.px,
                    buttonColor: Theme.of(context).primaryColor,
                    child: Text(
                      StringConstants.setUp,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    showLoading: controller.inAsyncCall,
                    context: context,
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.px),
                  Stack(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              NavigationMethods.popMethod(context: context);
                            },
                            child: CommonWidgets.appIcons(
                              assetName: IconConstants.icBlueBack,
                              height: 43.px,
                              width: 47.px,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CommonMethods.appIcons(
                          assetName: IconConstants.icSplashLogo,
                          height: 104.px,
                          width: 100.px,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 38.px),
                  Center(
                    child: Text(
                      StringConstants.newPassMassage,
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
                        StringConstants.newPassMassage1,
                        maxLines: 3,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 38.px),
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    obscureText: controller.passwordHide,
                    focusNode: controller.focusPassword,
                    maxLines: 1,
                    // title: StringConstants.password,
                    controller: controller.passwordController,
                    isCard: controller.isPassword,
                    hintText: StringConstants.password,
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
                  ),
                  SizedBox(height: 34.px),
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    obscureText: controller.conPasswordHide,
                    maxLines: 1,
                    focusNode: controller.focusConPassword,
                    // title: StringConstants.conPassword,
                    controller: controller.conPasswordController,
                    isCard: controller.isConPassword,
                    hintText: StringConstants.conPassword,
                    suffixIcon: GestureDetector(
                      onTap: () => controller.clickOnConPasswordEyeButton(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonMethods.iconLinearGradient(
                              assetName: controller.conPasswordHide
                                  ? IconConstants.icHide
                                  : IconConstants.icView,
                              value: controller.isConPassword,
                              context: context),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
