import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../constants/icons_constant.dart';
import 'report_controller.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
    var reportController =
        Provider.of<ReportController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title:"",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.px),
                  Text(
                    "Reports",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 22.px, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10.px),
                  Row(
                    children: [
                      CommonMethods.appIcons(
                        assetName: IconConstants.icArrowLeftBlack,
                        width: 18.px,
                        height: 18.px,
                      ),
                      Text(
                        "Mon, Aug 1-Aug 31, 2022 ",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                fontSize: 14.px, fontWeight: FontWeight.w700),
                      ),
                      CommonMethods.appIcons(
                        assetName: IconConstants.icArrowRightBlack,
                        width: 18.px,
                        height: 18.px,
                      )
                    ],
                  ),
                  SizedBox(height: 20.px),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.px, vertical: 20.px),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(25.px),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, 0),
                          blurRadius: 14,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                      fontSize: 18.px,
                                      fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 4.px,
                            ),
                            Text(
                              "Hours per shift",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                      fontSize: 16.px,
                                      fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.px),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CommonMethods.appIcons(
                                      assetName: IconConstants.icMorning,
                                      height: 38.px,
                                      width: 38.px),
                                  SizedBox(width: 10.px),
                                  Text(
                                    "Morning",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(fontSize: 14.px),
                                  ),
                                ],
                              ),
                              Text(
                                "64h",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CommonMethods.appIcons(
                                      assetName: IconConstants.icAfternoon,
                                      height: 38.px,
                                      width: 38.px),
                                  SizedBox(width: 10.px),
                                  Text(
                                    "Afternoon",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(fontSize: 14.px),
                                  ),
                                ],
                              ),
                              Text(
                                "80h",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CommonMethods.appIcons(
                                      assetName: IconConstants.icNight,
                                      height: 38.px,
                                      width: 38.px),
                                  SizedBox(width: 10.px),
                                  Text(
                                    "Night",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(fontSize: 14.px),
                                  ),
                                ],
                              ),
                              Text(
                                "72h",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                              Text(
                                "216h",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.px),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.px, vertical: 20.px),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(25.px),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, 0),
                          blurRadius: 14,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Earnings",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontSize: 18.px, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10.px),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hourly wage 216h",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                              Text(
                                "\$3,240.00",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Night 72h',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                              Text(
                                "+\$270.00",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                              Text(
                                "3,510.00",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
