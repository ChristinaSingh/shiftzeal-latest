import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/navigation_methos.dart';
import '../../common/progress_bar.dart';
import 'sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    var loginController = Provider.of<SignUpController>(context, listen: false);
    loginController.startListener();
  }

// Custom styled container for Dropdowns (Text & Icon Black, Background Light Grey)
  Widget _buildStyledDropdown({
    required BuildContext context,
    required String hintText,
    required List<String> items,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    // Determine the base text style from the theme
    final TextStyle? baseTextStyle = Theme.of(context).textTheme.titleMedium;

    // Set the text and icon color explicitly to Black
    final Color blackColor = Colors.black;

    // Define the light background color as per your original design (F0F0F0)
    final Color lightBackgroundColor = const Color(0xFFF0F0F0);

    return Container(
      decoration: BoxDecoration(
        color: lightBackgroundColor, // Light grey background
        borderRadius:
            BorderRadius.circular(14.px), // Consistent rounded corners
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.px),
              borderSide: BorderSide.none, // Hide the border
            ),
            fillColor: lightBackgroundColor, // Fill with light grey color
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 18.px, horizontal: 18.px),

            // Hint Text: Black but slightly faded
            hintText: hintText,
            hintStyle:
                baseTextStyle?.copyWith(color: blackColor.withOpacity(0.6)),
          ),

          // Custom icon for the dropdown arrow, now BLACK
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: blackColor),

          // Dropdown menu background color (White)
          dropdownColor: Colors.white,

          // Selected Text Color in the Field: Black
          style: baseTextStyle?.copyWith(color: blackColor),

          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      // Item Text Color in the Dropdown List: Black
                      style: baseTextStyle?.copyWith(color: blackColor),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpController>(
      builder: (context, controller, child) {
        return Scaffold(
          // Set background color if needed, otherwise Scaffold uses theme background
          // backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
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
                            const Spacer(),
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

                    // --- Input Fields (Assuming CommonWidgets.normalTextFieldForLoginSignUP matches the image) ---
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
                      controller: controller.lastNameController,
                      isCard: controller.isLastName,
                      hintText: StringConstants.lastName,
                    ),
                    SizedBox(height: 20.px),
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      focusNode: controller.focusPhone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.phone,
                      controller: controller.phoneController,
                      isCard: controller.isPhone,
                      hintText: StringConstants.phoneNumber,
                    ),
                    SizedBox(height: 20.px),
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      focusNode: controller.focusEmail,
                      controller: controller.emailController,
                      isCard: controller.isEmail,
                      hintText: StringConstants.email,
                    ),
                    SizedBox(height: 20.px),

                    // --- GENDER Dropdown (Now visually matched) ---
                    _buildStyledDropdown(
                      context: context,
                      hintText:
                          'Female', // Using a placeholder that shows the style
                      items: const ['Male', 'Female', 'Other'],
                      selectedValue: controller.selectedGender,
                      onChanged: (value) {
                        controller.setGender(value);
                        print("Selected Gender: $value");
                      },
                    ),

                    SizedBox(height: 20.px),
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      focusNode: controller.focusDateOfBirth,
                      controller: controller.dateOfBirthController,
                      isCard: controller.isDateOfBirth,
                      readOnly: true,
                      onTap: () => controller.selectDate(context: context),
                      hintText: StringConstants.dateOfBirth,
                      suffixIcon: InkWell(
                        onTap: () => controller.selectDate(context: context),
                        borderRadius: BorderRadius.circular(10.px),
                        child: CommonMethods.appIcons(
                            assetName: IconConstants.icSchedule,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20.px),
                    _buildStyledDropdown(
                      context: context,
                      hintText: StringConstants.position, // Use Position hint
                      items: const ['Supervisor', 'Manager', 'User'],
                      selectedValue: controller.selectedPosition,
                      onChanged: (value) {
                        controller.setPosition(value);
                        print("Selected Position: $value");
                      },
                    ),

                    SizedBox(height: 20.px),
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      obscureText: controller.passwordHide,
                      focusNode: controller.focusPassword,
                      maxLines: 1,
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
                    SizedBox(height: 20.px),
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      obscureText: controller.conPasswordHide,
                      maxLines: 1,
                      focusNode: controller.focusConPassword,
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
                    // SizedBox(height: 20.px),
                    // CommonWidgets.normalTextFieldForLoginSignUP(
                    //   context: context,
                    //   focusNode: controller.focusEmployerCode,
                    //   controller: controller.employerCodeController,
                    //   isCard: controller.isEmployerCode,
                    //   hintText: StringConstants.employerCode,
                    // ),

                    SizedBox(height: 30.px),
                    CommonWidgets.commonCustumeButton(
                      onPressed: () async {
                        controller.clickSignUpButton(context: context);
                      },
                      borderRadius: 15.px,
                      buttonColor: Theme.of(context).primaryColor,
                      child: Text(
                        StringConstants.signUp,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      showLoading: controller.inAsyncCall,
                      context: context,
                    ),
                    SizedBox(height: 40.px),
                    GestureDetector(
                      onTap: () =>
                          controller.clickOnLoginButton(context: context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringConstants.alreadyHaveAnAccountYet,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 14.px),
                          ),
                          SizedBox(width: 4.px),
                          Text(
                            StringConstants.login,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontSize: 16.px,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.px),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
