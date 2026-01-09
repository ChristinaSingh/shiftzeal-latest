import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../apis/api_models/get_my_shift_byDate_model.dart';
import '../../common/colors.dart';
import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'schedule_controller.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          Provider.of<ScheduleController>(context, listen: false);
      controller.changeDates(DateTime.now(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleController>(
      builder: (context, controller, child) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                StringConstants.planner,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 20.px),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(44.px),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.px)),
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 10.px, fontWeight: FontWeight.w600),
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontSize: 10.px, fontWeight: FontWeight.w600),
                      tabs: const [
                        Tab(text: 'My Shifts'),
                        Tab(text: 'On Shift Later'),
                        Tab(text: 'On Shift Now'),
                        Tab(text: 'Open Shift'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 5.px),
                EasyInfiniteDateTimeLine(
                  controller: controller.calender,
                  firstDate: DateTime(2024),
                  focusDate: controller.focusDate,
                  lastDate: DateTime(2026, 12, 31),
                  showTimelineHeader: false,
                  onDateChange: (selectedDate) {
                    controller.changeDates(selectedDate, context);
                  },
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      MyShiftsScreen(shifts: controller.myShifts),
                      MyShiftsScreen(shifts: controller.onShiftLater),
                      MyShiftsScreen(shifts: controller.onShiftNow),
                      MyShiftsScreen(shifts: controller.openShifts),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyShiftsScreen extends StatelessWidget {
  final List<ShiftData> shifts;

  const MyShiftsScreen({super.key, required this.shifts});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ScheduleController>(context, listen: false);

    if (shifts.isEmpty) {
      return Center(
        child: Text(
          "No Shifts Found",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 14.px,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.px),
          GestureDetector(
            onTap: () {
              controller.clickOnTotalHours(context: context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 10.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringConstants.totalHours,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 16.px),
                  ),
                  Text(
                    '24 Hours', // Ideally dynamic
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 17.px,
                          fontWeight: FontWeight.w700,
                          color: AppLightColors().primary,
                        ),
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            itemCount: shifts.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final shift = shifts[index];

              final timeRange =
                  '${shift.startTime ?? "--"} - ${shift.endTime ?? "--"}';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.1),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.px, horizontal: 24.px),
                    child: Text(
                      shift.shiftDate ?? "N/A",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 16.px,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.clickOnMyShiftCard(
                          context: context, index: index);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.px, vertical: 10.px),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(75.px),
                            ),
                            child: CommonWidgets.imageView(
                              width: 44.px,
                              height: 44.px,
                              borderRadius: BorderRadius.circular(22.px),
                              image: shift.image ??
                                  "https://cdn.pixabay.com/photo/2024/04/12/15/46/beautiful-8692180_1280.png",
                            ),
                          ),
                          SizedBox(width: 20.px),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  timeRange,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(fontSize: 12.px),
                                ),
                                SizedBox(height: 10.px),
                                Text(
                                  shift.address ?? "No Address Provided",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(fontSize: 12.px),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.px),
                          CommonMethods.appIcons(
                            assetName: IconConstants.icArrowRightBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 20.px),
        ],
      ),
    );
  }
}

