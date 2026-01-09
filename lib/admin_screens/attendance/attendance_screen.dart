import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import 'attendance_controller.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => AttendanceScreenState();
}

class AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    super.initState();
    var attendanceController =
        Provider.of<AttendanceController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.payPeriods,
              wantBackButton: false),
          body:  Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: controller.dates.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                bool isIconOnly = controller.dates[index].isEmpty;

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!isIconOnly)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            controller.dates[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0XFF343A40),
                          child: Icon(
                            isIconOnly
                                ? (index % 2 == 0
                                ? Icons.alarm
                                : Icons.arrow_forward_ios)
                                : Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
