import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'daily_report_controller.dart';

class DailyReportScreen extends StatefulWidget {
  const DailyReportScreen({super.key});

  @override
  State<DailyReportScreen> createState() => DailyReportScreenState();
}

class DailyReportScreenState extends State<DailyReportScreen> {
  @override
  void initState() {
    super.initState();
    var dailyReportController =
        Provider.of<DailyReportController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyReportController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.all(24.px),
            child: CommonWidgets.commonElevatedButton(
                borderRadius: 20.px,
                context: context,
                onPressed: () =>
                    controller.clickOnSubmitButton(context: context),
                text: StringConstants.submit),
          ),
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.dailyReport),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.listOfData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => controller.showAddDialog(
                            context: context, index: index),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.px),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.px),
                                color: Color(0xffF8F8F8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.01),
                                    spreadRadius: 0,
                                    blurRadius: 20, // Increased blur radius
                                    offset: Offset(0, 4),
                                  )
                                ]),
                            child: Row(
                              children: [
                                SizedBox(width: 10.px),
                                Container(
                                  height: 50.px,
                                  width: 50.px,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CommonWidgets.imageView(
                                    borderRadius: BorderRadius.circular(25.px),
                                    image: controller.listOfData[index]['people'],
                                    height: 50.px,
                                    width: 50.px,
                                  ),
                                ),
                                SizedBox(width: 20.px),
                                SizedBox(
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () => controller.clickOnCheckBox(
                                              index: index),
                                          child: controller.listOfData[index]
                                                  ['value']
                                              ? Container(
                                                  width: 22,
                                                  height: 22,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    size: 16,
                                                  ),
                                                )
                                              : CommonWidgets.appIcons(
                                                  assetName:
                                                      IconConstants.icUncheck,
                                                  height: 22.px,
                                                  width: 22.px)),
                                      Text(
                                        controller.listOfData[index]['percent'],
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(fontSize: 10.px),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.px),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                controller.listOfData[index]
                                                    ['title'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium
                                                    ?.copyWith(fontSize: 12.px),
                                              ),
                                              SizedBox(height: 10.px),
                                              Row(
                                                children: [
                                                  Text(
                                                    controller.listOfData[index]
                                                        ['date'],
                                                    maxLines: 2,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(fontSize: 10.px),
                                                  ),  SizedBox(width: 10.px),
              
                                                  CommonMethods.appIcons(
                                                    assetName: IconConstants.icDocumentPrevious,
                                                    width: 28.px,
                                                    height: 28.px,
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 10.px),
                                              LinearProgressIndicator(
                                                backgroundColor: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                color: Color(0xff34C759),
                                                value: .6,
                                                minHeight: 4.px,
                                                borderRadius:
                                                    BorderRadius.circular(10.px),
                                              ),
                                            ],
                                          ),
                                        ),
              
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.px),

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


