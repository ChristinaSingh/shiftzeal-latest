import 'package:flutter/material.dart';
import 'package:shiftzeal/screens/task_detail/task_detail_screen.dart';

import '../../apis/api_methods/api_methods.dart';

import '../../apis/api_models/get_my_shift_tasks_model.dart' as taskList;

import '../../common/navigation_methos.dart';
import '../../common/common_widgets.dart';

class TaskController extends ChangeNotifier {
  bool inAsyncCall = false;
  List<taskList.ShiftTaskData> shiftTasksList = [];

  // Call this method from initState in your widget
  void initMethod(BuildContext context, String shiftId) {
    getShiftTask(context: context, shiftId: shiftId);
  }

  // Fetch tasks for a shift
  Future<void> getShiftTask({
    required BuildContext context,
    required String shiftId,
  }) async {
    inAsyncCall = true;
    notifyListeners();

    try {
      final bodyParam = {
        "shift_id": shiftId,
      };

      final taskList.GetShiftTasksModel? shiftTasksModel =
          await ApiMethods.getShiftTasksApi(
        context: context,
        bodyParams: bodyParam,
      );

      if (shiftTasksModel != null &&
          shiftTasksModel.status != null &&
          shiftTasksModel.status != "0") {
        shiftTasksList = shiftTasksModel.data ?? [];
        notifyListeners();
      } else {
        final msg = shiftTasksModel?.message ?? "Something went wrong";
        CommonWidgets.showMyToastMessage(msg);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  // Handle click on task list item
  void clickOnListTile({
    required BuildContext context,
    required int index,
    required String taskId,
  }) {
    NavigationMethods.pushMethod(
      context: context,
      widget: TaskDetailScreen( taskId: taskId, ),
    );
  }

  // Placeholder for submit button
  void clickOnSubmitButton({required BuildContext context}) {}
}
