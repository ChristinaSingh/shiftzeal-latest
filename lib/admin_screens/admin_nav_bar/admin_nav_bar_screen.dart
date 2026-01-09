import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/common_methods.dart';
import '../../common/globle.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'admin_nav_bar_controller.dart';

class AdminNavBarScreen extends StatefulWidget {
  const AdminNavBarScreen({super.key});

  @override
  State<AdminNavBarScreen> createState() => _AdminNavBarScreenState();
}

class _AdminNavBarScreenState extends State<AdminNavBarScreen> {
  @override
  void initState() {
    super.initState();
    var adminNavBarController =
        Provider.of<AdminNavBarController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminNavBarController>(
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
              child: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.px, vertical: 8.px),
                  child: GNav(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.px, vertical: 4.px),
                    tabs: [
                      button(
                          image: IconConstants.icHome,
                          text: StringConstants.dashboard,
                          index: 0),
                      button(
                          image: IconConstants.icSchedule,
                          text: StringConstants.schedule,
                          index: 1),
                      button(
                          image: IconConstants.icAttendance,
                          text: StringConstants.attendance,
                          index: 2),
                      button(
                          image: IconConstants.icRequest,
                          text: StringConstants.announcement,
                          index: 3),
                      button(
                          image: IconConstants.icMore,
                          text: StringConstants.more,
                          index: 4),
                    ],
                    selectedIndex: selectedIndex.value,
                    onTabChange: (index) => controller.clickOnTab(index: index),
                  ),
                ),
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
            height: 2.px,
            width: 50.px,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(2.px),
                  bottomRight: Radius.circular(2.px),
                ),
                color: selectedIndex.value == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).scaffoldBackgroundColor),
          )
        ],
      ),
    );
  }
}
