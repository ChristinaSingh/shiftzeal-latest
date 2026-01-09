import 'package:flutter/material.dart';
import 'package:shiftzeal/screens/task_detail/task_detail_screen.dart';

import '../../common/navigation_methos.dart';

class AttendanceNoticesController extends ChangeNotifier {
  clickOnListTile({required BuildContext context, required int index}) {
    NavigationMethods.pushMethod(context: context, widget: TaskDetailScreen(taskId: "1",));
  }

  clickOnClockOthersInOrOut({required BuildContext context}) {}
}
