import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/progress_bar.dart';
import '../../constants/image_constants.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    var editProfileController =
        Provider.of<EditProfileController>(context, listen: false);
    editProfileController.getProfileApi(context: context);
    editProfileController.startListener();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(context: context, title: "Edit Profile"),
          body: SafeArea(
            child: ProgressBar(
              inAsyncCall: controller.inLoading,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.px,
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            (controller.image != null)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.px),
                                    ),
                                    child: Image.file(
                                      height: 100.px,
                                      width: 100.px,
                                      fit: BoxFit.cover,
                                      File(
                                        controller.image?.path ?? '',
                                      ),
                                    ),
                                  )
                                : (controller.userData != null &&
                                        controller.userData!.image != null &&
                                        controller.userData!.image!.isNotEmpty)
                                    ? controller.inLoading
                                        ? CommonWidgets.imageView(
                                            image: StringConstants
                                                .defaultNetworkImage,
                                            height: 100.px,
                                            width: 100.px,
                                            borderRadius:
                                                BorderRadius.circular(50.px),
                                            fit: BoxFit.cover,
                                            defaultNetworkImage: StringConstants
                                                .defaultNetworkImage)
                                        : CommonWidgets.imageView(
                                            image: controller
                                                        .userData!.image! ==
                                                    "https://server-php-8-3.technorizen.com/ShiftRoster/public/uploads/users"
                                                ? controller.userData!.image!
                                                : StringConstants
                                                    .defaultNetworkImage,
                                            height: 100.px,
                                            width: 100.px,
                                            borderRadius:
                                                BorderRadius.circular(50.px),
                                            fit: BoxFit.cover,
                                            defaultNetworkImage: StringConstants
                                                .defaultNetworkImage)
                                    : CommonWidgets.imageView(
                                        image:
                                            StringConstants.defaultNetworkImage,
                                        height: 100.px,
                                        width: 100.px,
                                        borderRadius:
                                            BorderRadius.circular(50.px),
                                        fit: BoxFit.cover,
                                        defaultNetworkImage: StringConstants
                                            .defaultNetworkImage),
                            InkWell(
                              onTap: () =>
                                  controller.showAlertDialog(context: context),
                              child: CommonMethods.appIcons(
                                assetName: IconConstants.icAdd,
                                height: 30.px,
                                width: 30.px,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.px),
                      CommonWidgets.normalTextFieldForLoginSignUP(
                        context: context,
                        focusNode: controller.focusFirstName,
                        controller: controller.firstNameController,
                        isCard: controller.isFirstName,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        hintText: StringConstants.firstName,
                      ),

                      SizedBox(height: 15.px),
                      CommonWidgets.normalTextFieldForLoginSignUP(
                        context: context,
                        focusNode: controller.focusLastName,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        //title: StringConstants.lastName,
                        controller: controller.lastNameController,
                        isCard: controller.isLastName,
                        hintText: StringConstants.lastName,
                      ),
                      SizedBox(height: 15.px),
                      CommonWidgets.normalTextFieldForLoginSignUP(
                        context: context,
                        focusNode: controller.focusPhone,
                        keyboardType: TextInputType.phone,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        //title: StringConstants.lastName,
                        controller: controller.phoneController,
                        isCard: controller.isPhoneName,
                        hintText: StringConstants.phoneNumber,
                      ),
                      SizedBox(height: 15.px),
                      // CommonWidgets.commonTextFieldDropDownForLoginSignUP(
                      //   context: context,
                      //   items: (filter, infiniteScrollProps) => [
                      //     "Male",
                      //     "Female",
                      //     "Other",
                      //   ],
                      //   onChanged: (value) => controller.clickOnGenderField(
                      //       context: context, value: value),
                      //   readOnly: true,
                      //   focusNode: controller.focusGender,
                      //   //title: StringConstants.gender,
                      //   controller: controller.genderController,
                      //   contentPadding:
                      //   EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      //   isCard: controller.isGender,
                      //   hintText: StringConstants.gender,
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          // Grey background like image
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            value: controller.selectedGender,
                            isExpanded: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                              hintText: 'Gender',
                              hintStyle:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            dropdownColor: Colors.white,
                            // Background of dropdown menu
                            style: const TextStyle(color: Colors.black),
                            // Text color in menu
                            items: ['Male', 'Female', 'Other']
                                .map((gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(
                                        gender,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              controller.setGender(value);
                              print("Selected Gender: $value");
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 15.px),
                      CommonWidgets.normalTextFieldForLoginSignUP(
                        context: context,
                        readOnly: true,
                        onTap: () {
                          controller.selectDate(context: context);
                        },
                        focusNode: controller.focusDateOfBirth,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        // title: StringConstants.dateOfBirth,
                        controller: controller.dateOfBirthController,
                        isCard: controller.isDateOfBirth,
                        hintText: StringConstants.dateOfBirth,
                      ),
                      SizedBox(height: 15.px),
                      CommonWidgets.normalTextFieldForLoginSignUP(
                        context: context,
                        focusNode: controller.focusPosition,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        //title: StringConstants.position,
                        controller: controller.positionController,
                        isCard: controller.isPosition,
                        hintText: StringConstants.position,
                      ),
                      SizedBox(height: 15.px),
                      CommonWidgets.normalTextFieldForLoginSignUP(
                        context: context,
                        focusNode: controller.focusEmail,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        // title: StringConstants.email,
                        controller: controller.emailController,
                        isCard: controller.isEmail,
                        hintText: StringConstants.email,
                      ),
                      SizedBox(height: 20.px),
                      // CommonWidgets.commonElevatedButton(
                      //     height: 60.px,
                      //     wantContentSizeButton: true,
                      //     contentPadding:
                      //     EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      //     width: MediaQuery.sizeOf(context).width - 40,
                      //     context: context,
                      //     borderRadius: 15,
                      //     onPressed: () =>
                      //         controller.clickOnSaveButton(context: context),
                      //     text: StringConstants.save),
                      CommonWidgets.commonCustumeButton(
                        onPressed: () async {
                          controller.clickOnSaveButton(context: context);
                        },
                        borderRadius: 15.px,
                        buttonColor: Theme.of(context).primaryColor,
                        child: Text(
                          StringConstants.save,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        showLoading: controller.inAsyncCall,
                        context: context,
                      ),
                      SizedBox(height: 40.px),
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
