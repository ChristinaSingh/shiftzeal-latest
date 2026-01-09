import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/colors.dart';

import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../common/progress_bar.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'setting_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    var myTripController =
        Provider.of<SettingController>(context, listen: false);
    myTripController.initMethod(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, controller, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                StringConstants.setting,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 20.px),
              ),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () => controller.clickOnEdit(context: context),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    child: Text(
                      StringConstants.edit,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontSize: 14.px,
                              color: AppLightColors().secondary2),
                    ),
                  ),
                ),
                SizedBox(width: 24.px)
              ],
              leading:
              GestureDetector(
                onTap: () {
                  NavigationMethods.popMethod(context: context);
                },
                child: CommonMethods.appIcons(
                  assetName: IconConstants.icBack,
                  height: 34.px,
                  width: 34.px,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(44.px),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.px),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(25.px)),
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      automaticIndicatorColorAdjustment: false,
                      indicatorSize: TabBarIndicatorSize.tab,
                      // onTap: (value) =>
                      //     controller.clickOnTap(value: value, context: context),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 12.px,
                              color: Theme.of(context).primaryColor),
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontSize: 12.px, fontWeight: FontWeight.w700),
                      dividerColor: Theme.of(context).colorScheme.surface,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonMethods.appIcons(
                                  assetName: IconConstants.icProfileTab),
                              SizedBox(
                                width: 10.px,
                              ),
                              Text(StringConstants.profile)
                            ],
                          ),
                        ),
                        Tab(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonMethods.appIcons(
                                  assetName: IconConstants.icAlert),
                              SizedBox(
                                width: 10.px,
                              ),
                              Text(StringConstants.alerts)
                            ],
                          ),
                        ),
                        //      Tab(text: 'Open Shift'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                ProfileScreen(),
                SettingTabScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    var controller = Provider.of<SettingController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(builder: (context, controller, child) {
      return Scaffold(
          body: SafeArea(
        child: ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10.px),
              padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 10.px),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15.px),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 0),
                      blurRadius: 14,
                    )
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.px,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.inAsyncCall
                            ? CommonWidgets.imageView(
                                image: StringConstants.defaultNetworkImage,
                                height: 100.px,
                                width: 100.px,
                                borderRadius: BorderRadius.circular(50.px),
                                fit: BoxFit.cover,
                                defaultNetworkImage:
                                    StringConstants.defaultNetworkImage)
                            : CommonWidgets.imageView(
                                image:  controller.userData!.image!,
                                height: 100.px,
                                width: 100.px,
                                borderRadius: BorderRadius.circular(50.px),
                                fit: BoxFit.cover,
                                defaultNetworkImage:
                                    StringConstants.defaultNetworkImage)
                      ],
                    ),
                    SizedBox(
                      height: 30.px,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              children: [
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringConstants.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 16.px,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      "${controller.userData?.firstName} ${controller.userData?.lastName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      StringConstants.phone,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.px,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      controller.userData?.mobileNumber ??
                                          'None',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              children: [
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringConstants.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 16.px,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      controller.userData?.email ?? 'None',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      StringConstants.employeeID,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 16.px,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      controller.userData?.id.toString() ??
                                          'None',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              children: [
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringConstants.role,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 16.px,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      'None',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      StringConstants.maxHoursWeek,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 10.px,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      'None',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              children: [
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringConstants.privacy,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.px,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      'None',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      StringConstants.tStepVerification,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 10.px,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      'None',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              children: [
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringConstants.language,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.px,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      'none',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 60.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: CommonMethods
                                              .commonLinearGradientView(
                                                  context: context),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: 31.px,
                                      width: 110.px,
                                      child: Center(
                                        child: Text(
                                          StringConstants.schedule,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                  fontSize: 10.px,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.px,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Avalon 1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                  fontSize: 12.px,
                                                  color: Color(0XFF424242)),
                                        ),
                                        SizedBox(
                                          width: 5.px,
                                        ),
                                        Text(
                                          '19 Avalon',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                  fontSize: 12.px,
                                                  color: Color(0XFF999999)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 52.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              children: [
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringConstants.timezone,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.px,
                                              color:
                                                  AppLightColors().secondary2),
                                    ),
                                    Text(
                                      'none',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 14.px,
                                              color: Color(0XFF424242)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 60.px,
                            padding: EdgeInsets.symmetric(horizontal: 10.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: CommonMethods
                                              .commonLinearGradientView(
                                                  context: context),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: 31.px,
                                      width: 110.px,
                                      child: Center(
                                        child: Text(
                                          StringConstants.positions,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                  fontSize: 10.px,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.px,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'DSP',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                  fontSize: 14.px,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0XFF0056B3)),
                                        ),
                                        SizedBox(
                                          width: 10.px,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Container(
                                  height: 52.px,
                                  width: 5.px,
                                  color: Color(0XFF00897B),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                  ]),
            ),
          ),
        ),
      ));
    });
  }
}

class SettingTabScreen extends StatefulWidget {
  const SettingTabScreen({super.key});

  @override
  SettingTabState createState() => SettingTabState();
}

class SettingTabState extends State<SettingTabScreen> {
  //  scheduler;
  @override
  void initState() {
    super.initState();
    var scheduler = Provider.of<SettingController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(builder: (context, scheduler, child) {
      return Scaffold(
          body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.px),
            child: Column(
              children: [
                SizedBox(height: 40),
                // Grid cards
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: scheduler.cards.map((card) {
                    return NotificationCard(title: card['title']!);
                  }).toList(),
                ),
                SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Workchat",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 17.px,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF181D27)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20.px),
                // Toggle Switches
                ...scheduler.toggles
                    .map((text) => ToggleRow(title: text))
                    .toList(),
              ],
            ),
          ),
        ),
      ));
    });
  }
}

class NotificationCard extends StatelessWidget {
  final String title;

  NotificationCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 13.px,
                fontWeight: FontWeight.w600,
                color: Color(0XFF181D27)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonMethods.appIcons(
                  assetName: IconConstants.icEmailSms,
                  height: 24.px,
                  width: 24.px),
              SizedBox(width: 12),
              CommonMethods.appIcons(
                  assetName: IconConstants.icMobileSms,
                  height: 24.px,
                  width: 24.px),
            ],
          ),
        ],
      ),
    );
  }
}

class ToggleRow extends StatefulWidget {
  final String title;

  ToggleRow({required this.title});

  @override
  _ToggleRowState createState() => _ToggleRowState();
}

class _ToggleRowState extends State<ToggleRow> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 14.px,
                fontWeight: FontWeight.w700,
                color: Color(0XFF181D27)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 24.px,
            width: 40.px,
            child: FittedBox(
              fit: BoxFit.contain,
              child: CupertinoSwitch(
                value: true,
                activeColor: AppLightColors().secondary2,
                onChanged: (bool value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
