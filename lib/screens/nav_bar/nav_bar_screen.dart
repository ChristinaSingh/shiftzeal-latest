import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/common_methods.dart';
import '../../common/globle.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'nav_bar_controller.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  @override
  void initState() {
    super.initState();
    var navBarController =
        Provider.of<NavBarController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarController>(
      builder: (context, controller, child) {
        return WillPopScope(
          onWillPop: () => controller.onWillPopMethod(context: context),
          child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: controller.body(),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.px, vertical: 8.px),
                          child: GNav(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.px, vertical: 4.px),
                            tabs: [
                              button(
                                  image: IconConstants.icHome,
                                  text: StringConstants.home,
                                  index: 0),
                              button(
                                  image: IconConstants.icSchedule,
                                  text: StringConstants.schedule,
                                  index: 1),
                              button(
                                  image: IconConstants.icEarnings,
                                  text: StringConstants.earnings,
                                  index: 2),
                              button(
                                  image: IconConstants.icChat,
                                  text: StringConstants.chat,
                                  index: 3),
                              button(
                                  image: IconConstants.icMore,
                                  text: StringConstants.menu,
                                  index: 4),
                            ],
                            selectedIndex: selectedIndex.value,
                            onTabChange: (index) =>
                                controller.clickOnTab(index: index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  button({required String image, required String text, required int index}) {
    return GButton(
      icon: Icons.add,
      leading: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonMethods.iconLinearGradient(
            assetName: image,
            value: selectedIndex.value == index,
            context: context,
            primaryColor: true,
          ),
          SizedBox(height: 2.px),
          CommonMethods.textViewLinearGradient(
            text: text,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 10.px),
            value: selectedIndex.value == index,
            primaryColor: true,
            context: context,
          ),
          SizedBox(height: 8.px),
          Container(
            height: 3.px,
            width: 50.px,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(3.px),
                  bottomRight: Radius.circular(3.px),
                ),
                color: selectedIndex.value == index
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).scaffoldBackgroundColor),
          )
        ],
      ),
    );
  }
}
