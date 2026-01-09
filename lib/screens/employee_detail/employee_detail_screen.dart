import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';

import '../../common/common_methods.dart';
import '../../common/navigation_methos.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'employee_detail_controller.dart';

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen({super.key});

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  @override
  void initState() {
    super.initState();
    var myTripController =
        Provider.of<EmployeeDetailController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeDetailController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: CommonWidgets.appBar(context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.px),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(75.px),
                  ),
                  child: Image.asset(
                    'assets/images/ic_app_logo.png',
                    width: 120.px,
                    height: 120.px,
                  ),
                ),
                SizedBox(height: 10.px),
                Container(
                  width: double.infinity,
                  padding:
                  EdgeInsets.symmetric(horizontal: 14.px, vertical: 20.px),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surface
                        .withOpacity(.2.px),
                    borderRadius: BorderRadius.circular(25.px),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
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
                    ],
                  ),
                ),
                SizedBox(height: 10.px),
              ],
            ),
          ),
        ),
      );
    });
  }
}