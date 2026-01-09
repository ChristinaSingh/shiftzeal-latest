import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/summarize/summarize_screen.dart';

import '../../common/date_picker_view.dart';

class HelpController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  clickOnSearchBar({required BuildContext context}) {}

  clickOnAddIcon({required BuildContext context}) {}

  clickOnScheduleIcon({required BuildContext context}) async {
    await PickDate.pickDateView(
      color: Theme.of(context).primaryColor,
      context: context,
    );
  }

  clickOnSummarizeTime({required BuildContext context}) async {
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      config: CalendarDatePicker2WithActionButtonsConfig(
        lastMonthIcon: Icon(
          Icons.arrow_back_ios_outlined,
          size: 18.px,
          color: Colors.black,
        ),
        nextMonthIcon: Icon(
          Icons.arrow_forward_ios,
          size: 18.px,
          color: Colors.black,
        ),
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: Theme.of(context).primaryColor,
        disableModePicker: false,
        dayTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 16.px),
        yearTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 16.px),
        weekdayLabelTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 16.px),
        selectedDayTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 16.px),
        controlsTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 16.px),
        disabledMonthTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 16.px),
        selectedYearTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 16.px),
        monthTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 16.px),
        selectedRangeHighlightColor: Theme.of(context).primaryColor,
        firstDate: DateTime(2023, 1, 1),
        lastDate: DateTime(2025, 12, 31),
      ),
      dialogSize: const Size(325, 400),
      value: [],
      borderRadius: BorderRadius.circular(15),
    );
  }


  clickOnListItem({required BuildContext context}) {
    //NavigationMethods.pushMethod(context: context, widget: MyHoursScreen());
  }
}
