import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/common_widgets.dart';
import '../../constants/string_constants.dart';
import 'add_preference_controller.dart';

class AddPreferenceScreen extends StatefulWidget {
  const AddPreferenceScreen({super.key});

  @override
  State<AddPreferenceScreen> createState() => _AddPreferenceScreenState();
}

class _AddPreferenceScreenState extends State<AddPreferenceScreen> {
  @override
  void initState() {
    super.initState();
    var addPreferenceController =
        Provider.of<AddPreferenceController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPreferenceController>(
        builder: (context, controller, child) {
      return Scaffold(
        appBar: CommonWidgets.appBar(
            context: context, title: StringConstants.addPreference),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  "Date",
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
                                  'Thu, Aug 29, 2024',
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
                  ],
                ),
                SizedBox(height: 20.px),
                Row(
                  children: [
                    Expanded(
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Theme.of(context).primaryColor,
                        ),
                        child: RadioListTile<int>(
                          value: 1,
                          groupValue: controller.selectedTask,
                          title: Text(
                            "I'm unavailable to work",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontSize: 12.px),
                          ),
                          onChanged: (val) {
                            setState(() {
                              controller.selectedTask = val!;
                            });
                            print("Radio Tile pressed $val");
                          },
                          activeColor: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        child: RadioListTile<int>(
                          value: 2,
                          groupValue: controller.selectedTask,
                          title: Text(
                            "I prefer to work",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontSize: 12.px),
                          ),
                          onChanged: (val) {
                            setState(() {
                              controller.selectedTask = val!;
                            });
                            print("Radio Tile pressed $val");
                          },
                          activeColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.px),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.listOfData[0]['title'] ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontSize: 17.px),
                          ),
                          ((controller.listOfData[0]['title'] ?? "") != 'Time')
                              ? SizedBox(
                                  height: 24.px,
                                  width: 40.px,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: CupertinoSwitch(
                                      value: controller.inSwith2,
                                      activeColor:
                                          Theme.of(context).colorScheme.primary,
                                      onChanged: (bool value) {
                                        setState(() {
                                          controller.inSwith2 = value;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              : Text(
                                  "9:00a-5:00p",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(fontSize: 14.px),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 20.px,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 52.px,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Time",
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
                                        '9:00a-5:00p',
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
                        ],
                      ),
                      SizedBox(
                        height: 20.px,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.listOfData[2]['title'] ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontSize: 17.px),
                          ),
                          ((controller.listOfData[2]['title'] ?? "") != 'Time')
                              ? SizedBox(
                                  height: 24.px,
                                  width: 40.px,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: CupertinoSwitch(
                                      value:  controller.inSwith,
                                      activeColor:
                                          Theme.of(context).colorScheme.primary,
                                      onChanged: (bool value) {
                                        setState(() {
                                          controller.inSwith = value;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              : Text(
                                  "9:00a-5:00p",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(fontSize: 14.px),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.px),
                Text(
                  'Add note',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 14.px),
                ),
                SizedBox(height: 20.px),
                textField(hintText: StringConstants.message, maxLines: 5),
                SizedBox(height: 20.px),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget textField(
      {required String hintText, Widget? suffixIcon, int? maxLines}) {
    return TextField(
      //onTap: () => controller.clickOnSearchBar(context: context),
      //readOnly: true,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF8F8F8),
        hintText: hintText,
        suffixIcon: suffixIcon,
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
