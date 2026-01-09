import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_widgets.dart';
import 'time_card_entry_controller.dart';

class TimeCardEntryScreen extends StatefulWidget {
  const TimeCardEntryScreen({super.key});

  @override
  State<TimeCardEntryScreen> createState() => _TimeCardEntryScreenState();
}

class _TimeCardEntryScreenState extends State<TimeCardEntryScreen> {
  @override
  void initState() {
    super.initState();
    var timeCardEntryController =
        Provider.of<TimeCardEntryController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeCardEntryController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.timeCardEntry,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.px),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.px, vertical: 20.px),
                    decoration: BoxDecoration(
                      color: Color(0XFFF8F8F8),
                      borderRadius: BorderRadius.circular(25.px),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.listOfData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.listOfData[index]['title'] ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      fontSize: 14.px,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                              Text(
                                controller.listOfData[index]['value'] ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 14.px),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.px),
                  CommonWidgets.commonElevatedButton(
                      borderRadius: 15,
                      context: context,
                      onPressed: () =>
                          controller.clickOnViewEntryHistory(context: context),
                      text: 'View Entry History'),
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
