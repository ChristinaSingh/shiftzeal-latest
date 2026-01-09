import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/screens/pay_periods/pay_periods_controller.dart';

import '../../common/common_methods.dart';

class PayPeriodsScreen extends StatefulWidget {
  const PayPeriodsScreen({super.key});

  @override
  State<PayPeriodsScreen> createState() => PayPeriodsScreenState();
}

class PayPeriodsScreenState extends State<PayPeriodsScreen> {
  @override
  void initState() {
    super.initState();
    var payPeriodsController =
        Provider.of<PayPeriodsController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PayPeriodsController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(context: context),
          body: SafeArea(
            child: Column(
              children: [
                // Top Bar with back button and date range
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 4),
                        CommonMethods.appIcons(
                          assetName: IconConstants.icArrowLeftBlack,
                        ),
                        InkWell(
                          onTap: () => controller.selectDate(context, true),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              controller.formatCustomDate(controller.fromDate),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text('To'),
                        InkWell(
                          onTap: () => controller.selectDate(context, false),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              controller.formatCustomDate(controller.toDate),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        CommonMethods.appIcons(
                          assetName: IconConstants.icArrowRightBlack,
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.shifts.length,
                    itemBuilder: (context, index) {
                      final shift = controller.shifts[index];
                      return GestureDetector(
                        onTap: () {
                          controller.clickOnRow(context: context, index: index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Shift
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Shift",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.px,
                                      )),
                                  Text("Hours",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.px,
                                      )),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      shift['shift'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.px,
                                          color: Color(0XFF9E9FA5)),
                                    ),
                                  ),
                                  Text(
                                    '${shift['hours']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.px,
                                        color: Color(0XFF9E9FA5)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              // Item
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Item",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.px,
                                      )),
                                  Text("Pay",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.px,
                                      )),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(shift['date'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.px,
                                          color: Color(0XFF9E9FA5))),
                                  Text('\$${shift['pay'].toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.px,
                                          color: Color(0XFF9E9FA5))),
                                ],
                              ),
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

  Widget tableTitle({required String title}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 16.px),
        ),
      ),
    );
  }

  Widget tableDataTitle({required String title, double? fontSize}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.px),
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: fontSize ?? 14.px, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
