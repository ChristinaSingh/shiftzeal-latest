// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:shiftzeal/common/common_methods.dart';
// import 'package:shiftzeal/common/progress_bar.dart';
// import 'package:shiftzeal/constants/icons_constant.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../common/common_widgets.dart';
// import '../../constants/string_constants.dart';
// import 'home_controller.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => HomeScreenState();
// }
//
// class HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       var homeController = Provider.of<HomeController>(context, listen: false);
//       homeController.fetchCurrentShiftDetails(context: context);
//       homeController.getUserAnnouncements(context: context);
//       homeController.getRunningShifts(context: context);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Consumer<HomeController>(
//       builder: (context, controller, child) {
//         return SafeArea(
//           child: Scaffold(
//             floatingActionButtonLocation:
//                 FloatingActionButtonLocation.centerDocked,
//             floatingActionButton: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [],
//             ),
//             body: SafeArea(
//               child: ProgressBar(
//                 inAsyncCall: controller.inAsyncCall,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       controller.nextShift == null
//                           ? Container(
//                               width: double.maxFinite,
//                               margin: const EdgeInsets.all(16),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 16),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFFDF4F4),
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: Text(
//                                 'Next Shift: Not Available at the moment',
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             )
//                           : Container(
//                               margin: const EdgeInsets.all(16),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 16),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFFDF4F4),
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   // Left Column
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Next Shift: ${controller.nextShift?.shiftDate ?? ""}',
//                                           style: const TextStyle(
//                                             fontSize: 10,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           '${controller.nextShift?.startTime ?? ""} - ${controller.nextShift?.endTime ?? ""}',
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w700,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(width: 10.px),
//
//                                   // Right Column
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           'Address: ${controller.nextShift?.address ?? ""}',
//                                           style: const TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           'Position: ${controller.nextShift?.position ?? ""}',
//                                           style: const TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                       SizedBox(height: 20.px),
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 24.px,
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5.px,
//                       ),
//                       Container(
//                         width: width,
//                         margin: EdgeInsets.symmetric(
//                             horizontal: 15.px, vertical: 10.px),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15.px),
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: InkWell(
//                                     onTap: () {
//                                       controller.clickOnMyShift(
//                                           context: context);
//                                     },
//                                     child: Container(
//                                       height: 130.px,
//                                       width: 180.px,
//                                       alignment: Alignment.center,
//                                       margin: EdgeInsets.all(8.px),
//                                       padding: EdgeInsets.all(15.px),
//                                       decoration: BoxDecoration(
//                                           color: Theme.of(context)
//                                               .scaffoldBackgroundColor,
//                                           borderRadius:
//                                               BorderRadius.circular(15.px),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.black
//                                                   .withOpacity(0.05),
//                                               offset: const Offset(0, 0),
//                                               blurRadius: 14,
//                                             )
//                                           ]),
//                                       child: Stack(
//                                         children: [
//                                           SizedBox(
//                                             width: 160.px,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 CommonMethods.appIcons(
//                                                     assetName:
//                                                         IconConstants.icClock,
//                                                     height: 40.px,
//                                                     width: 40.px),
//                                                 Text(
//                                                   StringConstants.myShifts,
//                                                   softWrap: false,
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .displayMedium
//                                                       ?.copyWith(
//                                                           fontSize: 13.px),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                           Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Icon(
//                                               Icons.arrow_forward_ios,
//                                               size: 20.px,
//                                               color: Color(0XFFABABAB),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: InkWell(
//                                     onTap: () {
//                                       controller.clickOnTimeOffRequests(
//                                           context: context);
//                                     },
//                                     child: Container(
//                                       height: 130.px,
//                                       margin: EdgeInsets.all(8.px),
//                                       padding: EdgeInsets.all(15.px),
//                                       decoration: BoxDecoration(
//                                           color: Theme.of(context)
//                                               .scaffoldBackgroundColor,
//                                           borderRadius:
//                                               BorderRadius.circular(15.px),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.black
//                                                   .withOpacity(0.05),
//                                               offset: const Offset(0, 0),
//                                               blurRadius: 14,
//                                             )
//                                           ]),
//                                       child: Stack(
//                                         children: [
//                                           SizedBox(
//                                             width: 160.px,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 CommonMethods.appIcons(
//                                                     assetName:
//                                                         IconConstants.icClock,
//                                                     height: 40.px,
//                                                     width: 40.px),
//                                                 Text(
//                                                   StringConstants
//                                                       .timeOffRequests,
//                                                   softWrap: false,
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .displayMedium
//                                                       ?.copyWith(
//                                                           fontSize: 13.px),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                           Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Icon(
//                                               Icons.arrow_forward_ios,
//                                               size: 20.px,
//                                               color: Color(0XFFABABAB),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: InkWell(
//                                     onTap: () {
//                                       controller.clickOnShiftRequests(
//                                           context: context);
//                                     },
//                                     child: Container(
//                                       height: 130.px,
//                                       width: 180.px,
//                                       alignment: Alignment.center,
//                                       margin: EdgeInsets.all(8.px),
//                                       padding: EdgeInsets.all(15.px),
//                                       decoration: BoxDecoration(
//                                           color: Theme.of(context)
//                                               .scaffoldBackgroundColor,
//                                           borderRadius:
//                                               BorderRadius.circular(15.px),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.black
//                                                   .withOpacity(0.05),
//                                               offset: const Offset(0, 0),
//                                               blurRadius: 14,
//                                             )
//                                           ]),
//                                       child: Stack(
//                                         children: [
//                                           SizedBox(
//                                             width: 160.px,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 CommonMethods.appIcons(
//                                                     assetName:
//                                                         IconConstants.icClock,
//                                                     height: 40.px,
//                                                     width: 40.px),
//                                                 Text(
//                                                   StringConstants
//                                                       .openShiftRequests,
//                                                   softWrap: false,
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .displayMedium
//                                                       ?.copyWith(
//                                                           fontSize: 13.px),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                           Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Icon(
//                                               Icons.arrow_forward_ios,
//                                               size: 20.px,
//                                               color: Color(0XFFABABAB),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: InkWell(
//                                     onTap: () {
//                                       if (controller.isWorkingShift == true) {
//                                         controller.clickOnClockOut(
//                                             context: context);
//                                       } else {
//                                         controller.clickOnClockIn(
//                                             context: context);
//                                       }
//                                     },
//                                     child: Container(
//                                       height: 130.px,
//                                       width: 180.px,
//                                       alignment: Alignment.center,
//                                       margin: EdgeInsets.all(8.px),
//                                       padding: EdgeInsets.all(15.px),
//                                       decoration: BoxDecoration(
//                                         color: Theme.of(context).primaryColor,
//                                         borderRadius:
//                                             BorderRadius.circular(15.px),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color:
//                                                 Colors.black.withOpacity(0.05),
//                                             offset: const Offset(0, 0),
//                                             blurRadius: 14,
//                                           )
//                                         ],
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Align(
//                                             alignment: Alignment.centerRight,
//                                             child: CommonMethods.appIcons(
//                                               assetName:
//                                                   IconConstants.icClockLogin,
//                                             ),
//                                           ),
//                                           SizedBox(width: 10.px),
//                                           Text(
//                                             controller.isWorkingShift == true
//                                                 ? StringConstants.clockOut
//                                                 : StringConstants.clockIn,
//                                             softWrap: false,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .displayMedium
//                                                 ?.copyWith(
//                                                   fontSize: 17.px,
//                                                   color: Theme.of(context)
//                                                       .scaffoldBackgroundColor,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         color: Theme.of(context).primaryColor.withOpacity(0.03),
//                         padding: EdgeInsets.symmetric(vertical: 10.px),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 24.px,
//                             ),
//                             Text(
//                               StringConstants.currentShift,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displayLarge
//                                   ?.copyWith(
//                                       fontSize: 16.px,
//                                       fontWeight: FontWeight.w700,
//                                       color: Theme.of(context).primaryColor),
//                             ),
//                             Spacer(),
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () => controller.clickOnCurrentShift(
//                                       context: context),
//                                   child: Text(
//                                     StringConstants.view,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .displayMedium
//                                         ?.copyWith(
//                                             fontSize: 16.px,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .secondary),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10.px,
//                                 ),
//                                 Icon(
//                                   Icons.arrow_forward_ios_rounded,
//                                   color:
//                                       Theme.of(context).colorScheme.secondary,
//                                   size: 15.px,
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               width: 24.px,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 5.px),
//                       controller.inAsyncCall
//                           ? ListView.builder(
//                               shrinkWrap: true,
//                               padding: EdgeInsets.symmetric(horizontal: 24.px),
//                               itemCount: 4,
//                               itemBuilder: (context, index) {
//                                 return Shimmer.fromColors(
//                                   baseColor: Colors.grey.shade300,
//                                   highlightColor: Colors.grey.shade100,
//                                   child: Container(
//                                     margin:
//                                         EdgeInsets.symmetric(vertical: 8.px),
//                                     padding: EdgeInsets.all(12.px),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(8.px),
//                                     ),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           height: 48.px,
//                                           width: 48.px,
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey.shade300,
//                                             borderRadius:
//                                                 BorderRadius.circular(8.px),
//                                           ),
//                                         ),
//                                         SizedBox(width: 16.px),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Container(
//                                                 height: 14.px,
//                                                 width: 120.px,
//                                                 color: Colors.grey.shade300,
//                                               ),
//                                               SizedBox(height: 8.px),
//                                               Container(
//                                                 height: 12.px,
//                                                 width: double.infinity,
//                                                 color: Colors.grey.shade300,
//                                               ),
//                                               SizedBox(height: 8.px),
//                                               Container(
//                                                 height: 12.px,
//                                                 width: 150.px,
//                                                 color: Colors.grey.shade300,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//                           : controller.announcementList.isEmpty
//                               ? Center(
//                                   child: Text("No announcements available"))
//                               : ListView.builder(
//                                   shrinkWrap: true,
//                                   padding: EdgeInsets.zero,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: controller.announcementList.length,
//                                   itemBuilder: (context, index) {
//                                     final announcement =
//                                         controller.announcementList[index];
//
//                                     final admin = announcement.adminDetails;
//
//                                     final isPdf = (announcement.image ?? "")
//                                         .toLowerCase()
//                                         .endsWith(".pdf");
//                                     final hasImage =
//                                         (announcement.image ?? "").isNotEmpty;
//
//                                     return GestureDetector(
//                                       onTap: () {},
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             width: double.infinity,
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 24.px,
//                                                 vertical: 10.px),
//                                             decoration: BoxDecoration(
//                                               color: Theme.of(context)
//                                                   .scaffoldBackgroundColor,
//                                             ),
//                                             child: Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 CommonWidgets.imageView(
//                                                   image: admin?.image ?? "",
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           48.px),
//                                                   height: 48.px,
//                                                   width: 48.px,
//                                                 ),
//                                                 SizedBox(width: 20.px),
//                                                 Expanded(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Flexible(
//                                                             child: Text(
//                                                               '${admin?.firstName ?? ""} ${admin?.lastName ?? ""}',
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .displayMedium
//                                                                   ?.copyWith(
//                                                                     fontSize:
//                                                                         14.px,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w600,
//                                                                   ),
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                               width: 10.px),
//                                                           Text(
//                                                             announcement.createdAt !=
//                                                                     null
//                                                                 ? DateFormat(
//                                                                         'h:mm a')
//                                                                     .format(DateTime.parse(
//                                                                         announcement
//                                                                             .createdAt!))
//                                                                 : '',
//                                                             style: Theme.of(
//                                                                     context)
//                                                                 .textTheme
//                                                                 .displayMedium
//                                                                 ?.copyWith(
//                                                                   fontSize:
//                                                                       10.px,
//                                                                   color: const Color(
//                                                                       0XFF999999),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                 ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       SizedBox(height: 10.px),
//                                                       Text(
//                                                         announcement.content ??
//                                                             '',
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .labelMedium
//                                                             ?.copyWith(
//                                                               fontSize: 12.px,
//                                                               color: const Color(
//                                                                   0XFF999999),
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                             ),
//                                                       ),
//                                                       SizedBox(height: 10.px),
//
//                                                       // Show image or PDF
//                                                       if (hasImage)
//                                                         isPdf
//                                                             ? GestureDetector(
//                                                                 onTap: () =>
//                                                                     controller.openPdf(
//                                                                         announcement
//                                                                             .image!),
//                                                                 child:
//                                                                     Image.asset(
//                                                                   'assets/images/image_pdf.png',
//                                                                   width: 200.px,
//                                                                   height: 47.px,
//                                                                 ),
//                                                               )
//                                                             : ClipRRect(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             8.px),
//                                                                 child: CommonWidgets
//                                                                     .imageView(
//                                                                   height: 150,
//                                                                   image:
//                                                                       announcement
//                                                                           .image!,
//                                                                   defaultNetworkImage:
//                                                                       "https://dummyimage.com/600x400/cccccc/000000&text=No+Image",
//                                                                 ),
//                                                               ),
//
//                                                       SizedBox(height: 10.px),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(height: 2.px),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/progress_bar.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shimmer/shimmer.dart';
import '../../common/common_widgets.dart';
import '../../constants/string_constants.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var homeController = Provider.of<HomeController>(context, listen: false);
      homeController.getUserDetails(context: context);
      homeController.fetchCurrentShiftDetails(context: context);
      homeController.getUserAnnouncements(context: context);
      homeController.getRunningShifts(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: SafeArea(
            child: ProgressBar(
              inAsyncCall: controller.inAsyncCall,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          CommonWidgets.imageView(
                              image: controller.userImage.isNotEmpty
                                  ? controller.userImage
                                  : "https://www.granitz.fr/images/image-not-found.jpg",
                              height: 40.px,
                              width: 40.px,
                              borderRadius: BorderRadius.circular(25.px)),
                          SizedBox(
                            width: 5.px,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hii,${controller.username}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                          fontSize: 16.px,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Theme.of(context).primaryColor)),
                              SizedBox(
                                height: 2.px,
                              ),
                              Text(controller.userPosition,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                          fontSize: 12.px,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    controller.nextShift == null
                        ? Container(
                            width: double.maxFinite,
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDF4F4),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Next Shift: Not Available at the moment',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDF4F4),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Left Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Next Shift: ${controller.nextShift?.shiftDate ?? ""}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${controller.nextShift?.startTime ?? ""} - ${controller.nextShift?.endTime ?? ""}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10.px),

                                // Right Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Address: ${controller.nextShift?.address ?? ""}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Position: ${controller.nextShift?.position ?? ""}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(height: 20.px),
                    Row(
                      children: [
                        SizedBox(
                          width: 24.px,
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
                                    controller.clickOnMyShift(context: context);
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
                                            color:
                                                Colors.black.withOpacity(0.05),
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
                                                StringConstants.myShifts,
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
                                    controller.clickOnTimeOffRequests(
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
                                            color:
                                                Colors.black.withOpacity(0.05),
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
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.clickOnShiftRequests(
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
                                            color:
                                                Colors.black.withOpacity(0.05),
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
                                                StringConstants
                                                    .openShiftRequests,
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
                                    if (controller.isWorkingShift == true) {
                                      controller.clickOnClockOut(
                                          context: context);
                                    } else {
                                      controller.clickOnClockIn(
                                          context: context);
                                    }
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
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: CommonMethods.appIcons(
                                            assetName:
                                                IconConstants.icClockLogin,
                                          ),
                                        ),
                                        SizedBox(width: 10.px),
                                        Text(
                                          controller.isWorkingShift == true
                                              ? StringConstants.clockOut
                                              : StringConstants.clockIn,
                                          softWrap: false,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium
                                              ?.copyWith(
                                                fontSize: 17.px,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              ),
                                        ),
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
                    Container(
                      color: Theme.of(context).primaryColor.withOpacity(0.03),
                      padding: EdgeInsets.symmetric(vertical: 10.px),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24.px,
                          ),
                          Text(
                            StringConstants.currentShift,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    fontSize: 16.px,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => controller.clickOnCurrentShift(
                                    context: context),
                                child: Text(
                                  StringConstants.view,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                          fontSize: 16.px,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                ),
                              ),
                              SizedBox(
                                width: 10.px,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 15.px,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 24.px,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.px),
                    controller.inAsyncCall
                        ? ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 24.px),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8.px),
                                  padding: EdgeInsets.all(12.px),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.px),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 48.px,
                                        width: 48.px,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(8.px),
                                        ),
                                      ),
                                      SizedBox(width: 16.px),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 14.px,
                                              width: 120.px,
                                              color: Colors.grey.shade300,
                                            ),
                                            SizedBox(height: 8.px),
                                            Container(
                                              height: 12.px,
                                              width: double.infinity,
                                              color: Colors.grey.shade300,
                                            ),
                                            SizedBox(height: 8.px),
                                            Container(
                                              height: 12.px,
                                              width: 150.px,
                                              color: Colors.grey.shade300,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : controller.announcementList.isEmpty
                            ? Center(child: Text("No announcements available"))
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.announcementList.length,
                                itemBuilder: (context, index) {
                                  final announcement =
                                      controller.announcementList[index];

                                  final admin = announcement.adminDetails;

                                  final isPdf = (announcement.image ?? "")
                                      .toLowerCase()
                                      .endsWith(".pdf");
                                  final hasImage =
                                      (announcement.image ?? "").isNotEmpty;

                                  return GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.px,
                                              vertical: 10.px),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonWidgets.imageView(
                                                image: admin?.image ?? "",
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        48.px),
                                                height: 48.px,
                                                width: 48.px,
                                              ),
                                              SizedBox(width: 20.px),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            '${admin?.firstName ?? ""} ${admin?.lastName ?? ""}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium
                                                                ?.copyWith(
                                                                  fontSize:
                                                                      14.px,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10.px),
                                                        Text(
                                                          announcement.createdAt !=
                                                                  null
                                                              ? DateFormat(
                                                                      'h:mm a')
                                                                  .format(DateTime.parse(
                                                                      announcement
                                                                          .createdAt!))
                                                              : '',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayMedium
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        10.px,
                                                                    color: const Color(
                                                                        0XFF999999),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.px),
                                                    Text(
                                                      announcement.content ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium
                                                          ?.copyWith(
                                                            fontSize: 12.px,
                                                            color: const Color(
                                                                0XFF999999),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    ),
                                                    SizedBox(height: 10.px),

                                                    // Show image or PDF
                                                    if (hasImage)
                                                      isPdf
                                                          ? GestureDetector(
                                                              onTap: () =>
                                                                  controller.openPdf(
                                                                      announcement
                                                                          .image!),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/image_pdf.png',
                                                                width: 200.px,
                                                                height: 47.px,
                                                              ),
                                                            )
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.px),
                                                              child:
                                                                  CommonWidgets
                                                                      .imageView(
                                                                height: 150,
                                                                image:
                                                                    announcement
                                                                        .image!,
                                                                defaultNetworkImage:
                                                                    "https://dummyimage.com/600x400/cccccc/000000&text=No+Image",
                                                              ),
                                                            ),

                                                    SizedBox(height: 10.px),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 2.px),
                                      ],
                                    ),
                                  );
                                },
                              )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
