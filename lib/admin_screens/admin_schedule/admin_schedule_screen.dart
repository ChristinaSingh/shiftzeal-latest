import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// Note: Assuming these imports point to the correct files in your project
import 'package:shiftzeal/admin_screens/admin_schedule/admin_schedule_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';

// AdminScheduleScreen - Tabs Hata Diye Gaye Hain

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({super.key});

  @override
  State<AdminScheduleScreen> createState() => AdminScheduleScreenState();
}

class AdminScheduleScreenState extends State<AdminScheduleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          Provider.of<AdminScheduleController>(context, listen: false);
      controller.changeDates(DateTime.now(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminScheduleController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              StringConstants.scheduler,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 20.px),
            ),
            centerTitle: true,
          ),
          // Directly using AllShiftsScreen as the body
          body: const AllShiftsScreen(),
        );
      },
    );
  }
}

// AllShiftsScreen - Better UI Implemented

class AllShiftsScreen extends StatefulWidget {
  const AllShiftsScreen({super.key});

  @override
  State<AllShiftsScreen> createState() => AllShiftsState();
}

class AllShiftsState extends State<AllShiftsScreen> {
  // Helper method to format the selected date title (Using simple formatting)
  String _formatSelectedDate(DateTime? date) {
    if (date == null) return 'No Date Selected';
    final dayOfWeek =
        ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][date.weekday - 1];
    final month = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC'
    ][date.month - 1];
    final dayOfMonth = date.day;
    final year = date.year;
    return '$dayOfWeek, $month $dayOfMonth, $year';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminScheduleController>(
        builder: (context, scheduler, child) {
      final selectedDate = scheduler.selectedDay;
      final shiftsList = scheduler.allShiftsList;

      return Scaffold(
          body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.px),
                    child: TableCalendar(
                      rowHeight: 50, // Height kam kiya
                      daysOfWeekHeight: 30.px, // Height kam kiya
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: scheduler.focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(scheduler.selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        scheduler.selectDay(selectedDay, focusedDay);
                        scheduler.changeDates(selectedDay, context);
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        markerDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        outsideDaysVisible: false, // Outside days hidden
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 16.px, fontWeight: FontWeight.bold),
                        leftChevronIcon: Container(
                            padding: EdgeInsets.all(5.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  )
                                ],
                                border: Border.all(
                                    color: Color(0XFFCED3DE).withOpacity(0.5),
                                    width: 1.px),
                                borderRadius: BorderRadius.circular(8.px)),
                            child: Icon(
                              Icons.chevron_left,
                              size: 20.px,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            )),
                        rightChevronIcon: Container(
                            padding: EdgeInsets.all(5.px),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  )
                                ],
                                border: Border.all(
                                    color: Color(0XFFCED3DE).withOpacity(0.5),
                                    width: 1.px),
                                borderRadius: BorderRadius.circular(8.px)),
                            child: Icon(
                              Icons.chevron_right,
                              size: 20.px,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.px),
                  // Display the shifts list title with the selected date (Dynamic Date)
                  CommonWidgets.lightBlueColorContainerText(
                    onTap: () {
                      scheduler.clickOnAddIcon(context: context);
                    },
                    title: _formatSelectedDate(selectedDate),
                    context: context,
                    icon: IconConstants.icAddSquare,
                  ),

                  // --- Shift List UI Improvements (Card look and dynamic data) ---
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: shiftsList.length,
                    itemBuilder: (context, index) {
                      final shiftItem = shiftsList[index];

                      // Dynamic Data Extraction
                      final String shiftTime = (shiftItem.startTime != null &&
                              shiftItem.endTime != null)
                          ? '${shiftItem.startTime} - ${shiftItem.endTime}'
                          : 'Time Not Available';

                      final address =
                          shiftItem.address ?? 'Address Not Available';
                      final shiftDetails = shiftItem.userDetails?.position ??
                          'Details Not Available';
                      final String shiftEmployeeName = shiftItem
                                  .userDetails?.firstName !=
                              null
                          ? '${shiftItem.userDetails!.firstName} ${shiftItem.userDetails!.lastName ?? ''}'
                              .trim()
                          : 'Assigned Employee';
                      final imageUrl = shiftItem.userDetails?.image ??
                          'https://cdn.pixabay.com/photo/2024/04/12/15/46/beautiful-8692180_1280.png';

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.px, vertical: 8.px),
                        child: InkWell(
                          onTap: () {
                            // Main card tap action (View Details)
                            scheduler.clickOnShiftCard(
                                context: context, index: index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.px, horizontal: 10.px),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.px),
                                border: Border.all(
                                    color: Color(0XFFCED3DE).withOpacity(0.5),
                                    width: 1.px)),
                            child: Row(
                              children: [
                                // Profile Image
                                CommonWidgets.imageView(
                                  width: 44.px,
                                  height: 44.px,
                                  borderRadius: BorderRadius.circular(22.px),
                                  image: imageUrl,
                                ),
                                SizedBox(width: 15.px),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // 1. Shift Time
                                      Text(
                                        shiftTime,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                                fontSize: 13.px,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4.px),
                                      // 2. Employee Name
                                      Text(
                                        shiftEmployeeName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontSize: 12.px,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      SizedBox(height: 4.px),
                                      // 3. ADDRESS with Icon
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Color(0XFFCED3DE),
                                            size: 14.px,
                                          ),
                                          SizedBox(width: 4.px),
                                          Expanded(
                                            child: Text(
                                              address,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                    fontSize: 12.px,
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.px),
                                      // 4. Shift Details
                                      Text(
                                        shiftDetails,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
                                // ➡️ **New: Icons Grouped in a Column**
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Delete Icon (New)
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible:
                                              false, // user can’t tap outside to close
                                          builder: (context) {
                                            return Dialog(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 24),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // 🔺 Close Icon Row
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Delete Shift",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          child: Icon(
                                                              Icons.close,
                                                              color: Colors
                                                                  .grey[600]),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),

                                                    // 🗑️ Icon + Text
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .redAccent
                                                                .withOpacity(
                                                                    0.1),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              color: Colors
                                                                  .redAccent,
                                                              size: 28),
                                                        ),
                                                        SizedBox(width: 12),
                                                        Expanded(
                                                          child: Text(
                                                            "Are you sure you want to delete this shift?",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),

                                                    // Buttons Row
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .redAccent,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            await scheduler
                                                                .deleteShift(
                                                              context: context,
                                                              shiftId: shiftItem
                                                                  .id
                                                                  .toString(),
                                                            );
                                                          },
                                                          child: Text("Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: Theme.of(context).primaryColor,
                                          size: 30,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 8.px),
                                    CommonMethods.appIcons(
                                        assetName:
                                            IconConstants.icArrowRightBlack),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.px),
                ],
              ),
            ]),
      ));
    });
  }
}

