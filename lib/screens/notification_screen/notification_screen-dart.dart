import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import '../../common/common_widgets.dart';
import 'notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    var notificationController =
    Provider.of<NotificationController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.notification,
          ),

          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          // floatingActionButton: Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     GestureDetector(
          //         onTap: () => controller.clickOnAddIcon(context: context),
          //         child: CommonMethods.appIcons(
          //             assetName: IconConstants.icAdd,
          //             height: 60.px,
          //             width: 60.px)),
          //   ],
          // ),

          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.px),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.px),
                        child: GestureDetector(
                          onTap: () =>
                              controller.clickOnListItem(context: context),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 20.px),
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 5.px)),
                              borderRadius: BorderRadius.circular(10.px),
                              color: Color(0xffF8F8F8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.px),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Clair On-Demand Pay',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(fontSize: 18.px),
                                      ),
                                      SizedBox(height: 10.px),
                                      Text(
                                        'You\'re clocked in to a shift that was \n scheduled to end 5 mins ago. ',
                                        maxLines: 2,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(fontSize: 12.px),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  CommonMethods.appIcons(
                                      assetName:
                                      IconConstants.icArrowRightBlack)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
