import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_widgets.dart';
import 'help_controller.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
    var helpController = Provider.of<HelpController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HelpController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.help,
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.px),
                                color:
                                Color(0xffF8F8F8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    spreadRadius: 0,
                                    blurRadius: 20, // Increased blur radius
                                    offset: Offset(0, 4),
                                  )
                                ]),
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
                                        'Time Clock & Attendance',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(fontSize: 18.px),
                                      ),
                                      SizedBox(height: 10.px),
                                      Text(
                                        'Clair On-Demand Pay',
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(fontSize: 14.px),
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