// ------------------------------------------------------------------
// MyShiftsScreen (Hardcoded data remains as per your original request)
// ------------------------------------------------------------------

class MyShiftsScreen extends StatefulWidget {
  const MyShiftsScreen({super.key});

  @override
  State<MyShiftsScreen> createState() => MyShiftsScreenState();
}

class MyShiftsScreenState extends State<MyShiftsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminScheduleController>(
        builder: (context, controller, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.px),
              GestureDetector(
                onTap: () => controller.clickOnTotalHours(context: context),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Hours',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 14.px,
                                ),
                      ),
                      Row(
                        children: [
                          Text(
                            '12 Hours',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    fontSize: 14.px,
                                    color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(width: 10.px),
                          CommonMethods.appIcons(
                              assetName: IconConstants.icArrowRightBlack),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.px),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 14,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CommonWidgets.lightBlueColorContainerText(
                        title: 'MON, AUG 19, 2024',
                        context: context,
                      ),
                      InkWell(
                        onTap: () => controller.clickOnMyShiftCard(
                            context: context, index: index),
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
                                  image:
                                      'https://cdn.pixabay.com/photo/2024/04/12/15/46/beautiful-8692180_1280.png',
                                ),
                              ),
                              SizedBox(width: 20.px),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          ?.copyWith(fontSize: 12.px),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.px),
                              CommonMethods.appIcons(
                                  assetName: IconConstants.icArrowRightBlack),
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
        ),
      );
    });
  }
}

// ------------------------------------------------------------------
// OpenShiftScreen (Hardcoded data remains as per your original request)
// ------------------------------------------------------------------

class OpenShiftScreen extends StatefulWidget {
  const OpenShiftScreen({super.key});

  @override
  State<OpenShiftScreen> createState() => OpenShiftScreenState();
}

class OpenShiftScreenState extends State<OpenShiftScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminScheduleController>(
        builder: (context, controller, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.px),
              GestureDetector(
                onTap: () => controller.clickOnTotalHours(context: context),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Hours',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 14.px,
                                ),
                      ),
                      Row(
                        children: [
                          Text(
                            '12 Hours',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    fontSize: 14.px,
                                    color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(width: 10.px),
                          CommonMethods.appIcons(
                              assetName: IconConstants.icArrowRightBlack),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.px),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 14,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CommonWidgets.lightBlueColorContainerText(
                        title: 'MON, AUG 19, 2024',
                        context: context,
                      ),
                      Padding(
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
                                image:
                                    'https://cdn.pixabay.com/photo/2024/04/12/15/46/beautiful-8692180_1280.png',
                              ),
                            ),
                            SizedBox(width: 20.px),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                assetName: IconConstants.icArrowRightBlack),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20.px),
            ],
          ),
        ),
      );
    });
  }
}
