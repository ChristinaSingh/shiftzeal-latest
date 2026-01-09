import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import 'package:shiftzeal/organization_screens/Employee_details/employee_details_screen.dart';

import '../../common/colors.dart';
import '../../common/progress_bar.dart';
import 'admin_users_controller.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => AdminUsersScreenState();
}

class AdminUsersScreenState extends State<AdminUsersScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AdminUsersController>(context, listen: false)
          .fetchEmployeeDirectory(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminUsersController>(
      builder: (context, controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: Scaffold(
            appBar: CommonWidgets.appBar(
                context: context,
                title: StringConstants.employee,
                actions: [
                  GestureDetector(
                      onTap: () => controller.clickOnAdd(context: context),
                      child: CommonMethods.appIcons(
                          assetName: IconConstants.icAddSquare)),
                  SizedBox(
                    width: 24.px,
                  )
                ]),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      context: context,
                      onPressed: () =>
                          controller.clickOnSaveButton(context: context),
                      borderRadius: 15,
                      text: StringConstants.add),
                ],
              ),
            ),
            // UserCardApp is now the body content, not an app itself.
            body: UserCardApp(users: controller.users),
          ),
        );
      },
    );
  }
}

class UserCardApp extends StatelessWidget {
  final List<Map<String, String>> users;

  UserCardApp({required this.users});

  @override
  Widget build(BuildContext context) {
    // *** FIX: Removed the MaterialApp wrapper. Now it returns the GridScreen directly. ***
    return UserGridScreen(users: users);
  }
}

class UserGridScreen extends StatelessWidget {
  final List<Map<String, String>> users;
  UserGridScreen({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: users.isEmpty
          ? Center(child: Text("No employees found."))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: users.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return UserCard(
                    name: user['name']!,
                    role: user['role']!,
                    userId: user['id']!,
                  );
                },
              ),
            ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String role;
  final String userId;

  UserCard({required this.name, required this.role, required this.userId});

  String getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // This navigation will now use the main app's Navigator
        NavigationMethods.pushMethod(
            context: context, widget: EmployeeDetailsScreen(userId: userId));
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar Circle
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    getInitials(name),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                // Arrow Icon
                Icon(Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.secondary),
              ],
            ),
            Spacer(),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              role,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
