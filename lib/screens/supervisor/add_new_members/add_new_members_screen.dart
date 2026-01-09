import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common/progress_bar.dart';
import '../group_chat/group_chat_controller.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Consumer<GroupListController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA), // Light background
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add Members",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.px,
                        fontWeight: FontWeight.bold)),
                Text("Group: ${controller.groupNameController.text}",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 13.px, fontWeight: FontWeight.w500)),
              ],
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 8.px),
                child: TextButton(
                  onPressed: () => controller.createGroup(context),
                  child: Text("DONE",
                      style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.px)),
                ),
              )
            ],
          ),
          body: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: Column(
              children: [
                // Selection Counter Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 15.px),
                  decoration: BoxDecoration(
                      color: primary.withOpacity(0.05),
                      border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 0.5))
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.people_alt_rounded, size: 18.px, color: primary),
                      SizedBox(width: 10.px),
                      Text(
                        "SELECTED: ${controller.selectedEmployees.length}",
                        style: TextStyle(
                            fontSize: 13.px,
                            fontWeight: FontWeight.bold,
                            color: primary,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.px),
                    itemCount: controller.allEmployees.length,
                    itemBuilder: (context, index) {
                      final emp = controller.allEmployees[index];
                      bool isSelected = controller.selectedEmployees.contains(emp);

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.px, vertical: 4.px),
                        decoration: BoxDecoration(
                          color: isSelected ? primary.withOpacity(0.05) : Colors.white,
                          borderRadius: BorderRadius.circular(12.px),
                          border: Border.all(
                            color: isSelected ? primary : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: CheckboxListTile(
                          value: isSelected,
                          activeColor: primary,
                          checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.px)),
                          onChanged: (val) => controller.toggleSelection(emp),
                          // Title (Employee Name)
                          title: Text(
                            emp['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.px,
                                color: Colors.black87), // Dark text for visibility
                          ),
                          // Subtitle (Role)
                          subtitle: Text(
                            emp['role'],
                            style: TextStyle(
                                fontSize: 13.px,
                                color: Colors.blueGrey.shade700, // Slightly darker grey
                                fontWeight: FontWeight.w500),
                          ),
                          // Avatar
                          secondary: CircleAvatar(
                            radius: 22.px,
                            backgroundColor: isSelected ? primary : primary.withOpacity(0.1),
                            child: Text(
                              emp['name'][0].toUpperCase(),
                              style: TextStyle(
                                  color: isSelected ? Colors.white : primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.px),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.px),
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      );
                    },
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