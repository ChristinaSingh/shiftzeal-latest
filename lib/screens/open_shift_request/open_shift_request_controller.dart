import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/screens/open_shift_request_details/open_shift_request_details_screen.dart';
import 'package:shiftzeal/screens/open_shift_request_details_basic/open_shift_request_details_basic_screen.dart';
import 'package:shiftzeal/screens/shift_swap/shift_swap_screen.dart';
import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/get_openShift_accept_reject_model.dart';
import '../../apis/api_models/get_open_shift_details_model.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';

class OpenShiftRequestController extends ChangeNotifier {
  bool isLoading = false;
  bool inAsyncCall = false;

  int? selectedShiftIndex;
  List<OpenShiftData> openShifts = [];

  void clickOnRightIcon({required int index, required BuildContext context}) {
    selectedShiftIndex = index;
    NavigationMethods.pushMethod(
      context: context,
      widget: const OpenShiftRequestDetailsScreen(),
    );
  }

  void clickOnRightBasicIcon(
      {required int index, required BuildContext context}) {
    selectedShiftIndex = index;
    NavigationMethods.pushMethod(
      context: context,
      widget: const OpenShiftRequestDetailsBasicScreen(),
    );
  }

  void clickOnShiftSwapButton({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: const ShiftSwapScreen(),
    );
  }

  void clickOnCloseIcon({required int index, required BuildContext context}) {
    selectedShiftIndex = index;
    CommonWidgets.showAlertDialog(
      context: context,
      title: StringConstants.cancellation,
      content: StringConstants.wouldYouLikeToCancelShift,
      onPressedYes: () {
        NavigationMethods.popMethod(context: context);
        cancelShiftRequest(index: index, context: context);
      },
    );
  }

  Future<void> getTodayOpenShifts({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";
    try {
      final today = DateTime.now().toIso8601String().split("T")[0];
      final bodyParam = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.shiftDate: today,
      };

      GetOpenShiftDetailsModel? getOpenShiftDetailsModel =
          await ApiMethods.getOpenShiftDetailsApi(
        context: context,
        bodyParams: bodyParam,
      );

      if (getOpenShiftDetailsModel != null &&
          getOpenShiftDetailsModel.status != null &&
          getOpenShiftDetailsModel.status != "0") {
        openShifts = getOpenShiftDetailsModel.data ?? [];
      } else {
        openShifts.clear();
        final msg = getOpenShiftDetailsModel?.message ?? "Something went wrong";
        // CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
      openShifts.clear();
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  Future<void> acceptOrRejectOpenShift({
    required BuildContext context,
    required String shiftId,
    required String status,
  }) async {
    inAsyncCall = true;
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";
    try {
      final bodyParam = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.shiftId: shiftId,
        ApiKeyConstants.status: status,
      };
      GetOpenShiftAcceptRejectModel? responseModel =
          await ApiMethods.getOpenShiftAcceptRejectApi(
        context: context,
        bodyParams: bodyParam,
      );
      if (responseModel != null &&
          responseModel.status != null &&
          responseModel.status != "0") {
        CommonWidgets.showMyToastMessage(responseModel.message ?? "Success");
        await getTodayOpenShifts(context: context) ;
      } else {
        final msg = responseModel?.message ?? "Something went wrong";
        CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  /// Simulate cancellation process (replace with real API logic)
  Future<void> cancelShiftRequest(
      {required int index, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulated delay
      CommonWidgets.showMyToastMessage("Shift request #$index cancelled");
    } catch (e) {
      CommonWidgets.showMyToastMessage("Cancellation failed: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
