import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/common_methods.dart';
import 'availability_controller.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => AvailabilityScreenState();
}

class AvailabilityScreenState extends State<AvailabilityScreen> {
  @override
  void initState() {
    super.initState();
    var availabilityController =
        Provider.of<AvailabilityController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AvailabilityController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.availability),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      TableCalendar(
                        rowHeight: 60,
                        daysOfWeekHeight: 40.px,
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: controller.focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(controller.selectedDay, day),
                        onDaySelected: controller.selectDay,
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Color(0XFF735BF2),
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(10.px)
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Color(0XFF735BF2),
                            shape: BoxShape.circle,
                            //borderRadius: BorderRadius.circular(10.px)
                          ),
                          markerDecoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          leftChevronIcon: Container(
                              padding: EdgeInsets.all(10.px),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      offset: const Offset(0, 0),
                                      blurRadius: 14,
                                    )
                                  ],
                                  border: Border.all(
                                      color: Color(0XFFCED3DE), width: 1.px),
                                  borderRadius: BorderRadius.circular(10.px)),
                              child: Icon(Icons.chevron_left)),
                          rightChevronIcon: Container(
                              padding: EdgeInsets.all(10.px),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      offset: const Offset(0, 0),
                                      blurRadius: 14,
                                    )
                                  ],
                                  border: Border.all(
                                      color: Color(0XFFCED3DE), width: 1.px),
                                  borderRadius: BorderRadius.circular(10.px)),
                              child: Icon(Icons.chevron_right)),
                        ),
                      ),
                      // EasyInfiniteDateTimeLine(
                      //   controller: controller.calender,
                      //   firstDate: DateTime(2024),
                      //   focusDate: controller.focusDate,
                      //   lastDate: DateTime(2026, 12, 31),
                      //   showTimelineHeader: false,
                      //   onDateChange: (selectedDate) {
                      //     controller.changeDates(selectedDate);
                      //   },
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: 15.px, vertical: 10.px),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         StringConstants.totalHours,
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .displayMedium
                      //             ?.copyWith(
                      //               fontSize: 16.px,
                      //             ),
                      //       ),
                      //       Text(
                      //         '24 Hours',
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .displayMedium
                      //             ?.copyWith(
                      //                 fontSize: 16.px,
                      //                 color: AppLightColors().primary),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 10.px),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 14,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CommonWidgets.lightBlueColorContainerText(
                                  onTap: () {
                                    controller.clickOnAddIcon(context: context);
                                  },
                                  title: 'MON, AUG 19, 2024',
                                  context: context,
                                  icon: IconConstants.icAddSquare),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.px, vertical: 10.px),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                          BorderRadius.circular(75.px),
                                        ),
                                        child: CommonWidgets.imageView(
                                          width: 44.px,
                                          height: 44.px,
                                          borderRadius:
                                          BorderRadius.circular(22.px),
                                          image:
                                          'https://cdn.pixabay.com/photo/2024/04/12/15/46/beautiful-8692180_1280.png',
                                        ),
                                      ),
                                      SizedBox(width: 20.px),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '7:00a-9:00a',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(fontSize: 12.px),
                                            ),
                                            SizedBox(height: 10.px),
                                            Text(
                                              'Johan Smiths at 23-0617.1 M - Benchmark Construction - Portland, ME - Conroy-Tully Walker Funeral Home as Concrete Placement',
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                fontSize: 12.px,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10.px),
                                      CommonMethods.appIcons(
                                          assetName:
                                          IconConstants.icArrowRightBlack),
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
                ]),
          ),
        );
      },
    );
  }
}
