import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/common/progress_bar.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import '../../common/common_methods.dart';
import 'my_hours_controller.dart';

class MyHoursScreen extends StatefulWidget {
  const MyHoursScreen({super.key});

  @override
  State<MyHoursScreen> createState() => MyHoursScreenState();
}

class MyHoursScreenState extends State<MyHoursScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var myHoursController =
          Provider.of<MyHoursController>(context, listen: false);
      myHoursController.getCompletedShifts(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyHoursController>(
      builder: (context, controller, child) {
        Map<String, List<dynamic>> shiftsByYear = {};
        for (var shift in controller.completedShifts) {
          String year = shift.shiftDate?.split('-').first ?? "Unknown";
          if (!shiftsByYear.containsKey(year)) {
            shiftsByYear[year] = [];
          }
          shiftsByYear[year]!.add(shift);
        }

        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: "My Hours",
          ),
          body: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: SingleChildScrollView(
              child: Column(
                children: shiftsByYear.entries.map((entry) {
                  String year = entry.key;
                  List shifts = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.px),
                      Padding(
                        padding: EdgeInsets.only(left: 20.px),
                        child: Text(
                          year,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.px,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 10.px),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: shifts.length,
                        itemBuilder: (context, index) {
                          final item = shifts[index];
                          return InkWell(
                            onTap: () {
                              controller.clickOnTile(
                                  context: context, index: index, index2: 0);
                            },
                            child: ScheduleCard(
                              date: item.shiftDate ?? "",
                              time:
                                  "${item.startTime ?? ""} – ${item.endTime ?? ""}",
                              location: item.address ?? "",
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String date;
  final String time;
  final String location;

  const ScheduleCard({
    Key? key,
    required this.date,
    required this.time,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.px,
      margin: EdgeInsets.only(bottom: 10.px, left: 20.px, right: 20.px),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                location,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Spacer(),
          CommonMethods.appIcons(assetName: IconConstants.icBackForDashboard)
        ],
      ),
    );
  }
}
