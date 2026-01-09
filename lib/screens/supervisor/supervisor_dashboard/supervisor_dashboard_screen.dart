import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import '../../../common/common_widgets.dart';
import '../group_chat/group_List.dart';
import '../shift_reports/shift_report_screen.dart';
import '../supervisor_requests/supervisor_requests_screen.dart';
import '../supervisor_employee_shift_details.dart/supervisor_employee_shif_details_screen.dart';
import 'supervisor_dashboard_controller.dart';

class SupervisorDashboardScreen extends StatefulWidget {
  const SupervisorDashboardScreen({super.key});

  @override
  State<SupervisorDashboardScreen> createState() =>
      SupervisorDashboardScreenState();
}

class SupervisorDashboardScreenState extends State<SupervisorDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          Provider.of<SupervisorDashboardController>(context, listen: false);
      controller.getUserDetails(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Consumer<SupervisorDashboardController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3F5F9),
          body: controller.inAsyncCall
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    _buildHeader(controller, primary),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildQuickActions(context),
                            _buildTeamSection(controller, primary, context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildHeader(SupervisorDashboardController controller, Color primary) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.px, 60.px, 20.px, 22.px),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.px)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26.px,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: CommonWidgets.imageView(
              image: controller.userImage.isNotEmpty
                  ? controller.userImage
                  : "https://ui-avatars.com/api/?name=${controller.username}",
              height: 48.px,
              width: 48.px,
              borderRadius: BorderRadius.circular(24.px),
            ),
          ),
          SizedBox(width: 12.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back",
                    style: TextStyle(color: Colors.white70, fontSize: 12.px)),
                Text(
                  controller.username,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  controller.userPosition,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 11.px),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.px, 14.px, 20.px, 6.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quick Actions",
              style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold)),
          SizedBox(height: 6.px),
          GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10.px,
            crossAxisSpacing: 10.px,
            childAspectRatio: 2.1,
            children: [
              _actionTile(context, "Reports", Icons.analytics_rounded,
                  const Color(0xFF6366F1), () {
                NavigationMethods.pushMethod(
                    context: context,
                    widget: const SupervisorShiftReportsScreen());
              }),
              _actionTile(
                  context,
                  "Requests",
                  Icons.quick_contacts_mail_rounded,
                  const Color(0xFFF59E0B), () {
                NavigationMethods.pushMethod(
                    context: context, widget: const SupervisorRequestsScreen());
              }),
              _actionTile(context, "Team Chat", Icons.forum_rounded,
                  const Color(0xFF10B981), () {
                NavigationMethods.pushMethod(
                    context: context,
                    widget: const SupervisorGroupListScreen());
              }),
              _actionTile(context, "Schedules", Icons.calendar_today_rounded,
                  const Color(0xFF3B82F6), () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionTile(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.px),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.px),
        splashColor: color.withOpacity(0.15),
        highlightColor: color.withOpacity(0.08),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.px),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.px),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.px),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.px),
                ),
                child: Icon(icon, color: color, size: 20.px),
              ),
              SizedBox(width: 10.px),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.px,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamSection(SupervisorDashboardController controller,
      Color primary, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.px, 4.px, 20.px, 12.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("My Team",
              style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold)),
          SizedBox(height: 6.px),
          controller.employees.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.employees.length,
                  itemBuilder: (context, index) {
                    final emp = controller.employees[index];
                    return _employeeListItem(emp, primary, context);
                  },
                ),
        ],
      ),
    );
  }

  Widget _employeeListItem(var emp, Color primary, BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.px),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.px),
        splashColor: primary.withOpacity(0.12),
        highlightColor: primary.withOpacity(0.06),
        onTap: () {
          NavigationMethods.pushMethod(
            context: context,
            widget: SupervisorEmployeeShiftDetails(
              employeeData: emp,
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 8.px),
          padding: EdgeInsets.all(10.px),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.px),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              CommonWidgets.imageView(
                image: emp.image != null && emp.image!.isNotEmpty
                    ? emp.image!
                    : "https://ui-avatars.com/api/?name=${emp.firstName}",
                height: 42.px,
                width: 42.px,
                borderRadius: BorderRadius.circular(8.px),
              ),
              SizedBox(width: 12.px),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${emp.firstName} ${emp.lastName}",
                      style: TextStyle(
                        fontSize: 14.px,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      emp.email ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.px,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.px,
                color: primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.px),
      child: Center(
        child: Text("No team members found",
            style: TextStyle(color: Colors.grey, fontSize: 13.px)),
      ),
    );
  }
}
