import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/colors.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import '../../common/navigation_methos.dart';
import '../../constants/icons_constant.dart';
import 'publish_shifts_list_controller.dart';

class PublishShiftsListScreen extends StatefulWidget {
  const PublishShiftsListScreen({super.key});

  @override
  State<PublishShiftsListScreen> createState() =>
      PublishShiftsListScreenState();
}

class PublishShiftsListScreenState extends State<PublishShiftsListScreen> {
  @override
  void initState() {
    super.initState();
    var publishShiftsListController =
        Provider.of<PublishShiftsListController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PublishShiftsListController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context, title: StringConstants.publishShifts),
          floatingActionButton: CommonWidgets.commonElevatedButton(
              context: context,
              onPressed: () =>
                  controller.clickOnClockOthersInOrOut(context: context),
              text: StringConstants.done,
              borderRadius: 15,
              buttonMargin:
                  EdgeInsets.symmetric(vertical: 10.px, horizontal: 10.px)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
              child: Column(
                children: [
                ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final randomName = controller.names[index % controller.names.length];
                  final randomColor = controller.randomColors[index % controller.randomColors.length];

                  // Get initials like "VR"
                  List<String> parts = randomName.split(" ");
                  String initials = parts.length >= 2
                      ? '${parts[0][0]}${parts[1][0]}'
                      : parts[0][0];

                  return GestureDetector(
                    onTap: () =>
                        controller.clickOnListTile(context: context, index: index),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.px),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.px),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.px),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50.px,
                                width: 50.px,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.px),
                                  color: randomColor,
                                ),
                                child: Text(
                                  initials.toUpperCase(),
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                      fontSize: 16.px, color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 10.px),
                              Text(
                                randomName,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 16.px),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
