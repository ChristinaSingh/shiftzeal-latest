import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common/navigation_methos.dart';
import '../../../common/progress_bar.dart';
import '../add_new_members/add_new_members_screen.dart'; // CreateGroupScreen wala import check karlein
import 'group_chat_controller.dart';
import 'group_chat_details.dart';

class SupervisorGroupListScreen extends StatelessWidget {
  const SupervisorGroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return ChangeNotifierProvider(
      create: (_) => GroupListController(),
      child: Consumer<GroupListController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F6FA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              title: Text("Group Communications",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.add_comment_rounded, color: primary),
                  onPressed: () =>
                      _showCreateGroupSheet(context, controller, primary),
                )
              ],
            ),
            body: ProgressBar(
              inAsyncCall: controller.inAsyncCall,
              child: controller.groups.isEmpty
                  ? const Center(child: Text("No groups created yet"))
                  : ListView.builder(
                      padding: EdgeInsets.all(12.px),
                      itemCount: controller.groups.length,
                      itemBuilder: (context, index) {
                        final group = controller.groups[index];
                        // Context aur controller dono pass karne hain
                        return _buildGroupTile(
                            context, group, primary, controller);
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGroupTile(
    BuildContext context,
    Map<String, dynamic> group,
    Color primary,
    GroupListController controller,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.px),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        isThreeLine: true,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.px, vertical: 10.px),
        onTap: () {
          NavigationMethods.pushMethod(
            context: context,
            widget: ChangeNotifierProvider.value(
              value: controller,
              child: GroupChatDetailScreen(group: group),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 24.px,
          backgroundColor: primary.withOpacity(0.12),
          child: Icon(Icons.groups_rounded, color: primary, size: 22.px),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    group['name'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.5.px,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(width: 6.px),
                Text(
                  group['time'] ?? '',
                  style: TextStyle(
                    fontSize: 11.px,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 6.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group['lastMsg'] ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.px,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8.px),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 3.px),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6.px),
                ),
                child: Text(
                  "${group['type']} • ${group['memberCount']} Members",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.px,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateGroupSheet(
      BuildContext context, GroupListController controller, Color primary) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.px))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20.px,
            right: 20.px,
            top: 20.px),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Create New Group",
                style: TextStyle(fontSize: 18.px, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.px),
            TextField(
              controller: controller.groupNameController,
              decoration: InputDecoration(
                hintText: "Group Name (e.g. Night Shift Team)",
                hintStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.px),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.px),
                    borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 20.px),
            SizedBox(
              width: double.infinity,
              height: 50.px,
              child: ElevatedButton(
                onPressed: () {
                  // 1. Check karo ki group name khali to nahi hai
                  if (controller.groupNameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please enter a group name")),
                    );
                    return;
                  }

                  // 2. Bottom Sheet ko band karo
                  Navigator.pop(context);

                  // 3. Member Selection Screen par bhejo
                  // Note: Hum Provider.value use kar rahe hain taaki wahi controller aage jaye
                  NavigationMethods.pushMethod(
                    context: context,
                    widget: ChangeNotifierProvider.value(
                      value: controller,
                      child: const CreateGroupScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.px))),
                child: Text("Next: Add Members",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 75.px),
          ],
        ),
      ),
    );
  }
}
