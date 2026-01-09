import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/admin_screens/task_lists/task_lists_controller.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/navigation_methos.dart';
import '../add_task_lists/add_task_lists_controller.dart';

class TaskListsScreen extends StatefulWidget {
  const TaskListsScreen({super.key});

  @override
  State<TaskListsScreen> createState() => TaskListsScreenState();
}

class TaskListsScreenState extends State<TaskListsScreen> {
  @override
  void initState() {
    super.initState();
    var taskListsController =
        Provider.of<TaskListsController>(context, listen: false);
  }

  final items = List.generate(6, (index) => 'Emma\'s onboarding checklist');

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListsController>(
      builder: (context, controller, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: GestureDetector(
                  onTap: () {
                    NavigationMethods.popMethod(context: context);
                  },
                  child: CommonMethods.appIcons(
                      assetName: IconConstants.icBack,
                      height: 34.px,
                      width: 34.px)),
              actions: [
                InkWell(
                  onTap: () {
                    controller.clickOnAddButton(context: context);
                  },
                  child: CommonMethods.appIcons(
                      assetName: IconConstants.icAddCircle,
                      height: 28.px,
                      width: 28.px),
                ),
                SizedBox(
                  width: 20.px,
                )
              ],
              title: Text(
                StringConstants.setting,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 20.px),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(44.px),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.px),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(25.px)),
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      automaticIndicatorColorAdjustment: false,
                      indicatorSize: TabBarIndicatorSize.tab,
                      // onTap: (value) =>
                      //     controller.clickOnTap(value: value, context: context),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 14.px,
                              color: Theme.of(context).primaryColor),
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontSize: 14.px, fontWeight: FontWeight.w700),
                      dividerColor: Theme.of(context).colorScheme.surface,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(StringConstants.team)],
                          ),
                        ),
                        Tab(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(StringConstants.team)],
                          ),
                        ),
                        //      Tab(text: 'Open Shift'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                TeamScreen(),
                TeamScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
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

class TeamScreen extends StatelessWidget {
  const TeamScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No shift task lists found.',
          style: TextStyle(fontSize: 20.px, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20.px,
        ),
        Text(
          'Create shift task lists to let users know what \n needs to be completed during their shift.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.px, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
