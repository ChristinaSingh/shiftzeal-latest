import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import 'package:shiftzeal/screens/FreeTrialScreen/free_trial_screen.dart';
import 'package:shiftzeal/screens/account_setup_screen/account_setup_screen.dart';
import 'package:shiftzeal/screens/availability/availability_screen.dart';
import 'package:shiftzeal/screens/awards_and_rewards/awards_and_rewards_screen.dart';
import 'package:shiftzeal/screens/calendar_sync/calendar_sync_screen.dart';
import 'package:shiftzeal/screens/contact_information/contact_information_screen.dart';
import 'package:shiftzeal/screens/create_your_workPlace/create_your_workPlace_screen.dart';
import 'package:shiftzeal/screens/directory/directory_screen.dart';
import 'package:shiftzeal/screens/document/document_screen.dart';
import 'package:shiftzeal/screens/insurance/insurance_screen.dart';
import 'package:shiftzeal/screens/my_hours/my_hours_screen.dart';
import 'package:shiftzeal/screens/notification_screen/notification_screen-dart.dart';
import 'package:shiftzeal/screens/plans/change_plan_screen.dart';
import 'package:shiftzeal/screens/requests/requests_screen.dart';
import 'package:shiftzeal/screens/select_employer/select_employer_screen.dart';
import 'package:shiftzeal/screens/send_message/send_message_screen.dart';
import 'package:shiftzeal/screens/setting/setting_screen.dart';
import 'package:shiftzeal/screens/splash/splash_screen.dart';

import '../../admin_screens/add_position/add_position_screen.dart';
import '../../admin_screens/add_schedules/add_schedules_screen.dart';
import '../../admin_screens/add_tag/add_tag_screen.dart';
import '../../admin_screens/admin_availability/admin_availability_screen.dart';
import '../../admin_screens/admin_send_message/admin_send_message_screen.dart';
import '../../admin_screens/admin_users/admin_users_screen.dart';
import '../../admin_setting/admin_setting_screem.dart';
import '../../common/common_widgets.dart';
import '../../common/globle.dart';
import '../absence/absence_screen.dart';
import '../add_request/add_request_screen.dart';
import '../help_screen/help_screen-dart.dart';
import '../history/history_screen.dart';
import '../performance/performance_screen.dart';

class MoreController extends ChangeNotifier {
  List<Map<String, dynamic>> list1 = [
    {
      'icon': IconConstants.icProfileSettings,
      'title': StringConstants.myAccountAndPreferences
    },
    {'icon': IconConstants.icDailyReport, 'title': StringConstants.dailyReport},
    {
      'icon': IconConstants.icAvailability,
      'title': StringConstants.shiftPreferences
    },
    {'icon': IconConstants.icMyHours, 'title': StringConstants.workHours},
    {
      'icon': IconConstants.icSwitchEmployer,
      'title': StringConstants.switchEmployer
    },
    {'icon': IconConstants.icLogOut, 'title': StringConstants.logOut},
    /* {
      'icon': IconConstants.icCalendarSync,
      'title': StringConstants.calendarSync
    },*/

    /* {
      'icon': IconConstants.icDeleteProfile,
      'title': StringConstants.deleteProfile
    },*/
  ];

  final List<_MenuItem> menuItems1 = [
    _MenuItem("Profile & Settings", Icons.person, Color(0xFF008080)),
    _MenuItem("Calendar Sync", Icons.calendar_today, Color(0xFF7E57C2)),
    _MenuItem("Availability", Icons.check_circle_outline, Color(0xFF3F51B5)),
    _MenuItem("My Hours", Icons.access_time, Color(0xFFFFB74D)),
    _MenuItem("Switch Employer", Icons.swap_horiz, Color(0xFFEF9A9A)),
    _MenuItem("Log Out", Icons.logout, Color(0xFFFDD835)),
    _MenuItem("Delete Profile", Icons.delete_forever, Color(0xFFEF5350)),
  ];

  final List<_MenuItem> menuItems2 = [
    _MenuItem("Documents", Icons.insert_drive_file, Color(0xFFFFA726)),
    _MenuItem("Send Message", Icons.message, Color(0xFF80DEEA)),
    _MenuItem("Directory", Icons.list, Color(0xFFCDDC39)),
    _MenuItem("Requests", Icons.request_page, Color(0xFFE91E63)),
    _MenuItem("Absences", Icons.event_busy, Color(0xFF004D40)),
    _MenuItem("Awards & Rewards", Icons.card_giftcard, Color(0xFF6A1B9A)),
    _MenuItem("Performance", Icons.emoji_events, Color(0xFFCE93D8)),
    _MenuItem("Insurance", Icons.shield, Color(0xFFFFA726)),
    _MenuItem("Contact Us", Icons.shield, Colors.cyan),
  ];

  final List<_MenuItem> menuItems3 = [
    _MenuItem("Plans", Icons.request_page, Color(0xFFFFA726)),
    _MenuItem("Create Your Workplace", Icons.add, Color(0xFF80DEEA)),
    _MenuItem("Account Setup", Icons.list, Color(0xFFCDDC39)),
    _MenuItem("Free Trial", Icons.list, Color(0xFFCDDC39)),
  ];

  clickOnHelp({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: HelpScreen());
  }

  clickOnNotification({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: NotificationScreen());
  }

  clickOnList1({required BuildContext context, required int index}) {
    switch (index) {
      case 0:
        NavigationMethods.pushMethod(context: context, widget: SettingScreen());
      case 1:
        NavigationMethods.pushMethod(
            context: context, widget: CalendarSyncScreen());
      //  NavigationMethods.pushMethod(context: context, widget: HistoryScreen());
      case 2:
        NavigationMethods.pushMethod(
            context: context, widget: AvailabilityScreen());
      case 3:
        NavigationMethods.pushMethod(context: context, widget: MyHoursScreen());
      case 4:
        NavigationMethods.pushMethod(
            context: context, widget: SelectEmployerScreen());
      case 5:
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
      case 6:
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
    }
  }

  clickOnList2({required BuildContext context, required int index}) {
    switch (index) {
      case 0:
        NavigationMethods.pushMethod(
            context: context, widget: DocumentScreen());
      case 1:
        NavigationMethods.pushMethod(
            context: context, widget: SendMessageScreen());
      case 2:
        NavigationMethods.pushMethod(
            context: context, widget: DirectoryScreen());
      case 3:
        NavigationMethods.pushMethod(
            context: context, widget: RequestsScreen());
      case 4:
        NavigationMethods.pushMethod(context: context, widget: AbsenceScreen());
      case 5:
        NavigationMethods.pushMethod(
            context: context, widget: AwardsAndRewardsScreen());
      case 6:
        NavigationMethods.pushMethod(
            context: context, widget: PerformanceScreen());
      case 7:
        NavigationMethods.pushMethod(
            context: context, widget: InsuranceScreen());
      case 8:
        NavigationMethods.pushMethod(
            context: context, widget: ContactInformationScreen());
    }
  }

  clickOnList3({required BuildContext context, required int index}) {
    switch (index) {
      case 0:
        NavigationMethods.pushMethod(
            context: context, widget: ChangePlanScreen());
      case 1:
        NavigationMethods.pushMethod(
            context: context, widget: CreateYourWorkPlaceScreen());
      case 2:
        NavigationMethods.pushMethod(
            context: context, widget: AccountSetupScreen());
      case 3:
        NavigationMethods.pushMethod(
            context: context, widget: FreeTrialScreen());
    }
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Color color;

  _MenuItem(this.title, this.icon, this.color);
}
