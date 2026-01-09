import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/colors.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'user_activity_controller.dart';

class UserActivityScreen extends StatefulWidget {
  const UserActivityScreen({super.key});

  @override
  State<UserActivityScreen> createState() => UserActivityScreenState();
}

class UserActivityScreenState extends State<UserActivityScreen> {
  @override
  void initState() {
    super.initState();
    var userActivityController =
        Provider.of<UserActivityController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserActivityController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: AppLightColors().scaffoldBackgroundColor,
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.userActivity),
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
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   padding: EdgeInsets.zero,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: 4,
                  //   itemBuilder: (context, index) {
                  //     return GestureDetector(
                  //       onTap: () => controller.clickOnListTile(
                  //           context: context, index: index),
                  //       child: Padding(
                  //         padding: EdgeInsets.only(bottom: 8.px),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10.px),
                  //               color: Color(0xFFF9FBFF),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Colors.black.withOpacity(0.05),
                  //                   spreadRadius: 0,
                  //                   blurRadius: 20, // Increased blur radius
                  //                   offset: Offset(0, 4),
                  //                 )
                  //               ]),
                  //           child: Row(
                  //             children: [
                  //               Expanded(
                  //                 child: Padding(
                  //                   padding: EdgeInsets.all(16.px),
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.start,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.center,
                  //                     children: [
                  //                       CommonMethods.appIcons(
                  //                         assetName:
                  //                             IconConstants.icDocumentPrevious,
                  //                       ),
                  //                       SizedBox(width: 10.px),
                  //                       Expanded(
                  //                         child: Column(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           mainAxisSize: MainAxisSize.max,
                  //                           children: [
                  //                             Text(
                  //                               "Prince Ngoma",
                  //                               style: Theme.of(context)
                  //                                   .textTheme
                  //                                   .displayMedium
                  //                                   ?.copyWith(fontSize: 16.px),
                  //                             ),
                  //                             SizedBox(height: 10.px),
                  //                             Text(
                  //                               'Clocked in at 8:48p',
                  //                               maxLines: 2,
                  //                               style: Theme.of(context)
                  //                                   .textTheme
                  //                                   .labelMedium
                  //                                   ?.copyWith(fontSize: 12.px),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       CommonMethods.appIcons(
                  //                         assetName:
                  //                             IconConstants.icMoreHorizontal,
                  //                         width: 18.px,
                  //                         height: 18.px,
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  SizedBox(
                    height: 100.px,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 77.px,
                            width: 77.px,
                            padding: EdgeInsets.all(10.px),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.secondary),
                            child: Center(
                              child: Text(
                                "PN",
                                softWrap: false,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        fontSize: 20.px,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 28.px,
                          ),
                          Text(
                            "Prince Ngoma",
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontSize: 17.px,
                                ),
                          ),
                          SizedBox(
                            height: 5.px,
                          ),
                          Text(
                            "Clocked in at 8:48p",
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontSize: 14.px,
                                ),
                          ),
                        ],
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
}
