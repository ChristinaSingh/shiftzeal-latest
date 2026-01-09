import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shiftzeal/apis/api_models/get_signup_model.dart';
import 'package:shiftzeal/apis/api_models/user_model.dart';
import 'package:shiftzeal/common/common_methods.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/date_picker_view.dart';
import '../../common/local_data.dart';
import '../../common/navigation_methos.dart';
import '../find_my_invitation/find_my_invitation_screen.dart';
import '../login/login_screen.dart';
import '../sendInvitation/send_Invitation_screen.dart';

class SignUpController extends ChangeNotifier {
  bool isFirstName = false;
  bool isLastName = false;
  bool isPhone = false;
  bool isGender = false;
  bool isDateOfBirth = false;
  bool isRole = false;
  bool isEmail = false;
  bool isPassword = false;
  bool isConPassword = false;
  bool inAsyncCall = false;
  bool isPosition = false;
  bool isEmployerCode = false;

  FocusNode focusFirstName = FocusNode();
  FocusNode focusLastName = FocusNode();
  FocusNode focusPhone = FocusNode();
  FocusNode focusPosition = FocusNode();
  FocusNode focusGender = FocusNode();
  FocusNode focusDateOfBirth = FocusNode();
  FocusNode focusRole = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();
  FocusNode focusConPassword = FocusNode();
  FocusNode focusEmployerCode = FocusNode();

  String? selectedGender;
  String? selectedRole;
  String? selectedPosition;
  bool passwordHide = true;
  bool conPasswordHide = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController employerCodeController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void startListener() {
    focusFirstName.addListener(onFocusChange);
    focusLastName.addListener(onFocusChange);
    focusPhone.addListener(onFocusChange);
    focusGender.addListener(onFocusChange);
    focusDateOfBirth.addListener(onFocusChange);
    focusRole.addListener(onFocusChange);
    focusPosition.addListener(onFocusChange);
    focusEmail.addListener(onFocusChange);
    focusPassword.addListener(onFocusChange);
    focusConPassword.addListener(onFocusChange);
    focusEmployerCode.addListener(onFocusChange);
  }

  void onFocusChange() {
    isFirstName = focusFirstName.hasFocus;
    isLastName = focusLastName.hasFocus;
    isPhone = focusPhone.hasFocus;
    isGender = focusGender.hasFocus;

    isPosition = focusPosition.hasFocus;
    isEmployerCode = focusEmployerCode.hasFocus;
    isDateOfBirth = focusDateOfBirth.hasFocus;
    isRole = focusRole.hasFocus;
    isEmail = focusEmail.hasFocus;
    isPassword = focusPassword.hasFocus;
    isConPassword = focusConPassword.hasFocus;

    notifyListeners();
  }

  clickOnDateOfBirth({required BuildContext context}) async {
    DateTime? dateTime = await PickDate.pickDateView(
        color: Theme.of(context).primaryColor, context: context);
    if (dateTime != null) {
      DateTime dateTime1 = DateTime.parse(dateTime.toString());
      dateOfBirthController.text = DateFormat('dd-MM-yyyy').format(dateTime1);
      notifyListeners();
    }
  }

  void setPosition(String? value) {
    selectedPosition = value;
    notifyListeners();
  }

  Future<void> selectDate({required BuildContext context}) async {
    CommonMethods.unFocsKeyBoard();
    DateTime? picked = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      initialDate: DateTime(2000),
      firstDate: DateTime(1940),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).primaryColor,
            hintColor: Theme.of(context).primaryColor,
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      print("Selected date: $formattedDate");
      dateOfBirthController.text = formattedDate;
    }
  }

  clickOnPasswordEyeButton() {
    passwordHide = !passwordHide;
    notifyListeners();
  }

  clickOnConPasswordEyeButton() {
    conPasswordHide = !conPasswordHide;
    notifyListeners();
  }

  clickOnLoginButton({required BuildContext context}) {
    NavigationMethods.popMethod(context: context);
  }

  clickOnSignInWithGoogleButton({required BuildContext context}) {}

  clickOnSignUpButton({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const SendInvitationScreen());
  }

  clickOnGenderField({required BuildContext context, dynamic value}) {
    selectedGender = value;
    print("selectedGender  :::: $selectedGender");
    print("selectedGender  :::: $value");
    genderController.text = selectedGender!;
    notifyListeners();
  }

  void setGender(String? gender) {
    selectedGender = gender;
    print("selectedGender new :::: $selectedGender");
    genderController.text = selectedGender!;
    print("selectedGender new text :::: ${genderController.text}");
    notifyListeners();
  }

  clickOnValue({required String value}) {
    selectedGender = value;
    print("selectedGender  :::: $selectedGender");
    genderController.text = selectedGender!;
    notifyListeners();
  }

  clickOnRoleField({required BuildContext context, required value}) {
    selectedRole = value;
    notifyListeners();
  }

  clickSignUpButton({required BuildContext context}) async {
    // Map<String, String> bodyParam = {
    //   ApiKeyConstants.firstName: firstNameController.text,
    //   ApiKeyConstants.lastName: lastNameController.text,
    //   ApiKeyConstants.mobileNumber: phoneController.text,
    //   ApiKeyConstants.email: emailController.text,
    //   ApiKeyConstants.gender: genderController.text,
    //   ApiKeyConstants.dob: dateOfBirthController.text,
    //   ApiKeyConstants.position: positionController.text,
    //   ApiKeyConstants.password: conPasswordController.text,
    //   ApiKeyConstants.type: LocalData.userType,
    // };
    //
    // print("bodyPram ::: $bodyParam");

    if (phoneController.text.trim().isNotEmpty &&
        conPasswordController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        dateOfBirthController.text.isNotEmpty &&
        selectedPosition!.isNotEmpty &&
        emailController.text.isNotEmpty) {
      inAsyncCall = true;
      notifyListeners();
      Map<String, String> bodyParam = {
        ApiKeyConstants.firstName: firstNameController.text,
        ApiKeyConstants.lastName: lastNameController.text,
        ApiKeyConstants.mobileNumber: phoneController.text,
        ApiKeyConstants.email: emailController.text,
        ApiKeyConstants.gender: genderController.text,
        ApiKeyConstants.dob: dateOfBirthController.text,
        ApiKeyConstants.position: selectedPosition.toString(),
        ApiKeyConstants.password: conPasswordController.text,
        ApiKeyConstants.type: LocalData.userType,
        ApiKeyConstants.employeeCode: "12345",
      };
      SignUpModel? userModel =
          await ApiMethods.signupUser(context: context, bodyParams: bodyParam);
      if (userModel != null &&
          userModel.status != null &&
          userModel.status != "0") {
        CommonWidgets.showMyToastMessage(
            userModel.message ?? 'Something went wrong');

        NavigationMethods.pushAndRemoveUntilMethod(
            context: context, widget: const LoginScreen());
      } else {
        CommonWidgets.showMyToastMessage(
            userModel?.message ?? 'Something went wrong');
      }
    } else {
      CommonWidgets.showMyToastMessage('Phone number field required!');
    }
    inAsyncCall = false;
    notifyListeners();
  }
}
