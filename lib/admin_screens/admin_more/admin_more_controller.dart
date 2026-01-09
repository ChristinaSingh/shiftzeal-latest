import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/admin_screens/add_tag/add_tag_screen.dart';
import 'package:shiftzeal/admin_screens/admin_positions/admin_positions_screen.dart';
import 'package:shiftzeal/admin_screens/admin_send_message/admin_send_message_screen.dart';
import 'package:shiftzeal/admin_screens/admin_users/admin_users_screen.dart';
import 'package:shiftzeal/admin_screens/annotation/annotation_screen.dart';
import 'package:shiftzeal/admin_screens/job_sites/job_sites_screen.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import 'package:shiftzeal/screens/absence/absence_screen.dart';
import 'package:shiftzeal/screens/awards_and_rewards/awards_and_rewards_screen.dart';
import 'package:shiftzeal/screens/document/document_screen.dart';
import 'package:shiftzeal/screens/insurance/insurance_screen.dart';
import 'package:shiftzeal/screens/notification_screen/notification_screen-dart.dart';
import 'package:shiftzeal/screens/performance/performance_screen.dart';

import '../../admin_setting/admin_setting_screem.dart';
import '../../common/common_widgets.dart';
import '../../common/globle.dart';
import '../../screens/availability/availability_screen.dart';
import '../../screens/calendar_sync/calendar_sync_screen.dart';
import '../../screens/my_hours/my_hours_screen.dart';
import '../../screens/select_employer/select_employer_screen.dart';
import '../../screens/setting/setting_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/task/task_screen.dart';
import '../add_position/add_position_screen.dart';
import '../add_schedules/add_schedules_screen.dart';
import '../admin_availability/admin_availability_screen.dart';
import '../publish_shifts/publish_shifts_screen.dart';
import '../task_lists/task_lists_screen.dart';

class AdminMoreController extends ChangeNotifier {
  // Existing commented-out lists and methods remain the same...

  final List<_MenuItem> menuItems1 = [
    _MenuItem("Profile & Settings", Icons.person, Color(0xFF008080)),
    // New item added here
    _MenuItem("Employees", Icons.group, Color(0xFF4CAF50)), // Added Employees
    _MenuItem("Calendar Sync", Icons.calendar_today, Color(0xFF7E57C2)),
    _MenuItem("Availability", Icons.check_circle_outline, Color(0xFF3F51B5)),
    _MenuItem("My Hours", Icons.access_time, Color(0xFFFFB74D)),
    _MenuItem("Switch Employer", Icons.swap_horiz, Color(0xFFEF9A9A)),
    _MenuItem("Log Out", Icons.logout, Color(0xFFFDD835)),
    _MenuItem("Delete Profile", Icons.delete_forever, Color(0xFFEF5350)),
  ];

  final List<_MenuItem> menuItems3 = [
    _MenuItem("Users", Icons.person, Color(0xFF008080)),
    _MenuItem("Positions", Icons.calendar_today, Color(0xFF7E57C2)),
    _MenuItem("Tags", Icons.check_circle_outline, Color(0xFF3F51B5)),
    _MenuItem("Schedules", Icons.access_time, Color(0xFFFFB74D)),
    _MenuItem("Job Sites", Icons.swap_horiz, Color(0xFFEF9A9A)),
    _MenuItem("Task Lists", Icons.logout, Color(0xFFFDD835)),
    _MenuItem("Documents", Icons.insert_drive_file, Color(0xFFFFA726)),
  ];

  final List<_MenuItem> menuItems4 = [
    _MenuItem("Publish & Notify", Icons.message, Color(0xFF80DEEA)),
    _MenuItem("Send Message", Icons.list, Color(0xFFCDDC39)),
    _MenuItem("Add Annotation", Icons.request_page, Color(0xFFE91E63)),
    _MenuItem(
        "Import Users From Contacts", Icons.event_busy, Color(0xFF004D40)),
    _MenuItem("Absences", Icons.card_giftcard, Color(0xFF6A1B9A)),
    _MenuItem("Awards & Rewards", Icons.emoji_events, Color(0xFFCE93D8)),
    _MenuItem("Performance", Icons.shield, Color(0xFFFFA726)),
    _MenuItem("Insurance", Icons.shield, Color(0xFFFFA726)),
  ];

