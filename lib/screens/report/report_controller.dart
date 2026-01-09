import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/navigation_methos.dart';
import '../../constants/image_constants.dart';
import '../../constants/string_constants.dart';

class ReportController extends ChangeNotifier {
  List<Map<String, String>> listOfData = [
    {'title': 'Date', 'value': 'Monday, August 19, 2024'},
    {'title': 'In', 'value': '7:50 AM'},
    {'title': 'Out', 'value': '4:00 PM'},
    {'title': 'Schedule', 'value': 'Avalon 2'},
    {'title': 'Position', 'value': 'DSP'},
  ];

  clickOnViewEntryHistory({required BuildContext context}) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringConstants.entryHistory,
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
                SizedBox(height: 10.px),
                Text(
                  'MON, AUG 19',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 20.px),
                ),
                SizedBox(height: 10.px),
                Text(
                  'Clock in from mobile',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 12.px,
                      ),
                ),
                SizedBox(height: 4.px),
                Row(
                  children: [
                    Text(
                      '7:50a ',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 14.px),
                    ),
                    Text(
                      '(scheduled for 8a)',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontSize: 14.px,
                              color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 10.px),
                Image.asset(
                  'assets/images/Group 1171276023.png',
                  height: 80.px,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.px),
                Text(
                  'Clock out from mobile',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 12.px,
                      ),
                ),
                SizedBox(height: 4.px),
                Row(
                  children: [
                    Text(
                      '4:30p ',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 14.px),
                    ),
                    Text(
                      '(scheduled for 8a)',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontSize: 14.px,
                              color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 10.px),
                Image.asset(
                  'assets/images/Group 1171276023.png',
                  height: 80.px,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.px),
                Text(
                  'TUE, AUG 20',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 20.px),
                ),
                SizedBox(height: 10.px),
                Text(
                  'Edit at 11:27a',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 12.px,
                      ),
                ),
                SizedBox(height: 4.px),
                Text(
                  'Changed Out time to 4p',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 14.px),
                ),
                SizedBox(height: 40.px),
              ],
            ),
          ),
        );
      },
    );
  }
}
