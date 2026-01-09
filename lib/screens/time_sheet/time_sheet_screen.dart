import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import 'time_sheet_controller.dart';

class TimeSheetScreen extends StatefulWidget {
  const TimeSheetScreen({super.key});

  @override
  State<TimeSheetScreen> createState() => TimeSheetScreenState();
}

class TimeSheetScreenState extends State<TimeSheetScreen> {
  @override
  void initState() {
    super.initState();
    var timeSheetController =
        Provider.of<TimeSheetController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeSheetController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.payPeriods,
              wantBackButton: false),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("2024", style: TextStyle(color: Colors.black,
                    fontSize: 20.px,
                    fontWeight: FontWeight.w700)),
                  ],
                ),
                SizedBox(height: 20.px,),
                Expanded(
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
                  
                      return GestureDetector(
                        onTap: () {
                          controller.clickOnTile(
                              index2: index, index: index, context: context);
                        },
                        child: Container(
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
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
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
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Color(0XFF999999),
                                      child: Icon(
                                        Icons.alarm,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.px,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Color(0XFF999999),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
