import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/common/progress_bar.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import 'absence_controller.dart';

class AbsenceScreen extends StatefulWidget {
  const AbsenceScreen({super.key});

  @override
  State<AbsenceScreen> createState() => AbsenceScreenState();
}

class AbsenceScreenState extends State<AbsenceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final absenceController =
      Provider.of<AbsenceController>(context, listen: false);
      absenceController.getAbsentShifts(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AbsenceController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.absences,
            actions: [
              GestureDetector(
                onTap: () =>
                    controller.clickOnTrackTimeIcon(context: context),
                child: CommonMethods.appIcons(
                    assetName: IconConstants.icTrackTime),
              ),
              SizedBox(width: 24.px),
            ],
          ),
          body: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: controller.absentShifts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final item = controller.absentShifts[index];
                  return GestureDetector(
                    onTap: () => controller.clickOnTile(
                      index: index,
                      index2: 0, // Adjust as per your logic
                      context: context,
                    ),
                    child: ScheduleCard(
                      date: item.shiftDate ?? "",
                      time:
                      "${item.startTime ?? ""} - ${item.endTime ?? ""}",
                      location: item.address ?? "No location available",
                    ),
                  );
                },
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
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
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: CommonMethods.appIcons(
              assetName: IconConstants.icBackForDashboard,
            ),
          ),
        ],
      ),
    );
  }
}
