import 'package:flutter/material.dart';
import 'package:shiftzeal/admin_screens/add_task_lists/add_task_lists_screen.dart';
import 'package:shiftzeal/screens/task_detail/task_detail_screen.dart';

import '../../common/navigation_methos.dart';

class AddTaskListsController extends ChangeNotifier {


  String? selectedOption = 'team';
  bool switchValue = true;


  clickOnListTile({required BuildContext context, required int index}) {
    NavigationMethods.pushMethod(context: context, widget: TaskDetailScreen( taskId: "1",));
  }

  clickOnAddButton({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: AddTaskListsScreen());
  }

  void radioButton(String value) {
    selectedOption = value;
    notifyListeners();
  }
}
