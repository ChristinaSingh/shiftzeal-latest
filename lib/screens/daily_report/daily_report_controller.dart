import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/navigation_methos.dart';

import '../../common/common_widgets.dart';
import '../../constants/string_constants.dart';
import '../statictics/statictics_screen.dart';

class DailyReportController extends ChangeNotifier {
  List listOfData = [
    {
      'title': 'Finalize Marketing Email Campaign',
      'percent': '25%',
      'date': 'Sat Jan 1',
      'value': false,
      'people': "https://randomuser.me/api/portraits/men/5.jpg",
    },
    {
      'title': 'Review marketing analytics',
      'percent': '25%',
      'date': 'Sat Jan 1',
      'value': false,
      'people': "https://randomuser.me/api/portraits/men/3.jpg",
    },
    {
      'title': 'Developers & QA Standup Meeting',
      'percent': '50%',
      'date': 'Sat Jan 1',
      'value': false,
      'people': "https://randomuser.me/api/portraits/women/5.jpg",
    },
  ];

  clickOnListTile({required BuildContext context, required int index}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height - 30,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          iconWithLabel(
                              Icons.assignment, 'Project', true, context),
                          SizedBox(width: 16),
                          iconWithLabel(
                              Icons.checklist, 'Checklist', false, context),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationMethods.popMethod(context: context);
                        },
                        child: Text(
                          'DONE',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontSize: 12.px),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "What's on your mind?",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Notes...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget iconWithLabel(
      IconData icon, String label, bool isSelected, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 18,
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 12.px),
        ),
      ],
    );
  }

  clickOnSubmitButton({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: StatisticsScreen());
  }

  clickOnCheckBox({required int index}) {
    listOfData[index]['value'] = !listOfData[index]['value'];
    notifyListeners();
  }

  showAddDialog({required BuildContext context, required int index}) {
    showDialog(
      context: context,
      builder: (_) => const AddCardDialog(),
    );
  }
}

void showAddDialog(BuildContext context) {}

class AddCardDialog extends StatelessWidget {
  const AddCardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                iconWithLabel(Icons.assignment, 'Project', true, context),
                SizedBox(width: 16),
                iconWithLabel(Icons.checklist, 'Checklist', false, context),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "what’s on your mind?",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "notes…",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            CommonWidgets.commonElevatedButton(
                borderRadius: 20.px,
                context: context,
                text: StringConstants.add,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  Widget iconWithLabel(
      IconData icon, String label, bool isSelected, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 18,
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 12.px),
        ),
      ],
    );
  }
}
