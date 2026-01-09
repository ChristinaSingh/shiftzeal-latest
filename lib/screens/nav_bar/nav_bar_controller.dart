import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiftzeal/screens/home/home_screen.dart';
import 'package:shiftzeal/screens/more/more_screen.dart';
import 'package:shiftzeal/screens/time_sheet/time_sheet_screen.dart';
import '../../common/common_widgets.dart';
import '../../common/globle.dart';
import '../../constants/string_constants.dart';
import '../chat/chat_screen.dart';
import '../schedule/schedule_screen.dart';

class NavBarController extends ChangeNotifier {
  late StreamSubscription streamSubscription;

  void onInit() {
    /* AC().getNetworkConnectionType();
    streamSubscription = AC().checkNetworkConnection();*/
  }
  body() {
    return IndexedStack(
      index: selectedIndex.value,
      children: const [
        HomeScreen(),
        ScheduleScreen(),
        TimeSheetScreen(),
        ChatScreen(),
        MoreScreen(),
      ],
    );
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
