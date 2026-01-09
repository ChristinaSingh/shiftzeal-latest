import 'package:flutter/material.dart';

import '../../common/navigation_methos.dart';
import '../add_job_sites/add_job_sites_screen.dart';

class JobSitesController extends ChangeNotifier {
  clickOnListTile({required BuildContext context, required int index}) {
    // NavigationMethods.pushMethod(context: context, widget: TaskDetailScreen());
  }

  clickOnAdd({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: AddJobSitesScreen());
  }

  clickOnSaveButton({required BuildContext context}) {

  }
}
