import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/screens/select_employer/select_employer_screen.dart';
import 'package:shiftzeal/screens/setting/setting_controller.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/get_profile_model.dart';
import '../../apis/api_models/update_profile_model.dart';
import '../../common/alert_dialog_view.dart';
import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/date_picker_view.dart';
import '../../common/image_pick_and_crop.dart';
import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';

class EditProfileController extends ChangeNotifier {
  bool isFirstName = false;
  bool isLastName = false;
  bool isPhoneName = false;
  bool isGender = false;
  bool isDateOfBirth = false;
  bool isPosition = false;
  bool isEmail = false;
  bool isPassword = false;
  String? selectedGender;
  bool inAsyncCall = false;
  bool inLoading = true;
  UserData? userData;

  File? image;

  FocusNode focusFirstName = FocusNode();
  FocusNode focusLastName = FocusNode();
  FocusNode focusPhone = FocusNode();
  FocusNode focusGender = FocusNode();
  FocusNode focusDateOfBirth = FocusNode();
  FocusNode focusPosition = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();

  clickOnGenderField({required BuildContext context, dynamic value}) {
    selectedGender = value;
    notifyListeners();
  }

  bool passwordHide = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void startListener() {
    focusFirstName.addListener(onFocusChange);
    focusLastName.addListener(onFocusChange);
    focusGender.addListener(onFocusChange);
    focusDateOfBirth.addListener(onFocusChange);
    focusPosition.addListener(onFocusChange);
    focusEmail.addListener(onFocusChange);
    focusPassword.addListener(onFocusChange);
    focusPhone.addListener(onFocusChange);
  }

  void onFocusChange() {
    isFirstName = focusFirstName.hasFocus;
    isLastName = focusLastName.hasFocus;
    isGender = focusGender.hasFocus;
    isDateOfBirth = focusDateOfBirth.hasFocus;
    isPosition = focusPosition.hasFocus;
    isEmail = focusEmail.hasFocus;
    isPassword = focusPassword.hasFocus;
    isPhoneName = focusPhone.hasFocus;
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

  void setGender(String? gender) {
    selectedGender = gender;
    print("selectedGender new :::: $selectedGender");
    genderController.text = selectedGender!;
    print("selectedGender new text :::: ${genderController.text}");
    notifyListeners();
  }

  Future<void> selectDate({required BuildContext context}) async {
    CommonMethods.unFocsKeyBoard();
    DateTime? picked = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      initialDate: DateTime(2000),
      // Set a more reasonable default date
      firstDate: DateTime(1940),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                Theme.of(context).primaryColor, // Header background color
            hintColor:
                Theme.of(context).primaryColor, // Selected date circle color
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor, // Selection color
              onPrimary: Colors.white, // Text color on selected date
              onSurface: Colors.black, // Default text color
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the picker
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

  clickOnLoginButton({required BuildContext context}) {
    NavigationMethods.popMethod(context: context);
  }

  clickOnSignInWithGoogleButton({required BuildContext context}) {}

  clickOnSaveButton({required BuildContext context}) {
    clickUpdateButton(context: context);
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

  getProfileApi({required BuildContext context}) async {
    GetProfileModel? userModel =
        await ApiMethods.getProfile(context: context, bodyParams: {});
    if (userModel != null && userModel.data?.userData != null) {
      userData = userModel.data?.userData!;
      firstNameController.text = userData?.firstName ?? "";
      lastNameController.text = userData?.lastName ?? "";
      phoneController.text = userData?.mobileNumber ?? "";
      emailController.text = userData?.email ?? "";
      genderController.text = userData?.gender ?? "";
      dateOfBirthController.text = userData?.dob ?? "";
      positionController.text = userData?.position ?? "";
      selectedGender = userData?.gender ?? "";
      inLoading = false;
      notifyListeners();
    } else {
      CommonWidgets.showMyToastMessage(
          userModel?.message ?? 'Something went wrong');
    }
    inLoading = false;
    notifyListeners();
  }

  clickUpdateButton({required BuildContext context}) async {
    if (firstNameController.text.trim().isNotEmpty) {
      inAsyncCall = true;
      notifyListeners();
      UpdatedProfileModel? userModel = await ApiMethods.createProfile(
          image: image,
          imageKey: ApiKeyConstants.image,
          context: context,
          bodyParams: {
            ApiKeyConstants.firstName: firstNameController.text,
            ApiKeyConstants.lastName: lastNameController.text,
            ApiKeyConstants.mobileNumber: phoneController.text,
            ApiKeyConstants.email: emailController.text,
            ApiKeyConstants.gender: genderController.text,
            ApiKeyConstants.dob: dateOfBirthController.text,
            ApiKeyConstants.position: positionController.text,
          });
      if (userModel != null &&
          userModel.status != null &&
          userModel.status != 0) {
        await getProfileApi(context: context);
        var settingController =
            Provider.of<SettingController>(context, listen: false);
        settingController.initMethod(context: context);
        Navigator.pop(context);
        CommonWidgets.showMyToastMessage(
            userModel.message ?? 'Successfully Send your request.');
        notifyListeners();
      } else {
        if (userModel != null &&
            userModel.message != null &&
            userModel.message!.isNotEmpty) {
          CommonWidgets.showMyToastMessage(
              userModel.message ?? 'Successfully Send your request.');
        } else {
          CommonWidgets.showMyToastMessage(
              userModel?.message ?? 'Successfully Send your request.');
        }
      }
      inAsyncCall = false;
      notifyListeners();
    } else {
      CommonWidgets.showMyToastMessage('Failed');
    }
  }
}