//
// class OnShiftLaterScreen extends StatefulWidget {
//   const OnShiftLaterScreen({super.key});
//
//   @override
//   State<OnShiftLaterScreen> createState() => OnShiftLaterScreenState();
// }
//
// class OnShiftLaterScreenState extends State<OnShiftLaterScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ScheduleController>(builder: (context, controller, child) {
//       return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10.px),
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: ClampingScrollPhysics(),
//                 itemCount: 14,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       // CommonWidgets.lightBlueColorContainerText(
//                       //   title: 'MON, AUG 19, 2024',
//                       //   context: context,
//                       // ),
//                       Container(
//                         color: Theme.of(context)
//                             .colorScheme
//                             .secondary
//                             .withOpacity(0.1),
//                         padding: EdgeInsets.symmetric(vertical: 10.px),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 24.px,
//                             ),
//                             Text(
//                               'MON, AUG 19, 2024',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displayLarge
//                                   ?.copyWith(
//                                     fontSize: 16.px,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                             ),
//                             SizedBox(
//                               width: 24.px,
//                             ),
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => controller.clickOnMyShiftCard(
//                             context: context, index: index),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 24.px, vertical: 10.px),
//                           child: Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).primaryColor,
//                                   borderRadius: BorderRadius.circular(75.px),
//                                 ),
//                                 child: CommonWidgets.imageView(
//                                   width: 44.px,
//                                   height: 44.px,
//                                   borderRadius: BorderRadius.circular(22.px),
//                                   image:
//                                       'https://cdn.pixabay.com/photo/2024/04/12/15/46/beautiful-8692180_1280.png',
//                                 ),
//                               ),
//                               SizedBox(width: 20.px),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '7:00a-9:00a',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .displayMedium
//                                           ?.copyWith(fontSize: 12.px),
//                                     ),
//                                     SizedBox(height: 10.px),
//                                     Text(
//                                       'Johan Smiths at 23-0617.1 M - Benchmark Construction - Portland, ME - Conroy-Tully Walker Funeral Home as Concrete Placement',
//                                       maxLines: 2,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .labelMedium
//                                           ?.copyWith(fontSize: 12.px),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 10.px),
//                               CommonMethods.appIcons(
//                                   assetName: IconConstants.icArrowRightBlack),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20.px),
//           ],
//         ),
//       );
//     });
//   }
// }
//
// class OnShiftNowScreen extends StatefulWidget {
//   const OnShiftNowScreen({super.key});
//
//   @override
//   State<OnShiftNowScreen> createState() => OnShiftNowScreenState();
// }
//
// class OnShiftNowScreenState extends State<OnShiftNowScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ScheduleController>(builder: (context, controller, child) {
//       return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10.px),
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: ClampingScrollPhysics(),
//                 itemCount: 14,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       // CommonWidgets.lightBlueColorContainerText(
//                       //   title: 'MON, AUG 19, 2024',
//                       //   context: context,
//                       // ),
//                       Container(
//                         color: Theme.of(context)
//                             .colorScheme
//                             .secondary
//                             .withOpacity(0.1),
//                         padding: EdgeInsets.symmetric(vertical: 10.px),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 24.px,
//                             ),
//                             Text(
//                               'MON, AUG 19, 2024',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displayLarge
//                                   ?.copyWith(
//                                     fontSize: 16.px,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                             ),
//                             SizedBox(
//                               width: 24.px,
//                             ),
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => controller.clickOnMyShiftCard(
//                             context: context, index: index),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 24.px, vertical: 10.px),
//                           child: Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).primaryColor,
//                                   borderRadius: BorderRadius.circular(75.px),
//                                 ),
//                                 child: CommonWidgets.imageView(
//                                   width: 44.px,
//                                   height: 44.px,
//                                   borderRadius: BorderRadius.circular(22.px),
//                                   image:
//                                       'https://cdn.pixabay.com/photo/2024/04/12/15/46/beautiful-8692180_1280.png',
//                                 ),
//                               ),
//                               SizedBox(width: 20.px),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '7:00a-9:00a',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .displayMedium
//                                           ?.copyWith(fontSize: 12.px),
//                                     ),
//                                     SizedBox(height: 10.px),
//                                     Text(
//                                       'Johan Smiths at 23-0617.1 M - Benchmark Construction - Portland, ME - Conroy-Tully Walker Funeral Home as Concrete Placement',
//                                       maxLines: 2,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .labelMedium
//                                           ?.copyWith(fontSize: 12.px),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 10.px),
//                               CommonMethods.appIcons(
//                                   assetName: IconConstants.icArrowRightBlack),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20.px),
//           ],
//         ),
//       );
//     });
//   }
// }
//
// class OpenShiftScreen extends StatefulWidget {
//   const OpenShiftScreen({super.key});
//
//   @override
//   State<OpenShiftScreen> createState() => OpenShiftScreenState();
// }
//
// class OpenShiftScreenState extends State<OpenShiftScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ScheduleController>(builder: (context, controller, child) {
//       return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10.px),
//             GestureDetector(
//               onTap: () {
//                 controller.clickOnTotalHours(context: context);
//               },
//               child: Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: 15.px, vertical: 10.px),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       StringConstants.totalHours,
//                       style:
//                           Theme.of(context).textTheme.displayMedium?.copyWith(
//                                 fontSize: 16.px,
//                               ),
//                     ),
//                     Text(
//                       '24 Hours',
//                       style: Theme.of(context)
//                           .textTheme
//                           .displayMedium
//                           ?.copyWith(
//                               fontSize: 17.px,
//                               fontWeight: FontWeight.w700,
//                               color: AppLightColors().primary),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.px),
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: ClampingScrollPhysics(),
//                 itemCount: 14,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       // CommonWidgets.lightBlueColorContainerText(
//                       //   title: 'MON, AUG 19, 2024',
//                       //   context: context,
//                       // ),
//                       Container(
//                         color: Theme.of(context)
//                             .colorScheme
//                             .secondary
//                             .withOpacity(0.1),
//                         padding: EdgeInsets.symmetric(vertical: 10.px),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 24.px,
//                             ),
//                             Text(
//                               'MON, AUG 19, 2024',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displayLarge
//                                   ?.copyWith(
//                                     fontSize: 16.px,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                             ),
//                             SizedBox(
//                               width: 24.px,
//                             ),
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => controller.clickOnMyShiftCard(
//                             context: context, index: index),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 24.px, vertical: 10.px),
//                           child: Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).primaryColor,
//                                   borderRadius: BorderRadius.circular(75.px),
//                                 ),
//                                 child: CommonWidgets.imageView(
//                                   width: 44.px,
//                                   height: 44.px,
//                                   borderRadius: BorderRadius.circular(22.px),
//                                   image:
//                                       'https://cdn.pixabay.com/photo/2024/04/12/15/46/beautiful-8692180_1280.png',
//                                 ),
//                               ),
//                               SizedBox(width: 20.px),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '7:00a-9:00a',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .displayMedium
//                                           ?.copyWith(fontSize: 12.px),
//                                     ),
//                                     SizedBox(height: 10.px),
//                                     Text(
//                                       'Johan Smiths at 23-0617.1 M - Benchmark Construction - Portland, ME - Conroy-Tully Walker Funeral Home as Concrete Placement',
//                                       maxLines: 2,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .labelMedium
//                                           ?.copyWith(fontSize: 12.px),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 10.px),
//                               CommonMethods.appIcons(
//                                   assetName: IconConstants.icArrowRightBlack),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20.px),
//           ],
//         ),
//       );
//     });
//   }
// }
