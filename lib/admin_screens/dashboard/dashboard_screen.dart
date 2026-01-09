import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/colors.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/constants/icons_constant.dart';

import '../../common/common_widgets.dart';
import '../../constants/string_constants.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    var dashboardController =
        Provider.of<DashboardController>(context, listen: false);
    dashboardController.fetchEmployeeDirectory(context: context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<DashboardController>(
      builder: (context, controller, child) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: GestureDetector(
              onTap: () {
                controller.clickOnAddNewShift(context: context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.px),
                  color: Color(0xFFE60001),
                ),
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerDocked,
            // floatingActionButton: GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     height: 60.px,
            //     width: width,
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(color: AppLightColors().primary),
            //     child: Text(
            //       'Clock In',
            //       style: Theme.of(context).textTheme.displayMedium?.copyWith(
            //           fontSize: 17.px,
            //           color: AppLightColors().scaffoldBackgroundColor),
            //     ),
            //   ),
            // ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.px),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.px),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CommonMethods.appIcons(
                                  assetName: IconConstants.icDaysCountBg,
                                  height: 40.px,
                                  width: 40.px,
                                ),
                                Text(
                                  '14',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                          fontSize: 13.px,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 16.px,
                            ),
                            Text(
                              StringConstants.dayLeftOnYourTrial,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(fontSize: 13.px),
                            )
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              StringConstants.upgrade,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: 14.px,
                                    color: Color(0xFFE60001),
                                  ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18.px,
                              color: Color(0xFFABABAB),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.px),
                  Divider(
                    indent: 20.px,
                    color: Color(0xFFDADADA),
                    endIndent: 20.px,
                  ),
                  SizedBox(height: 10.px),
                  Row(
                    children: [
                      SizedBox(
                        width: 24.px,
                      ),
                      Text(
                        StringConstants.requestsNeedingApproval,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 16.px,
                                ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.px,
                  ),
                  Container(
                    width: width,
                    margin: EdgeInsets.symmetric(
                        horizontal: 15.px, vertical: 10.px),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.px),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.clickOnTimeOffRequests(
                                      context: context);
                                },
                                child: Container(
                                  height: 130.px,
                                  width: 180.px,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(8.px),
                                  padding: EdgeInsets.all(15.px),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(15.px),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          offset: const Offset(0, 0),
                                          blurRadius: 14,
                                        )
                                      ]),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: 160.px,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CommonMethods.appIcons(
                                                assetName:
                                                    IconConstants.icClock,
                                                height: 40.px,
                                                width: 40.px),
                                            Text(
                                              StringConstants.timeOffRequests,
                                              softWrap: false,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(fontSize: 13.px),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20.px,
                                          color: Color(0XFFABABAB),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.clickOnMySchedule(
                                      context: context);
                                },
                                child: Container(
                                  height: 130.px,
                                  margin: EdgeInsets.all(8.px),
                                  padding: EdgeInsets.all(15.px),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(15.px),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          offset: const Offset(0, 0),
                                          blurRadius: 14,
                                        )
                                      ]),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: 160.px,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CommonMethods.appIcons(
                                                assetName:
                                                    IconConstants.icClock,
                                                height: 40.px,
                                                width: 40.px),
                                            Text(
                                              StringConstants.shiftRequests,
                                              softWrap: false,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(fontSize: 13.px),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20.px,
                                          color: Color(0XFFABABAB),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.clickOnMySchedule(
                                      context: context);
                                },
                                child: Container(
                                  height: 130.px,
                                  width: 180.px,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(8.px),
                                  padding: EdgeInsets.all(15.px),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(15.px),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          offset: const Offset(0, 0),
                                          blurRadius: 14,
                                        )
                                      ]),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: 160.px,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CommonMethods.appIcons(
                                                assetName:
                                                    IconConstants.icClock,
                                                height: 40.px,
                                                width: 40.px),
                                            Text(
                                              StringConstants.openShiftRequests,
                                              softWrap: false,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(fontSize: 13.px),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20.px,
                                          color: Color(0XFFABABAB),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.clickOnMyShift(context: context);
                                },
                                child: Container(
                                  height: 130.px,
                                  width: 180.px,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(8.px),
                                  padding: EdgeInsets.all(15.px),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(15.px),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          offset: const Offset(0, 0),
                                          blurRadius: 14,
                                        )
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: CommonMethods.appIcons(
                                            assetName:
                                                IconConstants.icClockLogin),
                                      ),
                                      SizedBox(
                                        width: 10.px,
                                      ),
                                      Text(
                                        StringConstants.clockIn,
                                        softWrap: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                              fontSize: 17.px,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.px),

                  /*         SizedBox(height: 20.px),
                  CommonWidgets.lightBlueColorContainerText(
                    title: 'Today',
                    context: context,
                  ),
                  requests(
                    onTap: () =>
                        controller.clickOnTimeOffRequests(context: context),
                    title: StringConstants.timeOffRequests,
                    image: Container(
                      width: 40.px,
                      height: 40.px,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(.05.px),
                        borderRadius: BorderRadius.circular(20.px),
                      ),
                      child: Center(
                          child: Text(
                        '0',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 14.px),
                      )),
                    ),
                  ),
                  requests(
                    onTap: () =>
                        controller.clickOnShiftRequests(context: context),
                    title: StringConstants.shiftRequests,
                    image: Container(
                      width: 40.px,
                      height: 40.px,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(.05.px),
                        borderRadius: BorderRadius.circular(20.px),
                      ),
                      child: Center(
                          child: Text(
                        '0',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 14.px),
                      )),
                    ),
                  ),
                  requests(
                    onTap: () => controller.clickOnJoinARegisteredEmployer(
                        context: context),
                    title: StringConstants.openShiftRequests,
                    image: Container(
                      width: 40.px,
                      height: 40.px,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(.05.px),
                        borderRadius: BorderRadius.circular(20.px),
                      ),
                      child: Center(
                          child: Text(
                        '0',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 14.px),
                      )),
                    ),
                  ),*/
                  // CommonWidgets.lightBlueColorContainerText(
                  //   onTap: () {
                  //     controller.clickOnMySchedule(context: context);
                  //   },
                  //   title: StringConstants.mySchedule,
                  //   context: context,
                  // ),
                  Container(
                    height: 60.px,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20.px),
                    padding: EdgeInsets.all(15.px),
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
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24.px,
                        ),
                        Text(
                          StringConstants.mySchedule,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontSize: 14.px,
                              ),
                        ),
                        Spacer(),
                        CommonMethods.appIcons(
                            assetName: IconConstants.icBackForDashboard),
                        SizedBox(
                          width: 24.px,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.px),
                  Container(
                    height: 60.px,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20.px),
                    padding: EdgeInsets.all(15.px),
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
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24.px,
                        ),
                        Text(
                          StringConstants.nextShiftNothingScheduled,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontSize: 14.px,
                              ),
                        ),
                        Spacer(),
                        CommonMethods.appIcons(
                            assetName: IconConstants.icBackForDashboard),
                        SizedBox(
                          width: 24.px,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.px),
                  GestureDetector(
                    onTap: () {
                      controller.clickOnAttendanceNotices(context: context);
                    },
                    child: Container(
                      height: 60.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20.px),
                      padding: EdgeInsets.all(15.px),
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24.px,
                          ),
                          Text(
                            StringConstants.attendanceNotices,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontSize: 14.px,
                                ),
                          ),
                          Spacer(),
                          CommonMethods.appIcons(
                              assetName: IconConstants.icBackForDashboard),
                          SizedBox(
                            width: 24.px,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.px),
                  GestureDetector(
                    onTap: () {
                      controller.clickOnUserActivity(context: context);
                    },
                    child: Container(
                      height: 60.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20.px),
                      padding: EdgeInsets.all(15.px),
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24.px,
                          ),
                          Text(
                            StringConstants.userActivity,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontSize: 14.px,
                                ),
                          ),
                          Spacer(),
                          CommonMethods.appIcons(
                              assetName: IconConstants.icBackForDashboard),
                          SizedBox(
                            width: 24.px,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 60.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget requests(
      {GestureTapCallback? onTap,
      required String title,
      required Widget image}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                image,
                SizedBox(width: 20.px),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 14.px),
                      ),
                    ],
                  ),
                ),
                CommonMethods.appIcons(
                  assetName: IconConstants.icNextArrow,
                  width: 18.px,
                  height: 10.px,
                )
              ],
            ),
          ),
          SizedBox(height: 14.px),
          Divider(
            color: Theme.of(context).colorScheme.surface.withOpacity(.4.px),
            height: .2.px,
          ),
          SizedBox(height: 20.px),
        ],
      ),
    );
  }
}
