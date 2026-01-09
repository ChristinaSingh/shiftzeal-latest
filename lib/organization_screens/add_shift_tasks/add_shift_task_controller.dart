import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_constants/api_key_constants.dart';
import 'package:shiftzeal/apis/api_methods/api_methods.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';

import '../../apis/api_models/get_my_shift_task_model.dart';
import '../../apis/api_models/get_shift_task_details_model.dart';

class AddEmployeeShiftTasksController extends ChangeNotifier {
  bool isHeading = false;
  bool isContent = false;
  bool isDescription = false;
  bool isTaskPoints = false;
  List<ShiftTaskData> taskDetails = [];
  bool inAsyncCall = false;

  // Focus nodes
  FocusNode focusHeading = FocusNode();
  FocusNode focusContent = FocusNode();
  FocusNode focusDescription = FocusNode();
  FocusNode focusTaskPoints = FocusNode();

  // Controllers
  TextEditingController headingController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController taskPointsController = TextEditingController();

  void startListener() {
    focusHeading.addListener(onFocusChange);
    focusContent.addListener(onFocusChange);
    focusDescription.addListener(onFocusChange);
    focusTaskPoints.addListener(onFocusChange);
  }

  void onFocusChange() {
    isHeading = focusHeading.hasFocus;
    isContent = focusContent.hasFocus;
    isDescription = focusDescription.hasFocus;
    isTaskPoints = focusTaskPoints.hasFocus;
    notifyListeners();
  }

  // Future<void> fetchShiftTaskDetails({
  //   required BuildContext context,
  //   required String taskId,
  // }) async {
  //   inAsyncCall = true;
  //   notifyListeners();
  //
  //   try {
  //     final body = {"task_id": taskId};
  //
  //     final model = await ApiMethods.getShiftTasksDataApi(
  //       context: context,
  //       bodyParams: body,
  //     );
  //
  //     if (model != null && model.status != "0") {
  //       taskDetails = model.data ?? [];
  //     } else {
  //       CommonWidgets.showMyToastMessage(model?.message ?? "No data found");
  //     }
  //   } catch (e) {
  //     CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
  //   } finally {
  //     inAsyncCall = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> clickAddShiftTaskButton({
    required BuildContext context,
    required String shiftId,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? adminId = sharedPreferences.getString(ApiKeyConstants.userId);

      if (headingController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          taskPointsController.text.isEmpty) {
        CommonWidgets.showMyToastMessage('All fields are required!');
        return;
      }

      // Parse task points (comma separated string -> List<String>)
      List<String> taskPoints = taskPointsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      CommonMethods.unFocsKeyBoard();

      inAsyncCall = true;
      notifyListeners();

      final Map<String, dynamic> data = {
        ApiKeyConstants.shiftId: shiftId,
        ApiKeyConstants.admin_id: adminId,
        "heading": headingController.text,
        "content": contentController.text,
        "description": descriptionController.text,
        "task_points": taskPoints.join(","),
      };

      print("Shift Task Payload -> $data");

      final response = await ApiMethods.addShiftTasksApi(
        context: context,
        bodyParams: data,
      );

      inAsyncCall = false;
      notifyListeners();

      if (response != null && response.status == "1") {
        CommonWidgets.showMyToastMessage("Shift Task added successfully!");
        // fetchShiftTaskDetails(context:context , taskId: shiftId);
        resetForm();
      } else {
        CommonWidgets.showMyToastMessage(
            response?.message ?? "Failed to add shift task");
      }
    } catch (e) {
      inAsyncCall = false;
      notifyListeners();
      CommonWidgets.showMyToastMessage("Error: $e");
      print("Error in clickAddShiftButton: $e");
    }
  }

  void resetForm() {
    headingController.clear();
    contentController.clear();
    descriptionController.clear();
    taskPointsController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    focusHeading.dispose();
    focusContent.dispose();
    focusDescription.dispose();
    focusTaskPoints.dispose();
    headingController.dispose();
    contentController.dispose();
    descriptionController.dispose();
    taskPointsController.dispose();
    super.dispose();
  }
}
