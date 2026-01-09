import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import '../../common/navigation_methos.dart';
import '../verification_invition/Verification_InvitationScreen_screen.dart';
import 'send_Invitation_controller.dart';

class SendInvitationScreen extends StatefulWidget {
  const SendInvitationScreen({super.key});

  @override
  State<SendInvitationScreen> createState() => SendInvitationScreenState();
}

class SendInvitationScreenState extends State<SendInvitationScreen> {
  @override
  void initState() {
    super.initState();
    var sendInvitationController =
        Provider.of<SendInvitationController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SendInvitationController>(
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
                    child: Text(
                      StringConstants.invitationMassage,
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: Text(
                        StringConstants.invitationMassage2,
                        maxLines: 3,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 38.px),
                  CommonWidgets.normalTextFieldForLoginSignUP(
                    focusNode: controller.focusEmail,
                    controller: controller.emailController,
                    isCard: controller.isEmail,
                    hintText: StringConstants.pleaseEnterEmail,
                    keyboardType: TextInputType.emailAddress,
                    borderRadius: 15.px,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    context: context,
                  ),
                  SizedBox(height: 44.px),
                  CommonWidgets.commonElevatedButton(
                      wantContentSizeButton: true,
                      height: 60,
                      width: MediaQuery.sizeOf(context).width,
                      borderRadius: 15,
                      context: context,
                      onPressed: () {
                        NavigationMethods.pushMethod(
                            context: context, widget: VerificationInvitationScreen());
                      },
                      text: StringConstants.sendInvite),
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
