import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/constants/image_constants.dart';
import 'package:shiftzeal/screens/daily_report/daily_report_screen.dart';
import 'package:shiftzeal/screens/task/task_screen.dart';

import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';
import '../shift_swap/shift_swap_screen.dart';

class OpenShiftRequestDetailsController extends ChangeNotifier {
  final List<String> timeOffTypes = [
    'select a reason',
    'reason 1',
    'reason 2',
    'reason 3',
    'reason 4',
    'reason 5',
  ];
  int selectedIndex = 1;

  onSelectedItemChanged({required int index}) {
    selectedIndex = index;
    notifyListeners();
  }

  clickOnReportAbsenceButton({required BuildContext context}) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return Consumer<OpenShiftRequestDetailsController>(
            builder: (context, controller, child) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.px),
                topRight: Radius.circular(20.px),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConstants.reportAbsence,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 16.px),
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationMethods.popMethod(
                            context: context,
                          );
                        },
                        child: Image.asset(
                          ImageConstants.imageClose,
                          height: 24.px,
                          width: 24.px,
                        ),
                      )
                    ],
                  ),
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
                        value: controller.timeOffTypes[controller.selectedIndex],
                        hint: Text(
                          controller.timeOffTypes[0], // "Select a reason"
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.px,
                                    color: Colors.grey,
                                  ),
                        ),
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.black),
                        isExpanded: true,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14.px,
                              color: Colors.black,
                            ),
                        dropdownColor: Colors.white,
                        onChanged: (String? newValue) {
                          final index = controller.timeOffTypes.indexOf(newValue!);

                          onSelectedItemChanged(index: index);
                        },
                        items: controller.timeOffTypes
                            .asMap()
                            .entries
                            .map<DropdownMenuItem<String>>(
                              (entry) => DropdownMenuItem<String>(
                                value: entry.value,
                                enabled: entry.key != 0,
                                // disable "Select a reason"
                                child: Text(
                                  entry.value,
                                  style: TextStyle(
                                    color: entry.key == 0
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.px),
                  CommonWidgets.commonElevatedButton(
                      context: context,
                      onPressed: () {},
                      text: StringConstants.submit),
                  SizedBox(height: 20.px),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget textField(
      {required String hintText,
      required BuildContext context,
      Widget? suffixIcon,
      int? maxLines}) {
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

  clickOnDailyReportButton({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: const DailyReportScreen(),
    );
  }

  clickOnShiftSwapButton({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: const ShiftSwapScreen(),
    );
  }

  clickOnTaskList({required BuildContext context}) {
    NavigationMethods.pushMethod(
      context: context,
      widget: const TaskScreen(taskId: "1",),
    );
  }

  clickOnRequestShiftButton({required BuildContext context}) {
    CommonWidgets.showMyToastMessage('Coming Soon!');
  }
}
