import 'package:flutter/material.dart';

import '../../common/navigation_methos.dart';
import '../send_awards_to/send_awards_to_screen.dart';

class SendAwardsController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  clickOnSearchBar({required BuildContext context}) {}

  clickOnListTile({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: SendAwardsToScreen());
  }
}
