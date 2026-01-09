import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'more_controller.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    super.initState();
    var moreController = Provider.of<MoreController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoreController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.menu,
              wantBackButton: false,
              extraWidget: InkWell(
                  onTap: () {
                    controller.clickOnHelp(context: context);
                  },
                  child: CommonMethods.appIcons(
                      assetName: IconConstants.icHelp,
                      height: 24.px,
                      width: 24.px)),
              actions: [
                InkWell(
                  onTap: () {
                    controller.clickOnNotification(context: context);
                  },
                  child: CommonMethods.appIcons(
                      assetName: IconConstants.icNotification,
                      height: 24.px,
                      width: 24.px),
                ),
                SizedBox(
                  width: 20.px,
                )
              ]),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 560,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.menuItems1.length,
                    itemBuilder: (context, index) {
                      final item = controller.menuItems1[index];
                      return GestureDetector(
                        onTap: () {
                          controller.clickOnList1(
                              context: context, index: index);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.px),
                                decoration: BoxDecoration(
                                    color: item.color,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.px))),
                                child: Icon(item.icon,
                                    color: Colors.white, size: 20),
                              ),
                              SizedBox(width: 16),
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 5.px),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16.px,
                      ),
                      Text(
                        StringConstants.hopeCommunitySupport,
                        style: TextStyle(
                          fontSize: 16.px,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.px,
                ),
                SizedBox(
                  height: 700,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.menuItems2.length,
                    itemBuilder: (context, index) {
                      final item = controller.menuItems2[index];
                      return GestureDetector(
                        onTap: () {
                          controller.clickOnList2(
                              context: context, index: index);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.px),
                                decoration: BoxDecoration(
                                    color: item.color,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.px))),
                                child: Icon(item.icon,
                                    color: Colors.white, size: 20),
                              ),
                              SizedBox(width: 16),
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.px),
                // Container(
                //   color: Theme.of(context).primaryColor,
                //   padding: EdgeInsets.symmetric(vertical: 5.px),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: 16.px,
                //       ),
                //       Text(
                //         "new designs",
                //         style: TextStyle(
                //           fontSize: 16.px,
                //           fontWeight: FontWeight.w700,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 380,
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     padding: const EdgeInsets.all(16),
                //     itemCount: controller.menuItems3.length,
                //     itemBuilder: (context, index) {
                //       final item = controller.menuItems3[index];
                //       return GestureDetector(
                //         onTap: () {
                //           controller.clickOnList3(
                //               context: context, index: index);
                //         },
                //         child: Container(
                //           margin: const EdgeInsets.only(bottom: 12),
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 16, vertical: 12),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(16),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.black.withOpacity(0.05),
                //                 blurRadius: 6,
                //                 offset: Offset(0, 2),
                //               ),
                //             ],
                //           ),
                //           child: Row(
                //             children: [
                //               Container(
                //                 padding: EdgeInsets.all(10.px),
                //                 decoration: BoxDecoration(
                //                     color: item.color,
                //                     borderRadius: BorderRadius.all(
                //                         Radius.circular(10.px))),
                //                 child: Icon(item.icon,
                //                     color: Colors.white, size: 20),
                //               ),
                //               SizedBox(width: 16),
                //               Text(
                //                 item.title,
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w500,
                //                   color: Colors.black87,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
