import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import '../../admin_screens/dashboard/dashboard_controller.dart';
import '../../common/navigation_methos.dart';
import 'add_shift_controller.dart';

class AddEmployeeShiftScreen extends StatefulWidget {
  const AddEmployeeShiftScreen({super.key});
  @override
  State<AddEmployeeShiftScreen> createState() => _AddEmployeeShiftScreenState();
}

class _AddEmployeeShiftScreenState extends State<AddEmployeeShiftScreen> {
  @override
  @override
  // void initState() {
  //   super.initState();
  //
  //   var addShiftController =
  //       Provider.of<AddEmployeeShiftController>(context, listen: false);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEmployeeShiftController>(
      builder: (context, controller, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.px),

                    /// Back + Logo
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
                          height: 60.px,
                          width: 60.px,
                        ),
                        const Spacer(),
                        SizedBox(width: 40.px),
                      ],
                    ),
                    SizedBox(height: 30.px),

                    /// Heading
                    Center(
                      child: Text(
                        'Add New Shift',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 30.px),

                    Consumer<DashboardController>(
                      builder: (context, dashboardController, child) {
                        return CommonWidgets.normalDropdownField(
                          context: context,
                          items: dashboardController
                              .users, // [{id, name, role, image}]
                          value:
                              controller.selectedUser, // will hold only userId
                          labelText: "Select User",
                          labelStyle: TextStyle(color: Colors.black),
                          onChanged: (selectedId) {
                            // 👇 yaha sirf id milegi
                            controller.selectedUser = selectedId ?? "";
                            print(
                                "Selected UserId: ${controller.selectedUser}");
                          },
                        );
                      },
                    ),

                    SizedBox(height: 20.px),

                    /// Shift Date
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.shiftDateController,
                      focusNode: controller.focusShiftDate,
                      isCard: controller.isShiftDate,
                      readOnly: true,
                      labelStyle: TextStyle(color: Colors.black),
                      onTap: () => controller.selectDate(context: context),
                      labelText: "Shift Date", // Changed to labelText
                      suffixIcon: InkWell(
                        onTap: () => controller.selectDate(context: context),
                        borderRadius: BorderRadius.circular(10.px),
                        child: const Icon(Icons.calendar_today,
                            color: Color(0xffffE60001)),
                      ),
                    ),
                    SizedBox(height: 20.px),

                    /// Start Time
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.startTimeController,
                      focusNode: controller.focusStartTime,
                      isCard: controller.isStartTime,
                      readOnly: true,
                      labelStyle: TextStyle(color: Colors.black),
                      onTap: () => controller.selectStartTime(context: context),
                      labelText: "Start Time", // Changed to labelText
                      suffixIcon: InkWell(
                        onTap: () =>
                            controller.selectStartTime(context: context),
                        borderRadius: BorderRadius.circular(10.px),
                        child: const Icon(Icons.access_time,
                            color: Color(0xffffE60001)),
                      ),
                    ),
                    SizedBox(height: 20.px),

                    /// End Time
                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.endTimeController,
                      focusNode: controller.focusEndTime,
                      isCard: controller.isEndTime,
                      labelStyle: TextStyle(color: Colors.black),
                      readOnly: true,
                      onTap: () => controller.selectEndTime(context: context),
                      labelText: "End Time", // Changed to labelText
                      suffixIcon: InkWell(
                        onTap: () => controller.selectEndTime(context: context),
                        borderRadius: BorderRadius.circular(10.px),
                        child: const Icon(Icons.access_time,
                            color: Color(0xffffE60001)),
                      ),
                    ),
                    SizedBox(height: 20.px),

                    /// Address
                    CommonWidgets.normalTextFieldForLoginSignUP(
                        context: context,
                        controller: controller.addressController,
                        focusNode: controller.focusAddress,
                        isCard: controller.isAddress,
                        labelText: "Address",
                        labelStyle: TextStyle(color: Colors.black)),
                    SizedBox(height: 20.px),

                    CommonWidgets.normalTextFieldForLoginSignUP(
                      context: context,
                      controller: controller.amountController, // must be amountController
                      focusNode: controller.focusAmount,
                      isCard: controller.isAmount,
                      keyboardType: TextInputType.number,
                      labelText: "Amount",
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      labelStyle: TextStyle(color: Colors.black),
                    ),

                    SizedBox(height: 30.px),

                    /// Add Shift Button
                    CommonWidgets.commonCustumeButton(
                      onPressed: () =>
                          controller.clickAddShiftButton(context: context),
                      borderRadius: 15.px,
                      buttonColor: Theme.of(context).primaryColor,
                      child: Text(
                        "Add Shift",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      showLoading: controller.inAsyncCall,
                      context: context,
                    ),
                    SizedBox(height: 40.px),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
