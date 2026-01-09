import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_models/get_my_shifts_model.dart';
import 'package:shiftzeal/screens/shift_details/shift_details_screen.dart';
import 'package:shiftzeal/screens/shift_swap/shift_swap_screen.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';

class MyShiftController extends ChangeNotifier {
  bool inAsyncCall = false;
  List<MyShiftData> shiftList = [];

  // Initialization method
  void initMethod(BuildContext context) {
    getMyShifts(context: context);
  }

  // Navigate to shift details screen
  void clickOnRightIcon({required int index, required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: ShiftDetailsScreen(
        shiftId: shiftList[index].id.toString(),
      ),
    );
  }

  // Navigate to shift swap screen
  void clickOnShiftSwapButton({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: const ShiftSwapScreen(),
    );
  }

  // Show shift cancellation confirmation dialog
  void clickOnCloseIcon({required int index, required BuildContext context}) {
    CommonWidgets.showAlertDialog(
      context: context,
      title: StringConstants.cancellation,
      content: StringConstants.wouldYouLikeToCancelShift,
      onPressedYes: () {
        NavigationMethods.popMethod(context: context);
        CommonWidgets.showMyToastMessage('On Progress');
      },
    );
  }

  // Fetch shift list from API
  Future<void> getMyShifts({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userId = sp.getString(ApiKeyConstants.userId) ?? "0";
    try {
      final bodyParam = {
        ApiKeyConstants.userId: userId,
      };

      final GetMyShiftModel? getMyShiftModel = await ApiMethods.getMyShiftsApi(
        context: context,
        bodyParams: bodyParam,
      );

      if (getMyShiftModel != null &&
          getMyShiftModel.status != null &&
          getMyShiftModel.status != "0") {
        shiftList = getMyShiftModel.data ?? [];
      } else {
        final msg = getMyShiftModel?.message ?? "Something went wrong";
        CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }
}
