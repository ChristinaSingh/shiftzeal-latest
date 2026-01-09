import 'package:flutter/material.dart';
import 'package:shiftzeal/screens/send_awards/send_awards_screen.dart';

import '../../common/navigation_methos.dart';

class AwardsAndRewardsController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  clickOnSendAwards({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: SendAwardsScreen());
  }
}
