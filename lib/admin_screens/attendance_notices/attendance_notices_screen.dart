import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import '../../constants/icons_constant.dart';
import 'attendance_notices_controller.dart';

class AttendanceNoticesScreen extends StatefulWidget {
  const AttendanceNoticesScreen({super.key});

  @override
  State<AttendanceNoticesScreen> createState() =>
      AttendanceNoticesScreenState();
}

class AttendanceNoticesScreenState extends State<AttendanceNoticesScreen> {
  @override
  void initState() {
    super.initState();
    var attendanceNoticesController =
        Provider.of<AttendanceNoticesController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceNoticesController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.attendanceNotices),
          floatingActionButton: GestureDetector(
            onTap: () {
              controller.clickOnClockOthersInOrOut(context: context);
            },
            child: Container(
              height: 60.px,
              alignment: Alignment.center,
              margin: EdgeInsets.all(20.px),
              padding: EdgeInsets.all(15.px),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15.px),
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
                        assetName: IconConstants.icClockLogin),
                  ),
                  SizedBox(
                    width: 10.px,
                  ),
                  Text(
                    StringConstants.clockIn,
                    softWrap: false,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 17.px,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => controller.clickOnListTile(
                            context: context, index: index),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.px),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.px),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    spreadRadius: 0,
                                    blurRadius: 20, // Increased blur radius
                                    offset: Offset(0, 4),
                                  )
                                ]),
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.px),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                "Emma's onboarding checklist",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium
                                                    ?.copyWith(fontSize: 16.px),
                                              ),
                                              SizedBox(height: 10.px),
                                              Text(
                                                'This list is assigned to only you',
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(fontSize: 12.px),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CommonMethods.appIcons(
                                          assetName: IconConstants.icNextArrow,
                                          width: 18.px,
                                          height: 18.px,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),*/

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100.px,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonMethods.appIcons(
                              assetName: IconConstants.icAttendanceWarning,
                              height: 50.px,
                              width: 50.px),
                          SizedBox(
                            height: 28.px,
                          ),
                          Text(
                            StringConstants.noAttendanceNotices,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontSize: 13.px,
                                ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
