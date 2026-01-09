import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/common/progress_bar.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'task_controller.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.taskId});
  final String taskId;

  @override
  State<TaskScreen> createState() => TaskScreenState();
}

class TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskController>(context, listen: false)
          .initMethod(context, widget.taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.task,
          ),
          body: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: controller.shiftTasksList.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks available.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    // 👈 Changed to ListView.builder
                    itemCount: controller.shiftTasksList.length,
                    padding: const EdgeInsets.all(16.0),
                    itemBuilder: (context, index) {
                      final task = controller.shiftTasksList[index];

                      // 💡 Placeholder logic for status color:
                      final Color statusColor = index % 3 == 0
                          ? Colors.green.shade600 // Example: Completed
                          : index % 3 == 1
                              ? Colors.orange.shade600 // Example: Pending
                              : Colors.blue.shade600; // Example: In Progress

                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12.0), // Spacing between cards
                        child: GestureDetector(
                          onTap: () {
                            controller.clickOnListTile(
                                context: context,
                                index: index,
                                taskId: task.id.toString());
                          },
                          child: ChecklistCard(
                            title: task.heading ?? 'No Title',
                            detail: task.content ?? "",
                            statusColor: statusColor,
                            description: task.description ?? "",
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
// --------------------------------------------------------------------------
// --- CHECKLIST CARD (Updated with Title in Row and Description) ---
// --------------------------------------------------------------------------

class ChecklistCard extends StatelessWidget {
  final String title;
  final String detail;
  final String description; // 👈 NEW FIELD
  final Color statusColor;

  const ChecklistCard({
    super.key,
    required this.title,
    required this.detail,
    required this.description, // 👈 REQUIRED IN CONSTRUCTOR
    this.statusColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Icon and Title Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Icon with Status Color
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.assignment_turned_in_outlined,
                  color: statusColor,
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              // Title
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.3,
                    ),
                  ),
                ),
              ),

              // Navigation Arrow
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 2. Detail Content (Used for task.content)
          Text(
            detail,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),

          // 3. Description Content (NEW)
          if (description.isNotEmpty) ...[
            // Only show if description is available
            const SizedBox(height: 6),
            Text(
              description,
              maxLines: 1, // Keep it very compact
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500, // Lighter color for secondary text
                height: 1.4,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
