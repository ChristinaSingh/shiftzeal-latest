import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/common/progress_bar.dart';
import 'package:shiftzeal/constants/icons_constant.dart';

import '../../common/navigation_methos.dart';
import 'task_detail_controller.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key, required this.taskId});
  final String taskId;

  @override
  State<TaskDetailScreen> createState() => TaskDetailScreenState();
}

class TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskDetailController>(context, listen: false)
          .fetchShiftTaskDetails(
        context: context,
        taskId: widget.taskId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDetailController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationMethods.popMethod(context: context);
                      },
                      child: CommonMethods.appIcons(
                        assetName: IconConstants.icBack,
                        height: 34.px,
                        width: 34.px,
                      ),
                    ),
                    SizedBox(width: 90.px),
                    Text(
                      'Task Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.all(24.px),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.showEntryHistoryModal(context);
                  },
                  child: Container(
                    height: 60.px,
                    width: MediaQuery.sizeOf(context).width - 40,
                    padding: EdgeInsets.all(5.px),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15.px),
                        border: Border.all(
                            width: 2.px,
                            color: Theme.of(context).primaryColor)),
                    child: Center(
                        child: Text("Finish",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    fontSize: 17.px,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor))),
                  ),
                ),
              ],
            ),
          ),
          body: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress
                      Text('Progress',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.px,
                              color: Color(0xff4A4646))),
                      const SizedBox(height: 8),
                      Stack(
                        children: [
                          Container(
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Container(
                            height: 16,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              '80%',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("start",
                                  style: TextStyle(color: Colors.grey)),
                              Text("21 Feb 2022",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.px,
                                      color: Color(0xff4A4646))),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("end", style: TextStyle(color: Colors.grey)),
                              Text("3 March 2022",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.px,
                                      color: Color(0xff4A4646))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TimeBox(label: "months", value: "0"),
                          SizedBox(width: 10.px),
                          TimeBox(label: "days", value: "12"),
                          SizedBox(width: 10.px),
                          TimeBox(label: "hours", value: "18"),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // To-do List
                      Text('To do List',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.px,
                              color: Color(0xff4A4646))),
                      const SizedBox(height: 12),
                      if (controller.taskDetails.isEmpty)
                        Center(
                            child: Text("No task data found",
                                style: TextStyle(color: Colors.grey)))
                      else
                        ...controller.taskDetails.map((taskItem) {
                          final taskTitle = taskItem.taskPoint ?? '';
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.1),
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  taskTitle,
                                  style: TextStyle(
                                    color: controller.selectedTask == taskTitle
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.grey.shade600,
                                    fontWeight:
                                        controller.selectedTask == taskTitle
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                                ),
                                trailing: Radio<String>(
                                  value: taskTitle,
                                  groupValue: controller.selectedTask,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.selectedTask = value;
                                    });
                                  },
                                  activeColor:
                                      Theme.of(context).colorScheme.secondary,
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .secondary;
                                  }),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      const SizedBox(height: 20),
                      const Text("Description",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text(
                        "User interface (UI) is anything a user may interact with to use a digital product or service. "
                        "This includes everything from screens and touchscreens, keyboards, sounds, and even lights. "
                        "To understand the evolution of UI, however, it’s helpful to learn a bit more about its history "
                        "and how it has evolved into best practices and a profession.",
                        style: TextStyle(
                            color: Colors.grey,
                            height: 1.5,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 100.px),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TimeBox extends StatelessWidget {
  final String label;
  final String value;

  const TimeBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90.px,
          width: 90.px,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.px,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}
