import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import '../../admin_screens/dashboard/dashboard_controller.dart';
import '../../common/navigation_methos.dart';
import 'add_shift_task_controller.dart';

class AddEmployeeShiftTaskScreen extends StatefulWidget {
  const AddEmployeeShiftTaskScreen({super.key, required this.shiftId});
  final String shiftId;

  @override
  State<AddEmployeeShiftTaskScreen> createState() =>
      _AddEmployeeShiftTaskScreenState();
}

class _AddEmployeeShiftTaskScreenState
    extends State<AddEmployeeShiftTaskScreen> {
  @override
  void initState() {
    super.initState();
    var addShiftController =
        Provider.of<AddEmployeeShiftTasksController>(context, listen: false);
    addShiftController.startListener();
    // addShiftController.fetchShiftTaskDetails(context: context, taskId: widget.shiftId);

    Future.microtask(() {
      Provider.of<DashboardController>(context, listen: false)
          .fetchEmployeeDirectory(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEmployeeShiftTasksController>(
      builder: (context, controller, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 20.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 Top Bar
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            NavigationMethods.popMethod(context: context),
                        child: CommonWidgets.appIcons(
                          assetName: IconConstants.icBlueBack,
                          height: 40.px,
                          width: 40.px,
                        ),
                      ),
                      const Spacer(),
                      CommonMethods.appIcons(
                        assetName: IconConstants.icSplashLogo,
                        height: 55.px,
                        width: 55.px,
                      ),
                      const Spacer(),
                      SizedBox(width: 40.px),
                    ],
                  ),
                  SizedBox(height: 30.px),

                  /// 🔹 Screen Title
                  Center(
                    child: Text(
                      'Add Shift Task',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 22.sp,
                              ),
                    ),
                  ),
                  SizedBox(height: 30.px),

                  /// 🔹 Form Container
                  Container(
                    padding: EdgeInsets.all(18.px),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.px),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Task Heading
                        Text("Task Heading",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                        SizedBox(height: 8.px),
                        CommonWidgets.normalTextFieldForLoginSignUP(
                          context: context,
                          controller: controller.headingController,
                          focusNode: controller.focusHeading,
                          labelText: "Enter task heading",
                          labelStyle: const TextStyle(color: Colors.black54),
                        ),
                        SizedBox(height: 20.px),

                        /// Task Content
                        Text("Task Content",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                        SizedBox(height: 8.px),
                        CommonWidgets.normalTextFieldForLoginSignUP(
                          context: context,
                          controller: controller.contentController,
                          focusNode: controller.focusContent,
                          labelText: "Enter task content (optional)",
                          labelStyle: const TextStyle(color: Colors.black54),
                        ),
                        SizedBox(height: 20.px),

                        /// Task Description
                        Text("Task Description",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                        SizedBox(height: 8.px),
                        CommonWidgets.normalTextFieldForLoginSignUP(
                          context: context,
                          controller: controller.descriptionController,
                          focusNode: controller.focusDescription,
                          labelText: "Enter task description",
                          maxLines: 6,
                          labelStyle: const TextStyle(color: Colors.black54),
                        ),
                        SizedBox(height: 20.px),

                        /// Task Points
                        Text("Task Points",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                        SizedBox(height: 8.px),
                        CommonWidgets.normalTextFieldForLoginSignUP(
                          context: context,
                          maxLines: 6,
                          keyboardType: TextInputType.multiline,
                          controller: controller.taskPointsController,
                          focusNode: controller.focusTaskPoints,
                          labelText: "Comma separated task points",
                          hintText:
                              "e.g. Install Laravel, Setup DB, Create Auth Module",
                          labelStyle: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.px),

                  /// 🔹 Add Shift Task Button
                  CommonWidgets.commonCustumeButton(
                    onPressed: () => controller.clickAddShiftTaskButton(
                      context: context,
                      shiftId: widget.shiftId,
                    ),
                    borderRadius: 15.px,
                    buttonColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.px),
                      child: Text(
                        "Add Shift Task",
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                    showLoading: controller.inAsyncCall,
                    context: context,
                  ),
                  SizedBox(height: 20.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
