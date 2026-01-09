import 'package:flutter/material.dart';
import 'package:shiftzeal/constants/image_constants.dart';
import 'package:shiftzeal/screens/login/login_screen.dart';

import '../../common/navigation_methos.dart';

class SelectYourEmployerController extends ChangeNotifier {


  final List<Map<String, String>> employers = List.generate(
    8,
        (index) => {
      'name': 'Hope Mills',
      'address': '3020 N Main St, Hope Mills,\nNC 28348, USA',
      'imageUrl': ImageConstants.imagesSelectLogo, // Replace with asset if needed
    },
  );




  TextEditingController searchController = TextEditingController();

  clickOnJoinARegisteredEmployer({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: const LoginScreen());
  }

  clickOnSearchBar({required BuildContext context}) {}
}
