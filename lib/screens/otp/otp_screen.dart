import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import '../../common/navigation_methos.dart';
import '../../constants/icons_constant.dart';
import 'otp_controller.dart';

class OtpScreen extends StatefulWidget {
  Map<String, String> bodyParam;

  OtpScreen({super.key, required this.bodyParam});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    var otpController = Provider.of<OtpController>(context, listen: false);
    otpController.bodyParam = widget.bodyParam;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpController>(
      builder: (context, controller, child) {
        return Scaffold(
          bottomSheet: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 150.px,
            child: Padding(
              padding: EdgeInsets.all(24.px),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CommonWidgets.commonElevatedButton(
                  //     context: context,
                  //     borderRadius: 15,
                  //     onPressed: () =>
                  //         controller.clickOnSendButton(context: context),
                  //     text: StringConstants.verify),
                  CommonWidgets.commonCustumeButton(
                    onPressed: () async {
                      controller.clickOnSendButton(context: context);
                    },
                    borderRadius: 20.px,
                    buttonColor: Theme.of(context).primaryColor,
                    child: Text(
                      StringConstants.verify,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    showLoading: controller.inAsyncCall,
                    context: context,
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(height: 38.px),
                  Center(
                    child: Text(
                      StringConstants.forgotPassword,
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
                        StringConstants.forgotPassMassage,
                        maxLines: 3,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 38.px),
                  CommonWidgets.commonOtpView(
                    length: 4,
                      controller: controller.pin, context: context),
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
