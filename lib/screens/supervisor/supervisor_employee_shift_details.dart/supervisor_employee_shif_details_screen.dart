import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart'; // Add this package in pubspec.yaml
import 'package:shiftzeal/constants/icons_constant.dart';
import '../../../apis/api_models/supervisor_employee_model.dart';
import '../../../common/common_methods.dart';
import '../../../common/common_widgets.dart';
import '../../../common/navigation_methos.dart';
import 'supervisor_employee_shif_details_controller.dart';

class SupervisorEmployeeShiftDetails extends StatefulWidget {
  const SupervisorEmployeeShiftDetails({super.key, required this.employeeData});
  final EmployeesData employeeData;

  @override
  State<SupervisorEmployeeShiftDetails> createState() =>
      _SupervisorEmployeeShiftDetailsState();
}

class _SupervisorEmployeeShiftDetailsState
    extends State<SupervisorEmployeeShiftDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<SupervisorEmployeeShiftDetailsController>(
        context,
        listen: false,
      );
      controller.getAssignedEmployeesShiftsList(
          context: context, userId: widget.employeeData.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Consumer<SupervisorEmployeeShiftDetailsController>(
      builder: (context, controller, child) {
        return SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor:
                const Color(0xFFF8F9FD), // Modern light grey background
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(16.px),
              color: Colors.white,
              child: CommonWidgets.commonElevatedButton(
                text: "Assign New Shift",
                onPressed: () {
                  _showAddShiftBottomSheet(context);
                },
                context: context,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- HEADER ---
                    Row(
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
                        SizedBox(width: 12.px),
                        Text(
                          "Employee Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.px,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.px),

                    // --- PERSONAL DETAILS CARD (REDESIGNED) ---
                    _buildSectionTitle("Personal Details"),
                    SizedBox(height: 12.px),
                    Container(
                      padding: EdgeInsets.all(16.px),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.px),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2.px),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: primary.withOpacity(0.2), width: 2),
                            ),
                            child: CommonWidgets.imageView(
                              image: widget.employeeData.image ?? "",
                              height: 55.px,
                              width: 55.px,
                              borderRadius: BorderRadius.circular(27.5.px),
                            ),
                          ),
                          SizedBox(width: 15.px),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.employeeData.firstName ?? ""} ${widget.employeeData.lastName ?? ""}"
                                      .trim(),
                                  style: TextStyle(
                                    fontSize: 17.px,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.px),
                                Text(
                                  widget.employeeData.email ?? "",
                                  style: TextStyle(
                                    fontSize: 13.px,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28.px),
                    _buildSectionTitle("Shift History"),
                    SizedBox(height: 12.px),

                    // --- SHIMMER LOADING OR LIST ---
                    controller.inAsyncCall
                        ? _buildShimmerList()
                        : controller.employeeShiftsData.isEmpty
                            ? _buildEmptyState()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.employeeShiftsData.length,
                                itemBuilder: (context, index) {
                                  return _buildShiftCard(
                                      controller.employeeShiftsData[index],
                                      primary);
                                },
                              ),
                    SizedBox(height: 20.px),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper for Section Titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.px,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        letterSpacing: 0.5,
      ),
    );
  }

  // --- REDESIGNED SHIFT CARD ---
  Widget _buildShiftCard(var shift, Color primary) {
    bool isPending = shift.status == "Pending";
    Color statusColor = isPending ? Colors.orange : Colors.green;

    return Container(
      margin: EdgeInsets.only(bottom: 16.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.px),
        // Adding a subtle left status indicator
        border: Border(left: BorderSide(color: statusColor, width: 4.px)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 14.px, color: primary),
                    SizedBox(width: 8.px),
                    Text(
                      shift.shiftDate ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.px),
                    ),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.px, vertical: 4.px),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.px),
                  ),
                  child: Text(
                    shift.status?.toUpperCase() ?? "",
                    style: TextStyle(
                      fontSize: 11.px,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.px),
            Row(
              children: [
                Icon(Icons.access_time, size: 14.px, color: Colors.black87),
                SizedBox(width: 6.px),
                Text(
                  "${shift.startTime ?? ""} - ${shift.endTime ?? ""}",
                  style: TextStyle(fontSize: 13.px, color: Colors.black87),
                ),
              ],
            ),
            if (shift.address != null) ...[
              SizedBox(height: 6.px),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 14.px, color: Colors.black87),
                  SizedBox(width: 6.px),
                  Expanded(
                    child: Text(
                      shift.address!,
                      style: TextStyle(fontSize: 13.px, color: Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            Divider(height: 24.px, color: Colors.black87),
            Text(
              "Tasks",
              style: TextStyle(fontSize: 14.px, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.px),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: shift.tasks?.length ?? 0,
              itemBuilder: (context, tIndex) {
                var task = shift.tasks![tIndex];
                return Padding(
                  padding: EdgeInsets.only(bottom: 6.px),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline,
                          size: 14.px,
                          color: task.taskStatus == "Pending"
                              ? Colors.black87
                              : Colors.green),
                      SizedBox(width: 10.px),
                      Expanded(
                        child: Text(
                          task.description ?? "",
                          style:
                              TextStyle(fontSize: 13.px, color: Colors.black87),
                        ),
                      ),
                      Text(
                        task.taskStatus ?? "",
                        style: TextStyle(
                          fontSize: 11.px,
                          fontWeight: FontWeight.w600,
                          color: task.taskStatus == "Pending"
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4, // 4 dummy cards dikhayenge
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.px),
          padding: EdgeInsets.all(16.px),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.px),
            // Subtle border to match original card
            border:
                Border(left: BorderSide(color: Colors.black87, width: 4.px)),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Date + Status Badge placeholder
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: 14.px,
                            width: 14.px,
                            color: Colors.white), // Icon
                        SizedBox(width: 8.px),
                        Container(
                            height: 14.px,
                            width: 100.px,
                            color: Colors.white), // Date
                      ],
                    ),
                    Container(
                      height: 22.px,
                      width: 60.px,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.px)),
                    ),
                  ],
                ),
                SizedBox(height: 14.px),

                // Row 2: Time Placeholder
                Row(
                  children: [
                    Container(
                        height: 12.px,
                        width: 12.px,
                        color: Colors.white), // Icon
                    SizedBox(width: 8.px),
                    Container(
                        height: 12.px, width: 120.px, color: Colors.white),
                  ],
                ),
                SizedBox(height: 8.px),

                // Row 3: Address Placeholder
                Row(
                  children: [
                    Container(
                        height: 12.px,
                        width: 12.px,
                        color: Colors.white), // Icon
                    SizedBox(width: 8.px),
                    Container(
                        height: 12.px, width: 180.px, color: Colors.white),
                  ],
                ),

                // Divider
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.px),
                  child: Container(
                      height: 1.px,
                      width: double.infinity,
                      color: Colors.white),
                ),

                // Row 4: Tasks Title Placeholder
                Container(height: 14.px, width: 50.px, color: Colors.white),
                SizedBox(height: 10.px),

                // Row 5: Task Items (2 lines)
                Column(
                  children: List.generate(
                      2,
                      (index) => Padding(
                            padding: EdgeInsets.only(bottom: 8.px),
                            child: Row(
                              children: [
                                Container(
                                    height: 12.px,
                                    width: 12.px,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle)),
                                SizedBox(width: 10.px),
                                Container(
                                    height: 10.px,
                                    width: 150.px,
                                    color: Colors.white),
                                const Spacer(),
                                Container(
                                    height: 10.px,
                                    width: 40.px,
                                    color: Colors.white),
                              ],
                            ),
                          )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 50.px),
        child: Column(
          children: [
            Icon(Icons.event_note_outlined, size: 50.px, color: Colors.black87),
            SizedBox(height: 12.px),
            Text("No shifts assigned yet",
                style: TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  void _showAddShiftBottomSheet(BuildContext context) {
    final controller = Provider.of<SupervisorEmployeeShiftDetailsController>(
        context,
        listen: false);

    // Static colors to prevent crashes
    const Color primaryRed = Color(0xFFE60001);
    const Color lightGrey = Color(0xFFF4F6F8);
    const Color textGrey = Color(0xFF637381);

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.px)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24.px,
            right: 24.px,
            top: 12.px,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pull Handle
                Center(
                  child: Container(
                    height: 5.px,
                    width: 45.px,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 25.px),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CommonMethods.appIcons(
                        assetName: IconConstants.icBack,
                        height: 34.px,
                        width: 34.px,
                      ),
                    ),
                    SizedBox(
                      width: 12.px,
                    ),
                    Text(
                      "Assign New Shift",
                      style: TextStyle(
                          fontSize: 20.px,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 10.px),
                Text(
                  "Fill in the details to schedule a new shift",
                  style: TextStyle(fontSize: 13.px, color: textGrey),
                ),
                SizedBox(height: 25.px),

                // Date Field
                _labelTitle("Shift Date"),
                CommonWidgets.normalTextFieldForLoginSignUP(
                  context: context,
                  controller: controller.shiftDateController,
                  focusNode: controller.focusShiftDate,
                  isCard: controller.isShiftDate,
                  readOnly: true,
                  onTap: () => controller.selectDate(context: context),
                  labelText: "Select Date",
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 13.px),
                  suffixIcon: Icon(Icons.calendar_today_rounded,
                      color: primaryRed, size: 18.px),
                ),
                SizedBox(height: 16.px),

                // Time Fields
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _labelTitle("Start Time"),
                          CommonWidgets.normalTextFieldForLoginSignUP(
                            context: context,
                            labelStyle: TextStyle(
                                color: Colors.black87, fontSize: 13.px),
                            controller: controller.startTimeController,
                            focusNode: controller.focusStartTime,
                            isCard: controller.isStartTime,
                            readOnly: true,
                            onTap: () =>
                                controller.selectStartTime(context: context),
                            labelText: "00:00 AM",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.px),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _labelTitle("End Time"),
                          CommonWidgets.normalTextFieldForLoginSignUP(
                            context: context,
                            controller: controller.endTimeController,
                            focusNode: controller.focusEndTime,
                            isCard: controller.isEndTime,
                            labelStyle: TextStyle(
                                color: Colors.black87, fontSize: 13.px),
                            readOnly: true,
                            onTap: () =>
                                controller.selectEndTime(context: context),
                            labelText: "00:00 PM",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.px),

                _labelTitle("Work Address"),
                CommonWidgets.normalTextFieldForLoginSignUP(
                    context: context,
                    controller: controller.addressController,
                    focusNode: controller.focusAddress,
                    isCard: controller.isAddress,
                    labelStyle:
                        TextStyle(color: Colors.black87, fontSize: 13.px),
                    labelText: "Enter location details"),
                SizedBox(height: 16.px),

                _labelTitle("Shift Amount"),
                CommonWidgets.normalTextFieldForLoginSignUP(
                  context: context,
                  controller: controller.amountController,
                  focusNode: controller.focusAmount,
                  isCard: controller.isAmount,
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 13.px),
                  keyboardType: TextInputType.number,
                  labelText: "Enter amount",
                ),

                SizedBox(height: 25.px),

                // Tasks Container
                Container(
                  padding: EdgeInsets.all(16.px),
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(15.px),
                  ),
                  child: Consumer<SupervisorEmployeeShiftDetailsController>(
                    builder: (context, controller, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Add Task Items",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.px,
                                  color: Colors.black)),
                          SizedBox(height: 10.px),
                          if (controller.tasks.isNotEmpty)
                            Wrap(
                              spacing: 8.px,
                              runSpacing: 4.px,
                              children: controller.tasks
                                  .map((task) => Chip(
                                        backgroundColor: Colors.white,
                                        elevation: 0,
                                        side: BorderSide(color: Colors.black87),
                                        label: Text(task,
                                            style: TextStyle(
                                                fontSize: 12.px,
                                                color: Colors.black87)),
                                        onDeleted: () =>
                                            controller.removeTask(task),
                                        deleteIconColor: primaryRed,
                                        deleteIcon:
                                            Icon(Icons.cancel, size: 16.px),
                                      ))
                                  .toList(),
                            ),
                          SizedBox(height: 12.px),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 45.px,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.px),
                                  ),
                                  child: TextField(
                                    controller: controller.taskController,
                                    decoration: InputDecoration(
                                      hintText: "Enter task name...",
                                      hintStyle: TextStyle(
                                          fontSize: 13.px, color: textGrey),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.px),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.px),
                              GestureDetector(
                                onTap: controller.addTask,
                                child: Container(
                                  height: 45.px,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.px),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.px),
                                  ),
                                  child: Center(
                                    child: Text("Add",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.px)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),

                SizedBox(height: 35.px),

                // Primary Action Button
                CommonWidgets.commonCustumeButton(
                  buttonMargin: EdgeInsets.only(bottom: 30.px),
                  child: Text(
                    "Confirm & Assign Shift",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.px),
                  ),
                  showLoading: controller.inAsyncCall,
                  onPressed: () {
                    controller.assignNewShift(
                        context: context,
                        userId: widget.employeeData.id.toString());
                  },
                  context: context,
                ),
                SizedBox(height: 35.px),
              ],
            ),
          ),
        );
      },
    );
  }

  // Label helper
  Widget _labelTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.px, left: 2.px),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14.px,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212B36)),
      ),
    );
  }
}
