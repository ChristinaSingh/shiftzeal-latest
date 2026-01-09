import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import '../../constants/icons_constant.dart';
import 'find_my_invitation_controller.dart';

class FindMyInvitationScreen extends StatefulWidget {
  const FindMyInvitationScreen({super.key});

  @override
  State<FindMyInvitationScreen> createState() => _FindMyInvitationScreenState();
}

class _FindMyInvitationScreenState extends State<FindMyInvitationScreen> {
  @override
  void initState() {
    super.initState();
    var findMyInvitationController =
        Provider.of<FindMyInvitationController>(context, listen: false);
    findMyInvitationController.startListener();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FindMyInvitationController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context,),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.all(24.px),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidgets.commonElevatedButton(
                    context: context,
                    onPressed: () => controller.clickOnCheckForInviteButton(
                        context: context),
                    text: StringConstants.checkForInvite),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 90.px),
                  Center(
                    child: CommonMethods.appIcons(
                      assetName: IconConstants.icSplashLogo,
                      height: 104.px,
                      width: 100.px,
                    ),
                  ),
                  SizedBox(height: 38.px),
                  Text(StringConstants.findMyInvitation,
                      style: Theme.of(context).textTheme.displayMedium),
                  SizedBox(height: 14.px),
                  Text(
                      StringConstants
                          .enterYourEmailAddressOrMobileNumberAndWeWillCheckToSeeIfYouHaveBeenInvitedToJoinYourTeam,
                      style: Theme.of(context).textTheme.labelMedium),
                  SizedBox(height: 38.px),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    context: context,
                    focusNode: controller.focusEmail,
                    title: StringConstants.email,
                    controller: controller.emailController,
                    isCard: controller.isEmail,
                    hintText: StringConstants.pleaseEnterEmail,
                  ),
                  SizedBox(height: 20.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
