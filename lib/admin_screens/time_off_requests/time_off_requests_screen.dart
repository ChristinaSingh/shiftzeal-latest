import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';

import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'time_off_requests_controller.dart';

class TimeOffRequestsScreen extends StatefulWidget {
  const TimeOffRequestsScreen({super.key});

  @override
  State<TimeOffRequestsScreen> createState() => _TimeOffRequestsScreenState();
}

class _TimeOffRequestsScreenState extends State<TimeOffRequestsScreen> {
  @override
  void initState() {
    super.initState();
    var timeOffRequestsController =
        Provider.of<TimeOffRequestsController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeOffRequestsController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(24.px),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidgets.commonElevatedButton(
                    context: context,
                    borderRadius: 15,
                    onPressed: () =>
                        controller.clickOnDoneButton(context: context),
                    text: StringConstants.done),
              ],
            ),
          ),
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.timeOffRequests),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.px),
              child: Column(
                children: [
                  SizedBox(height: 10.px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time Off Type',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 14.px, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        controller.timeOffTypes[controller.selectedIndex],
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 14.px),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.px),
                  textField(
                      hintText: 'User',
                      controller: controller.userController,
                      prefixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icAddSquare,
                          color: Colors.black),
                      onTap: () {},
                      readOnly: true),
                  SizedBox(height: 20.px),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value:
                            controller.timeOffTypes[controller.selectedIndex],
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.black),
                        isExpanded: true,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14.px,
                              color: Colors.black,
                            ),
                        dropdownColor: Colors.white,
                        onChanged: (String? newValue) {
                          final index =
                              controller.timeOffTypes.indexOf(newValue!);
                          controller.onSelectedItemChanged(index: index);
                        },
                        items: controller.timeOffTypes
                            .map<DropdownMenuItem<String>>(
                              (String type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.px),
                  textField(
                      hintText: 'Time',
                      controller: controller.timeController,
                      prefixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icTime, color: Colors.black),
                      suffixIcon: InkWell(
                        onTap: () => controller.clickOnPasswordEyeButton(),
                        child: controller.passwordHide
                            ? Icon(Icons.keyboard_arrow_down_rounded,
                                color: Colors.black)
                            : Icon(Icons.keyboard_arrow_up_rounded,
                                color: Colors.black),
                      ),
                      onTap: () => controller.clickOnTime(context: context),
                      readOnly: true),
                  SizedBox(height: 20.px),
                  controller.passwordHide
                      ? SizedBox()
                      : Container(
                          padding: EdgeInsets.all(12.px),
                          decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.px))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...controller.hours.map((task) => Padding(
                                    padding: EdgeInsets.zero,
                                    child: ListTile(
                                      title: Text(
                                        task,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.px,
                                          fontWeight: task == "Design revision"
                                              ? FontWeight.w400
                                              : FontWeight.w400,
                                        ),
                                      ),
                                      trailing: Radio<String>(
                                        value: task,
                                        groupValue: controller.selectedTask,
                                        onChanged: (value) {
                                          setState(() {
                                            controller.selectedTask = value;
                                          });
                                        },
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        hoverColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.disabled)) {
                                            return Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(.32);
                                          }
                                          return Theme.of(context)
                                              .colorScheme
                                              .secondary;
                                        }),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                  SizedBox(height: 20.px),
                  textField(
                      hintText: 'Start',
                      controller: controller.startController,
                      prefixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icCalendar),
                      onTap: () => controller.clickOnStart(context: context),
                      readOnly: true),
                  SizedBox(height: 20.px),
                  textField(
                      hintText: 'End',
                      controller: controller.endController,
                      prefixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icCalendar),
                      onTap: () => controller.clickOnEnd(context: context),
                      readOnly: true),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Message (optional)', maxLines: 4),
                  SizedBox(height: 20.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget textField(
      {required String hintText,
      Widget? suffixIcon,
      Widget? prefixIcon,
      int? maxLines,
      bool? readOnly,
      GestureTapCallback? onTap,
      TextEditingController? controller}) {
    return TextField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF8F8F8),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        //contentPadding: EdgeInsets.symmetric(horizontal: 10.px),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        hintStyle: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontSize: 14.px),
      ),
    );
  }
}
