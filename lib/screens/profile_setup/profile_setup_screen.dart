import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/navigation_methos.dart';
import '../../constants/image_constants.dart';
import 'profile_setup_controller.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  @override
  void initState() {
    super.initState();
    var profileSetupController =
        Provider.of<ProfileSetupController>(context, listen: false);
    profileSetupController.startListener();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileSetupController>(
      builder: (context, controller, child) {
        return Scaffold(
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
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    focusNode: controller.focusFirstName,
                    controller: controller.firstNameController,
                    isCard: controller.isFirstName,
                    hintText: StringConstants.firstName,
                  ),
                  SizedBox(height: 20.px),
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    focusNode: controller.focusLastName,
                    //title: StringConstants.lastName,
                    controller: controller.lastNameController,
                    isCard: controller.isLastName,
                    hintText: StringConstants.lastName,
                  ),
                  SizedBox(height: 20.px),
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    focusNode: controller.focusPhoneNumber,
                    keyboardType: TextInputType.phone,
                    //title: StringConstants.lastName,
                    controller: controller.phoneController,
                    isCard: controller.isPhoneNumber,
                    hintText: StringConstants.phoneNumber,
                  ),
                  SizedBox(height: 20.px),
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    focusNode: controller.focusPhoneNumber,
                    //title: StringConstants.lastName,
                    controller: controller.phoneController,
                    isCard: controller.isPhoneNumber,
                    hintText: StringConstants.phone,
                  ),
                  SizedBox(height: 20.px),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    context: context,
                    focusNode: controller.focusGender,
                    //title: StringConstants.gender,
                    controller: controller.genderController,
                    isCard: controller.isGender,
                    hintText: StringConstants.gender,
                  ),
                  SizedBox(height: 20.px),
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    readOnly: true,
                    onTap: (){
                      controller.clickOnDate(context: context);
                    },
                    focusNode: controller.focusDateOfBirth,
                    // title: StringConstants.dateOfBirth,
                    controller: controller.dateOfBirthController,
                    isCard: controller.isDateOfBirth,
                    hintText: StringConstants.dateOfBirth,
                  ),
                  SizedBox(height: 20.px),
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    focusNode: controller.focusPosition,
                    //title: StringConstants.position,
                    controller: controller.positionController,
                    isCard: controller.isPosition,
                    hintText: StringConstants.position,
                  ),
                  SizedBox(height: 20.px),
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    focusNode: controller.focusEmail,
                    // title: StringConstants.email,
                    controller: controller.emailController,
                    isCard: controller.isEmail,
                    hintText: StringConstants.email,
                  ),
                  SizedBox(height: 30.px),
                  CommonWidgets.commonElevatedButton(
                      context: context,
                      onPressed: () =>
                          controller.clickOnSaveButton(context: context),
                      text: StringConstants.save),
                  SizedBox(height: 40.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
