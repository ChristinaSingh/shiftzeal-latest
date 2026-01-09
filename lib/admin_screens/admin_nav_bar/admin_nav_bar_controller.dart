import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiftzeal/admin_screens/admin_more/admin_more_screen.dart';
import 'package:shiftzeal/admin_screens/admin_schedule/admin_schedule_screen.dart';
import 'package:shiftzeal/admin_screens/attendance/attendance_screen.dart';
import 'package:shiftzeal/admin_screens/dashboard/dashboard_screen.dart';

import '../../common/common_widgets.dart';
import '../../common/globle.dart';
import '../../constants/string_constants.dart';
import '../announcements_admin/announcements_admin_screen.dart';

class AdminNavBarController extends ChangeNotifier {
  late StreamSubscription streamSubscription;

  void onInit() {
    /* AC().getNetworkConnectionType();
    streamSubscription = AC().checkNetworkConnection();*/
  }

  body() {
    switch (selectedIndex.value) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const AdminScheduleScreen();
      case 2:
        return const AttendanceScreen();
      case 3:
        return const AdminAnnouncementScreen();
      case 4:
        return const AdminMoreScreen();
    }
  }

  onWillPopMethod({required BuildContext context}) {
    if (selectedIndex.value == 0) {
      CommonWidgets.showAlertDialog(
        title: StringConstants.exit,
        content: StringConstants.doYouWantToExitAnApp,
        onPressedYes: () => SystemNavigator.pop(),
        context: context,
      );
    } else {
      selectedIndex.value = 0;
    }
  }

  clickOnTab({required int index}) {
    selectedIndex.value = index;
    notifyListeners();
  }
}
