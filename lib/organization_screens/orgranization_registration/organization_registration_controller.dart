import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shiftzeal/apis/api_models/get_signup_model.dart';
import 'package:shiftzeal/common/common_methods.dart';
import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/organization_registration_model.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../screens/login/login_screen.dart';

class OrganizationRegistrationController extends ChangeNotifier {
  // Focus handling
  bool isOrganizationName = false;
  bool isContactNumber = false;
  bool isEmail = false;
  bool isFirstName = false;
  bool isLastName = false;
  bool isDateOfIncorp = false;
  bool isPassword = false;
  bool isConPassword = false;
  bool inAsyncCall = false;

  FocusNode focusOrganizationName = FocusNode();
  FocusNode focusContactNumber = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusFirstName = FocusNode();
  FocusNode focusLastName = FocusNode();
  FocusNode focusDateOfIncorp = FocusNode();
  FocusNode focusPassword = FocusNode();
  FocusNode focusConPassword = FocusNode();

  // Controllers
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfIncorpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();

  // Password visibility
  bool passwordHide = true;
  bool conPasswordHide = true;

  // Organization photo
  File? organizationPhoto;

  void startListener() {
    focusOrganizationName.addListener(onFocusChange);
    focusContactNumber.addListener(onFocusChange);
    focusEmail.addListener(onFocusChange);
    focusFirstName.addListener(onFocusChange);
    focusLastName.addListener(onFocusChange);
    focusDateOfIncorp.addListener(onFocusChange);
    focusPassword.addListener(onFocusChange);
    focusConPassword.addListener(onFocusChange);
  }

  void onFocusChange() {
    isOrganizationName = focusOrganizationName.hasFocus;
    isContactNumber = focusContactNumber.hasFocus;
    isEmail = focusEmail.hasFocus;
    isFirstName = focusFirstName.hasFocus;
    isLastName = focusLastName.hasFocus;
    isDateOfIncorp = focusDateOfIncorp.hasFocus;
    isPassword = focusPassword.hasFocus;
    isConPassword = focusConPassword.hasFocus;
    notifyListeners();
  }

  /// Pick organization photo
  Future<void> pickOrganizationPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      organizationPhoto = File(picked.path);
      notifyListeners();
    }
  }

  /// Select Date of Incorporation
  Future<void> selectDateOfIncorp({required BuildContext context}) async {
    CommonMethods.unFocsKeyBoard();
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateOfIncorpController.text = DateFormat('dd-MM-yyyy').format(picked);
      notifyListeners();
    }
  }

  void clickOnPasswordEyeButton() {
    passwordHide = !passwordHide;
    notifyListeners();
  }

  void clickOnConPasswordEyeButton() {
    conPasswordHide = !conPasswordHide;
    notifyListeners();
  }

  void clickOnLoginButton({required BuildContext context}) {
    NavigationMethods.popMethod(context: context);
  }

  /// Sign Up
  /// Sign Up
  Future<void> clickSignUpButton({required BuildContext context}) async {
    if (organizationNameController.text.isEmpty ||
        contactNumberController.text.isEmpty ||
        emailController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        dateOfIncorpController.text.isEmpty ||
        passwordController.text.isEmpty ||
        conPasswordController.text.isEmpty) {
      CommonWidgets.showMyToastMessage('All fields are required!');
      return;
    }

    if (passwordController.text != conPasswordController.text) {
      CommonWidgets.showMyToastMessage('Passwords do not match!');
      return;
    }

    if (organizationPhoto == null) {
      CommonWidgets.showMyToastMessage('Please select an organization photo!');
      return;
    }

    inAsyncCall = true;
    notifyListeners();

    Map<String, String> bodyParam = {
      ApiKeyConstants.organizationName: organizationNameController.text,
      ApiKeyConstants.mobileNumber: contactNumberController.text,
      ApiKeyConstants.email: emailController.text,
      ApiKeyConstants.firstName: firstNameController.text,
      ApiKeyConstants.lastName: lastNameController.text,
      ApiKeyConstants.dateOfIncorporation: dateOfIncorpController.text,
      ApiKeyConstants.password: passwordController.text,
    };

    OrganizationRegistrationModel? userModel =
        await ApiMethods.createOrganizationApi(
      context: context,
      bodyParams: bodyParam,
      image: organizationPhoto,
      imageKey: ApiKeyConstants.image,
    );

    inAsyncCall = false;
    notifyListeners();

    if (userModel != null &&
        userModel.status != null &&
        userModel.status != "0") {
      CommonWidgets.showMyToastMessage(
          userModel.message ?? 'Sign up successful!');

      // Clear all fields and reset state
      organizationNameController.clear();
      contactNumberController.clear();
      emailController.clear();
      firstNameController.clear();
      lastNameController.clear();
      dateOfIncorpController.clear();
      passwordController.clear();
      conPasswordController.clear();
      organizationPhoto = null;
      isOrganizationName = false;
      isContactNumber = false;
      isEmail = false;
      isFirstName = false;
      isLastName = false;
      isDateOfIncorp = false;
      isPassword = false;
      isConPassword = false;

      notifyListeners();

      NavigationMethods.pushAndRemoveUntilMethod(
          context: context, widget: const LoginScreen());
    } else {
      CommonWidgets.showMyToastMessage(
          userModel?.message ?? 'Something went wrong');
    }
  }
}
