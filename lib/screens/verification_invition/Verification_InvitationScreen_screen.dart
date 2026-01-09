import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/image_constants.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import 'package:shiftzeal/screens/edit_profile/edit_profile_screen.dart';

import '../../common/common_methods.dart';
import '../../common/navigation_methos.dart';
import '../get_starts/get_starts_screen.dart';
import '../profile_setup/profile_setup_screen.dart';
import '../select_employer/select_employer_screen.dart';
import '../select_employer_new/select_employer_new_screen.dart';
import 'Verification_InvitationScreen_controller.dart';

class VerificationInvitationScreen extends StatefulWidget {
  const VerificationInvitationScreen({super.key});

  @override
  State<VerificationInvitationScreen> createState() =>
      VerificationInvitationScreenState();
}

class VerificationInvitationScreenState
    extends State<VerificationInvitationScreen> {
  @override
  void initState() {
    super.initState();
    var verificationInvitationController =
        Provider.of<VerificationInvitationController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VerificationInvitationController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.px),
                  Stack(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              NavigationMethods.popMethod(context: context);
                            },
                            child: CommonWidgets.appIcons(
                              assetName: IconConstants.icBlueBack,
                              height: 43.px,
                              width: 47.px,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CommonMethods.appIcons(
                          assetName: IconConstants.icSplashLogo,
                          height: 104.px,
                          width: 100.px,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.px,
                  ),
                  Center(
                    child: CommonWidgets.appIcons(
                        assetName: ImageConstants.imgVerificationInvitation,
                        height: 300.px,
                        width: 300.px,
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    height: 15.px,
                  ),
                  Center(
                    child: Text(
                      StringConstants.verificationMassage,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25.px,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 10.px,
                  ),
                  Center(
                    child: Text(
                      StringConstants.invitationMassage2,
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(height: 38.px),
                  GestureDetector(
                    onTap: () {
                      NavigationMethods.pushMethod(
                          context: context, widget: SelectEmployerScreen());
                    },
                    child: Center(
                      child: Text(
                        StringConstants.done,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.px,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