  clickOnList1({required BuildContext context, required int index}) {
    switch (index) {
      case 0:
        NavigationMethods.pushMethod(context: context, widget: SettingScreen());
        break;
      case 1: // New case for 'Employees'
        NavigationMethods.pushMethod(
            context: context, widget: AdminUsersScreen());
        break;
      case 2:
        NavigationMethods.pushMethod(
            context: context, widget: CalendarSyncScreen());
        //  NavigationMethods.pushMethod(context: context, widget: HistoryScreen());
        break;
      case 3:
        NavigationMethods.pushMethod(
            context: context, widget: AvailabilityScreen());
        break;
      case 4:
        NavigationMethods.pushMethod(context: context, widget: MyHoursScreen());
        break;
      case 5:
        NavigationMethods.pushMethod(
            context: context, widget: SelectEmployerScreen());
        break;
      case 6:
        CommonWidgets.showAlertDialog(
          context: context,
          title: StringConstants.logout,
          content: StringConstants.wouldYouLikeToLogout,
          onPressedYes: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.clear();
            selectedIndex.value = 0;
            notifyListeners();
            NavigationMethods.pushAndRemoveUntilMethod(
              context: context,
              widget: const SplashScreen(),
            );
          },
        );
        break;
      case 7:
        CommonWidgets.showAlertDeleteProfile(
          context: context,
          onPressedYes: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.clear();
            selectedIndex.value = 0;
            notifyListeners();
            NavigationMethods.pushAndRemoveUntilMethod(
              context: context,
              widget: const SplashScreen(),
            );
          },
        );
        break;
    }
  }

  clickOnMenuItems3({required BuildContext context, required int index}) {
    switch (index) {
      case 0:
        NavigationMethods.pushMethod(
            context: context, widget: AdminUsersScreen());
        break;
      case 1:
        NavigationMethods.pushMethod(
            context: context, widget: AddPositionScreen());
        break;
      case 2:
        NavigationMethods.pushMethod(context: context, widget: AddTagScreen());
        break;
      case 3:
        NavigationMethods.pushMethod(
            context: context, widget: AddSchedulesScreen());
        break;
      case 4:
        NavigationMethods.pushMethod(
            context: context, widget: JobSitesScreen());
        break;
      case 5:
        NavigationMethods.pushMethod(
            context: context, widget: TaskListsScreen());
        break;
      case 6:
        NavigationMethods.pushMethod(
            context: context, widget: DocumentScreen());
        break;
    }
  }

  clickOnMenuItems4({required BuildContext context, required int index}) {
    switch (index) {
      case 0:
        NavigationMethods.pushMethod(
            context: context, widget: PublishShiftsScreen());
        break;
      case 1:
        NavigationMethods.pushMethod(
            context: context, widget: AdminSendMessageScreen());
        break;
      case 2:
        NavigationMethods.pushMethod(
            context: context, widget: AnnotationScreen());
        break;
      case 3:
        NavigationMethods.pushMethod(
            context: context, widget: AdminUsersScreen());
        break;
      case 4:
        NavigationMethods.pushMethod(context: context, widget: AbsenceScreen());
        break;
      case 5:
        NavigationMethods.pushMethod(
            context: context, widget: AwardsAndRewardsScreen());
        break;
      case 6:
        NavigationMethods.pushMethod(
            context: context, widget: PerformanceScreen());
        break;
      case 7:
        NavigationMethods.pushMethod(
            context: context, widget: InsuranceScreen());
        break;
    }
  }

  clickOnListMenu1({required BuildContext context, required int index}) {
    switch (index) {
      case 0:
        NavigationMethods.pushMethod(
            context: context, widget: AdminsettingScreen());
        break;
      case 1:
        NavigationMethods.pushMethod(
            context: context, widget: AdminUsersScreen());
        break;
      case 2:
        NavigationMethods.pushMethod(
            context: context, widget: AddPositionScreen());
        break;
      case 3:
        NavigationMethods.pushMethod(
            context: context, widget: AddSchedulesScreen());
        break;
      case 4:
        NavigationMethods.pushMethod(context: context, widget: AddTagScreen());
        break;
      case 5:
        NavigationMethods.pushMethod(
            context: context, widget: AdminSendMessageScreen());
        break;
    }
  }

  clickOnList({required BuildContext context, required int index}) {
    switch (index) {
      case 0:
        NavigationMethods.pushMethod(
            context: context, widget: AdminUsersScreen());
        break;
      case 1:
        NavigationMethods.pushMethod(
            context: context, widget: AdminPositionsScreen());
        break;
      case 2:
        NavigationMethods.pushMethod(context: context, widget: AddTagScreen());
        break;
      case 3:
        NavigationMethods.pushMethod(
            context: context, widget: AddSchedulesScreen());
        break;
      case 4:
        NavigationMethods.pushMethod(
            context: context, widget: JobSitesScreen());
        break;
    }
  }

  clickManageToolOnList({required BuildContext context, required int index}) {
    switch (index) {
      case 1:
        NavigationMethods.pushMethod(
            context: context, widget: AdminSendMessageScreen());
        break;
      case 2:
        NavigationMethods.pushMethod(
            context: context, widget: AnnotationScreen());
        break;
      case 8:
        {
          CommonWidgets.showAlertDialog(
            context: context,
            title: StringConstants.logout,
            content: StringConstants.wouldYouLikeToLogout,
            onPressedYes: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              selectedIndex.value = 0;
              notifyListeners();
              NavigationMethods.pushAndRemoveUntilMethod(
                context: context,
                widget: const SplashScreen(),
              );
            },
          );
        }
        break;
      case 9:
        {
          CommonWidgets.showAlertDialog(
            context: context,
            title: StringConstants.delete,
            content: StringConstants.wouldYouLikeToDeleteAccount,
            onPressedYes: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              selectedIndex.value = 0;
              notifyListeners();
              NavigationMethods.pushAndRemoveUntilMethod(
                context: context,
                widget: const SplashScreen(),
              );
            },
          );
        }
        break;
    }
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Color color;

  _MenuItem(this.title, this.icon, this.color);
}
