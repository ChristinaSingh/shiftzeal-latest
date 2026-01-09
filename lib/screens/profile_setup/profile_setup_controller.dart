import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/screens/select_employer/select_employer_screen.dart';

import '../../common/alert_dialog_view.dart';
import '../../common/date_picker_view.dart';
import '../../common/image_pick_and_crop.dart';
import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';

class ProfileSetupController extends ChangeNotifier {
  bool isFirstName = false;
  bool isLastName = false;
  bool isPhoneNumber = false;
  bool isGender = false;
  bool isDateOfBirth = false;
  bool isPosition = false;
  bool isEmail = false;
  bool isPassword = false;

  File? image;

  FocusNode focusFirstName = FocusNode();
  FocusNode focusLastName = FocusNode();
  FocusNode focusPhoneNumber = FocusNode();
  FocusNode focusGender = FocusNode();
  FocusNode focusDateOfBirth = FocusNode();
  FocusNode focusPosition = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();

  bool passwordHide = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void startListener() {
    focusFirstName.addListener(onFocusChange);
    focusLastName.addListener(onFocusChange);
    focusPhoneNumber.addListener(onFocusChange);
    focusGender.addListener(onFocusChange);
    focusDateOfBirth.addListener(onFocusChange);
    focusPosition.addListener(onFocusChange);
    focusEmail.addListener(onFocusChange);
    focusPassword.addListener(onFocusChange);
  }

  void onFocusChange() {
    isFirstName = focusFirstName.hasFocus;
    isLastName = focusLastName.hasFocus;
    isPhoneNumber = focusPhoneNumber.hasFocus;
    isGender = focusGender.hasFocus;
    isDateOfBirth = focusDateOfBirth.hasFocus;
    isPosition = focusPosition.hasFocus;
    isEmail = focusEmail.hasFocus;
    isPassword = focusPassword.hasFocus;
    notifyListeners();
  }

  clickOnDate({required BuildContext context}) async {
    DateTime? dateTime = await PickDate.pickDateView(
        color: Theme.of(context).primaryColor, context: context);
    if (dateTime != null) {
      DateTime dateTime1 = DateTime.parse(dateTime.toString());
      dateOfBirthController.text = DateFormat('dd-MM-yyyy').format(dateTime1);
      notifyListeners();
    }
  }

  clickOnPasswordEyeButton() {
    passwordHide = !passwordHide;
    notifyListeners();
  }

  clickOnLoginButton({required BuildContext context}) {
    NavigationMethods.popMethod(context: context);
  }

  clickOnSignInWithGoogleButton({required BuildContext context}) {}

  clickOnSaveButton({required BuildContext context}) {
    /* NavigationMethods.pushMethod(
        context: context, widget: const SelectEmployerScreen());*/
  }

  void showAlertDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: cameraTextButtonView(context: context),
              onPressed: () => clickCameraTextButtonView(context: context),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: galleryTextButtonView(context: context),
              onPressed: () => clickGalleryTextButtonView(context: context),
            ),
          ],
          title: selectImageTextView(context: context),
          content: contentTextView(context: context),
        );
      },
    );
  }

  Widget selectImageTextView({required BuildContext context}) => Text(
        StringConstants.selectImage,
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 18.px),
      );

  Widget contentTextView({required BuildContext context}) => Text(
        StringConstants.chooseImageFromTheOptionsBelow,
        style:
            Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 14.px),
      );

  Widget cameraTextButtonView({required BuildContext context}) => Text(
        StringConstants.camera,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontSize: 14.px, color: Theme.of(context).primaryColor),
      );

  Widget galleryTextButtonView({required BuildContext context}) => Text(
        StringConstants.gallery,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontSize: 14.px, color: Theme.of(context).primaryColor),
      );

  Future<void> clickCameraTextButtonView(
      {required BuildContext context}) async {
    pickCamera(context: context);
    NavigationMethods.popMethod(context: context);
  }

  Future<void> clickGalleryTextButtonView(
      {required BuildContext context}) async {
    pickGallery(context: context);
    NavigationMethods.popMethod(context: context);
  }

  Future<void> pickCamera({required BuildContext context}) async {
    image = await ImagePickerAndCropper.pickImage(
      context: context,
      wantCropper: true,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
    notifyListeners();
  }

  Future<void> pickGallery({required BuildContext context}) async {
    image = await ImagePickerAndCropper.pickImage(
        context: context,
        wantCropper: true,
        color: Theme.of(context).scaffoldBackgroundColor,
        pickImageFromGallery: true);
    notifyListeners();
  }
}
