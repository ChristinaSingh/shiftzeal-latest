import 'package:flutter/material.dart';
import 'package:shiftzeal/screens/submit_a_ticket/submit_a_ticket_screen.dart';

import '../../common/navigation_methos.dart';

class ContactInformationController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  clickOnSearchBar({required BuildContext context}) {}

  clickOnListTile({required BuildContext context}) {
    // NavigationMethods.pushMethod(context: context, widget: SendAwardsToScreen());
  }

  clickOnSubmitATicketListTile({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: SubmitATicketScreen());
  }
}
