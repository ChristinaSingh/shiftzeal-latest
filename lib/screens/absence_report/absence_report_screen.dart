import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/apis/api_models/get_absent_user_shifts_model.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'absence_report_controller.dart';

class AbsenceReportScreen extends StatefulWidget {
  const AbsenceReportScreen({super.key, required this.absentShiftsData});
  final AbsentShiftsData absentShiftsData;

  @override
  State<AbsenceReportScreen> createState() => AbsenceReportScreenState();
}

class AbsenceReportScreenState extends State<AbsenceReportScreen> {
  @override
  void initState() {
    super.initState();
    var absenceReportController =
        Provider.of<AbsenceReportController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AbsenceReportController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.absences,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.px),
                  Text(
                    widget.absentShiftsData.shiftDate ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 24.px),
                  ),
                  SizedBox(height: 10.px),
                  Text(
                    "${widget.absentShiftsData.startTime} - ${widget.absentShiftsData.endTime} as ${widget.absentShiftsData.position} at ${widget.absentShiftsData.address}",
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 14.px),
                  ),
                  SizedBox(height: 20.px),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 52.px,
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: Row(
                            children: [
                              Container(
                                height: 52.px,
                                width: 5.px,
                                color: Color(0XFF00897B),
                              ),
                              SizedBox(
                                width: 10.px,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reporter",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontSize: 16.px,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  ),
                                  Text(
                                    'Notice',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontSize: 14.px,
                                            color: Color(0XFF424242)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 52.px,
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Notice",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.px,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  ),
                                  Text(
                                    'None',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontSize: 14.px,
                                            color: Color(0XFF424242)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.px,
                              ),
                              Container(
                                height: 52.px,
                                width: 5.px,
                                color: Color(0XFF00897B),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
