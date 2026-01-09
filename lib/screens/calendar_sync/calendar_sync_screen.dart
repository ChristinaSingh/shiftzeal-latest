import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/common_widgets.dart';
import '../../constants/string_constants.dart';
import 'calendar_sync_controller.dart';

class CalendarSyncScreen extends StatefulWidget {
  const CalendarSyncScreen({super.key});

  @override
  State<CalendarSyncScreen> createState() => _CalendarSyncScreenState();
}

class _CalendarSyncScreenState extends State<CalendarSyncScreen> {
  @override
  void initState() {
    super.initState();
    var calendarSyncController =
        Provider.of<CalendarSyncController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarSyncController>(
        builder: (context, controller, child) {
      return Scaffold(
        appBar: CommonWidgets.appBar(
            context: context, title: StringConstants.calendarSync),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(24.px),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidgets.commonElevatedButton(
                borderRadius: 20.px,
                  context: context,
                  onPressed: () =>
                      controller.clickOnNextButton(context: context),
                  text: StringConstants.next),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px),
          child: ListView.builder(itemCount: 3,itemBuilder: (context, index) => Theme(
            data: ThemeData(
                unselectedWidgetColor: Theme.of(context).primaryColor),
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              value: 1,
              groupValue: 1,
              title: Text(
                index == 0 ? "Google Calendar" :  index == 1 ? "Google Contacts" : "Google Tasks",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 14.px),
              ),
              onChanged: (val) {
                print("Radio Tile pressed $val");
              },
              activeColor: Colors.red,
              selected: true,
            ),
          ),)
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
