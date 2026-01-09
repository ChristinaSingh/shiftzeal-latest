import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/apis/api_methods/api_methods.dart';
import 'package:shiftzeal/apis/api_models/get_shift_task_details_model.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';

import '../../common/navigation_methos.dart';
import '../../constants/image_constants.dart';

class TaskDetailController extends ChangeNotifier {
  String? selectedTask;

  List<TaskDetailData> taskDetails = [];
  bool inAsyncCall = false;

  // Fetch Task Details from API
  Future<void> fetchShiftTaskDetails({
    required BuildContext context,
    required String taskId,
  }) async {
    inAsyncCall = true;
    notifyListeners();

    try {
      final body = {"task_id": taskId};

      final model = await ApiMethods.getShiftTaskDetailsApi(
        context: context,
        bodyParams: body,
      );

      if (model != null && model.status != "0") {
        taskDetails = model.data ?? [];
      } else {
        CommonWidgets.showMyToastMessage(model?.message ?? "No data found");
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  // Optional button action
  clickOnFinishButton({required BuildContext context}) {}

  void showEntryHistoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (_) => EntryHistorySheet(),
    );
  }

  void clickOnFinish({required BuildContext context}) {}
}

class EntryHistorySheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.8,
      minChildSize: 0.6,
      expand: false,
      builder: (_, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      'Entry History',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                          fontSize: 22.px, fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        NavigationMethods.popMethod(context: context);
                      },
                      child: Image.asset(
                        ImageConstants.imageClose,
                        height: 24.px,
                        width: 24.px,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                /// MONDAY ENTRIES
                const Text(
                  'MON, AUG 19',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 13.px),
                EntryTimelineItem(
                  icon: IconConstants.icMobileCircle,
                  time: '7:50a',
                  description: 'Clock in from mobile',
                  note: '(scheduled for 8a)',
                  image: ImageConstants.imageMapGroup,
                ),
                SizedBox(height: 16.px),
                EntryTimelineItem(
                  icon: IconConstants.icMobileCircle,
                  time: '4:30p',
                  description: 'Clock in from mobile',
                  note: '(scheduled for 8a)',
                  image: ImageConstants.imageMapGroup,
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 17.px),
                  width: 2,
                  height: 30,
                  color: Colors.grey.shade300,
                ),

                /// TUESDAY ENTRIES
                const Text(
                  'TUE, AUG 20',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.px),
                  width: 2,
                  height: 60,
                  color: Colors.grey.shade300,
                ),

                EntryTimelineItem(
                  icon: IconConstants.icWrite,
                  time: 'Edit at 11:27a',
                  description: 'Changed Out time to 4p',
                  isEdit: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EntryTimelineItem extends StatelessWidget {
  final String icon;
  final String time;
  final String description;
  final String? note;
  final String? image;
  final bool isEdit;

  const EntryTimelineItem({
    required this.icon,
    required this.time,
    required this.description,
    this.note,
    this.image,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CommonWidgets.appIcons(
                assetName: icon, height: 40.px, width: 40.px),
            if (image != null)
              Container(
                width: 2,
                height: 125,
                color: Colors.grey.shade300,
              ),
          ],
        ),
        SizedBox(width: 16.px),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isEdit)
                Text(description, style: TextStyle(color: Colors.grey)),
              RichText(
                text: TextSpan(
                  text: time,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                    isEdit ? Colors.black.withOpacity(0.3) : Colors.black,
                  ),
                  children: note != null
                      ? [
                    TextSpan(
                      text: ' $note',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ]
                      : [],
                ),
              ),
              if (image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(image!, height: 100, fit: BoxFit.cover),
                  ),
                ),
              if (isEdit)
                Text(description,
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14.px)),
            ],
          ),
        ),
      ],
    );
  }
}
