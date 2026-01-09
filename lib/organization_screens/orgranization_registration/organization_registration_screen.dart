import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import '../../common/navigation_methos.dart';
import 'organization_registration_controller.dart';


class OrganizationRegistrationScreen extends StatefulWidget {
  const OrganizationRegistrationScreen({super.key});
  @override
  State<OrganizationRegistrationScreen> createState() =>
      _OrganizationRegistrationScreenState();
}



class _OrganizationRegistrationScreenState
    extends State<OrganizationRegistrationScreen> {
  @override
  void initState() {
    super.initState();
    var signUpController =
        Provider.of<OrganizationRegistrationController>(context, listen: false);
    signUpController.startListener();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OrganizationRegistrationController>(
      builder: (context, controller, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.px),

                    /// Back + Logo
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              NavigationMethods.popMethod(context: context),
                          child: CommonWidgets.appIcons(
                            assetName: IconConstants.icBlueBack,
                            height: 40.px,
                            width: 40.px,
                          ),
                        ),
                        const Spacer(),
                        CommonMethods.appIcons(
                          assetName: IconConstants.icSplashLogo,
                          height: 60.px,
                          width: 60.px,
                        ),
                        const Spacer(),
                        SizedBox(width: 40.px),
                      ],
                    ),

                    SizedBox(height: 30.px),

                    /// Organization Photo (Top Section)
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 150.px,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.px),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2),
                              color: Colors.grey.shade200,
                              image: controller.organizationPhoto != null
                                  ? DecorationImage(
                                      image: FileImage(
                                          controller.organizationPhoto!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: controller.organizationPhoto == null
                                ? const Icon(Icons.business,
                                    size: 50, color: Colors.grey)
                                : null,
                          ),
                          // Upload/Change overlay
                          Positioned.fill(
                            child: Material(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12.px),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.px),
                                onTap: () => controller.pickOrganizationPhoto(),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade200
                                          .withOpacity(0.7),
                                    ),

                                    child: Text(
                                      controller.organizationPhoto == null
                                          ? "Upload"
                                          : "Change",
                                      style: TextStyle(
                                        color: Color(0xffffE60001) ,
                                        fontSize: 16.px,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.px),

                    /// Organization Name
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.organizationNameController,
                      focusNode: controller.focusOrganizationName,
                      isCard: controller.isOrganizationName,
                      hintText: "Organization Name",
                    ),
                    SizedBox(height: 20.px),

                    /// Contact Number
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.contactNumberController,
                      focusNode: controller.focusContactNumber,
                      isCard: controller.isContactNumber,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: "Contact Number",
                    ),
                    SizedBox(height: 20.px),

                    /// Email
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.emailController,
                      focusNode: controller.focusEmail,
                      isCard: controller.isEmail,
                      hintText: "Email ID",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.px),

                    /// First Name
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.firstNameController,
                      focusNode: controller.focusFirstName,
                      isCard: controller.isFirstName,
                      hintText: "First Name",
                    ),
                    SizedBox(height: 20.px),

                    /// Last Name
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.lastNameController,
                      focusNode: controller.focusLastName,
                      isCard: controller.isLastName,
                      hintText: "Last Name",
                    ),
                    SizedBox(height: 20.px),

                    /// Date of Incorporation
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.dateOfIncorpController,
                      focusNode: controller.focusDateOfIncorp,
                      isCard: controller.isDateOfIncorp,
                      readOnly: true,
                      onTap: () =>
                          controller.selectDateOfIncorp(context: context),
                      hintText: "Date of Incorporation",
                      suffixIcon: InkWell(
                        onTap: () =>
                            controller.selectDateOfIncorp(context: context),
                        borderRadius: BorderRadius.circular(10.px),
                        child: const Icon(Icons.calendar_today,
                            color: Color(0xffffE60001)),
                      ),
                    ),
                    SizedBox(height: 20.px),

                    /// Password
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      obscureText: controller.passwordHide,
                      controller: controller.passwordController,
                      focusNode: controller.focusPassword,
                      isCard: controller.isPassword,
                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: () => controller.clickOnPasswordEyeButton(),
                        child: Icon(
                          controller.passwordHide
                              ? Icons.visibility_off
                              : Icons.visibility,
                            color: Color(0xffffE60001)
                        ),
                      ),
                    ),
                    SizedBox(height: 20.px),

                    /// Confirm Password
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      obscureText: controller.conPasswordHide,
                      controller: controller.conPasswordController,
                      focusNode: controller.focusConPassword,
                      isCard: controller.isConPassword,
                      hintText: "Confirm Password",
                      suffixIcon: GestureDetector(
                        onTap: () => controller.clickOnConPasswordEyeButton(),
                        child: Icon(
                          controller.conPasswordHide
                              ? Icons.visibility_off
                              : Icons.visibility,
                            color: Color(0xffffE60001)
                        ),
                      ),
                    ),
                    SizedBox(height: 30.px),

                    /// Submit Button
                    CommonWidgets.commonCustumeButton(
                      onPressed: () =>
                          controller.clickSignUpButton(context: context),
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
