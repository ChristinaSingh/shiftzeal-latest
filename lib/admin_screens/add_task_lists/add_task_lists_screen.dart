import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../task_lists/task_lists_controller.dart';
import 'add_task_lists_controller.dart';

class AddTaskListsScreen extends StatefulWidget {
  const AddTaskListsScreen({super.key});

  @override
  State<AddTaskListsScreen> createState() => TaskListsScreenState();
}

class TaskListsScreenState extends State<AddTaskListsScreen> {
  @override
  void initState() {
    super.initState();
    var taskListsController =
        Provider.of<AddTaskListsController>(context, listen: false);
  }

  final items = List.generate(6, (index) => 'Emma\'s onboarding checklist');
  String? selectedOption = 'team';
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskListsController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.addTaskLists),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Name Input
                _buildTextField('First Name'),

                const SizedBox(height: 20),

                // Radio Button 1
                _buildCustomRadio(
                    label: 'For teams to work on throughout the day.',
                    value: 'team',
                    controller: controller),

                const SizedBox(height: 10),

                // Radio Button 2
                _buildCustomRadio(
                    label: 'For a user during their shift.',
                    value: 'user',
                    controller: controller),

                const SizedBox(height: 20),

                // Switch
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Text(
                        "Repeats",
                        style: const TextStyle(color: Colors.black),
                      ),
                      Spacer(),
                      Switch(
                        value: switchValue,
                        onChanged: (val) => setState(() => switchValue = val),
                        activeColor: Colors.white,
                        activeTrackColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Dropdown Placeholder
                _buildTextField('Every'),
                const SizedBox(height: 10),
                _buildTextField('Schedules'),

                const SizedBox(height: 30),

                // Add Button
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      Text(
                        "Add a Task",
                        style: const TextStyle(color: Colors.black),
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildCustomRadio(
    {required String label,
    required String value,
    required AddTaskListsController controller}) {
  final isSelected = controller.selectedOption == value;
  return Consumer<AddTaskListsController>(
      builder: (context, controller, child) {
    return GestureDetector(
      onTap: () {
        controller.radioButton(value);
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red, width: 2),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  )
                : null,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  label,
                  style: TextStyle(
                      color: Color(0xff9DB2BF),
                      fontSize: 12.px,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });
}

Widget _buildTextField(String hint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Color(0xffF8F8F8),
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.px),
        border: InputBorder.none,
      ),
    ),
  );
}

class ChecklistCard extends StatelessWidget {
  final String title;

  const ChecklistCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Red notification dot
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This list is assigned to only you',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey.shade100,
                    child: CommonMethods.appIcons(
                        assetName: IconConstants.icBackForDashboard)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
