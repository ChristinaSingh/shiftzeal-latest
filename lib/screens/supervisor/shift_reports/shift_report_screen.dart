import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
// Sahi model import karein
import '../../../apis/api_models/supervisior/shift_report_data_model.dart';
import '../../../common/common_methods.dart';
import '../../../common/common_widgets.dart';
import '../../../common/navigation_methos.dart';
import '../../../constants/icons_constant.dart';
import '../shift_report_details/shift_report_details_screen.dart';
import 'shift_report_controller.dart';

class SupervisorShiftReportsScreen extends StatefulWidget {
  const SupervisorShiftReportsScreen({super.key});

  @override
  State<SupervisorShiftReportsScreen> createState() =>
      _SupervisorShiftReportsScreenState();
}

class _SupervisorShiftReportsScreenState
    extends State<SupervisorShiftReportsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return ChangeNotifierProvider(
      create: (context) =>
          SupervisorShiftReportsController()..getAllShiftReports(context),
      child: Consumer<SupervisorShiftReportsController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F6FA),
            appBar: AppBar(
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0.5,
              title: Row(
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
                  SizedBox(
                    width: 12.px,
                  ),
                  Text(
                    "Shift Reports",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.px,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                _buildFilterSection(controller, primary),
                Expanded(
                  child: controller.inAsyncCall
                      ? _buildShimmerList()
                      : controller.filteredReports.isEmpty
                          ? Center(
                              child: Text(
                              "No Reports Available",
                              style: TextStyle(
                                  fontSize: 14.px,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                            ))
                          : ListView.builder(
                              padding: EdgeInsets.all(16.px),
                              itemCount: controller.filteredReports.length,
                              itemBuilder: (context, index) {
                                final report =
                                    controller.filteredReports[index];
                                return _buildReportCard(
                                    report, primary, context);
                              },
                            ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterSection(
      SupervisorShiftReportsController controller, Color primary) {
    return Container(
      height: 60.px,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 10.px),
        itemCount: controller.statusFilters.length,
        itemBuilder: (context, index) {
          final filter = controller.statusFilters[index];
          bool isSelected = controller.selectedStatus == filter;
          return Padding(
            padding: EdgeInsets.only(right: 10.px),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (val) => controller.setStatus(filter),
              selectedColor: primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 13.px,
              ),
              backgroundColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.px)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.px),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.px),
          padding: EdgeInsets.all(16.px),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.px),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 45.px,
                      width: 45.px,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 12.px),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120.px,
                            height: 14.px,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.px),
                            ),
                          ),
                          SizedBox(height: 8.px),
                          Container(
                            width: 70.px,
                            height: 10.px,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.px),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 65.px,
                      height: 22.px,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.px),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.px),
                Container(
                  height: 1.px,
                  width: double.infinity,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 4.px),
                ),
                SizedBox(height: 12.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 16.px,
                          height: 16.px,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.px),
                        Container(
                          width: 80.px,
                          height: 12.px,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.px),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16.px,
                          height: 16.px,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.px),
                        Container(
                          width: 60.px,
                          height: 12.px,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.px),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReportCard(
      ShiftReportData report, Color primary, BuildContext context) {
    final statusColor = _getStatusColor(report.reportStatus);
    final statusText = _getStatusText(report.reportStatus);

    return GestureDetector(
      onTap: () {
        NavigationMethods.pushMethod(
          context: context,
          widget: ShiftReportDetailScreen(reportData: report),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.px),
        padding: EdgeInsets.all(16.px),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.px),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CommonWidgets.imageView(
                  image: report.image ?? "",
                  height: 45.px,
                  width: 45.px,
                  borderRadius: BorderRadius.circular(25.px),
                ),
                SizedBox(width: 12.px),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${report.firstName ?? ''} ${report.lastName ?? ''}",
                        style: TextStyle(
                          fontSize: 16.px,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.px),
                      Text(
                        report.shiftDate ?? "",
                        style: TextStyle(
                          fontSize: 13.px,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.px,
                    vertical: 4.px,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8.px),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12.px,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 24.px),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16.px, color: Colors.grey),
                    SizedBox(width: 6.px),
                    Text(
                      "${report.startTime ?? ""} - ${report.endTime ?? ""}",
                      style: TextStyle(
                        fontSize: 13.px,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, size: 16.px, color: Colors.amber),
                    SizedBox(width: 4.px),
                    Text(
                      "Score: ${report.score ?? 0}",
                      style: TextStyle(
                        fontSize: 13.px,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.blue;
      case 'approvel':
        return Colors.green;
      case 'complete':
        return Colors.teal;
      case 'reassigne':
      case 'revision':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'approvel':
        return 'Approved';
      case 'complete':
        return 'Completed';
      case 'reassigne':
      case 'revision':
        return 'Reassigned';
      default:
        return status ?? '';
    }
  }
}
