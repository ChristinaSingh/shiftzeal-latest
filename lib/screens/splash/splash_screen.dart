import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/screens/splash/splash_controller.dart';
import 'package:upgrader/upgrader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var splashController =
        Provider.of<SplashController>(context, listen: false);
    splashController.manage(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      child: Scaffold(
        body: Center(
          child: CommonMethods.appIcons(
            assetName: IconConstants.icSplashLogo,
            height: 126.px,
            width: 124.px,
          ),
        ),
      ),
    );
  }
}
