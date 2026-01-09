import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'admin_more_controller.dart';

class AdminMoreScreen extends StatefulWidget {
  const AdminMoreScreen({super.key});

  @override
  State<AdminMoreScreen> createState() => AdminMoreScreenState();
}

class AdminMoreScreenState extends State<AdminMoreScreen> {
  @override
  void initState() {
    super.initState();
    var adminMoreController =
        Provider.of<AdminMoreController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminMoreController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.more,
              wantBackButton: false),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 80.px),
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 400,
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     padding: const EdgeInsets.all(16),
                  //     itemCount: controller.menuItems1.length,
                  //     itemBuilder: (context, index) {
                  //       final item = controller.menuItems1[index];
                  //       return GestureDetector(
                  //         onTap: () {
                  //           controller.clickOnMenuItems1(
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
                  // SizedBox(
                  //   height: 10.px,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 16.px,
                  //     ),
                  //     Text(
                  //       StringConstants.hopeCommunitySupport,
                  //       style: TextStyle(
                  //         fontSize: 16.px,
                  //         fontWeight: FontWeight.w700,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10.px,
                  // ),
                  // SizedBox(
                  //   height: 630,
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     padding: const EdgeInsets.all(16),
                  //     itemCount: controller.menuItems2.length,
                  //     itemBuilder: (context, index) {
                  //       final item = controller.menuItems2[index];
                  //       return GestureDetector(
                  //         onTap: () {
                  //           controller.clickOnMenuItems2(
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
                  SizedBox(
                    height: 5.px,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 16.px,
                      ),
                      Text(
                        "XYZ",
                        style: TextStyle(
                          fontSize: 16.px,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.px,
                  ),
                  SizedBox(
                    height: 540,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.menuItems3.length,
                      itemBuilder: (context, index) {
                        final item = controller.menuItems3[index];
                        return GestureDetector(
                          onTap: () {
                            controller.clickOnMenuItems3(
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
                  SizedBox(
                    height: 10.px,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 16.px,
                      ),
                      Text(
                        StringConstants.managerTools,
                        style: TextStyle(
                          fontSize: 16.px,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.px,
                  ),
                  SizedBox(
                    height: 620,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.menuItems4.length,
                      itemBuilder: (context, index) {
                        final item = controller.menuItems4[index];
                        return GestureDetector(
                          onTap: (){
                            controller.clickOnMenuItems4(
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
