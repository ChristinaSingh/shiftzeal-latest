import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../apis/api_models/supervisior/shift_report_data_model.dart';
import '../../../common/common_widgets.dart';
import '../shift_report_details/shift_report_details_controller.dart';

class ShiftReportDetailScreen extends StatelessWidget {
  final ShiftReportData reportData;

  const ShiftReportDetailScreen({
    super.key,
    required this.reportData,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    double score = double.tryParse(reportData.score ?? '0') ?? 0.0;
    bool isAcceptable = score >= 75;

    bool isAlreadyApproved =
        reportData.reportStatus?.toLowerCase() == 'approvel';

    return ChangeNotifierProvider(
      create: (_) => ShiftReportDetailController(),
      child: Consumer<ShiftReportDetailController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F6FA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              title: Text(
                "Report Details",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.px,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEmployeeCard(),
                        SizedBox(height: 20.px),
                        _buildScoreCard(primary, score),
                        SizedBox(height: 25.px),
                        Text(
                          "Task Reports",
                          style: TextStyle(
                            fontSize: 17.px,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.px),
                        Column(
                          children: reportData.tasks!
                              .map((task) => _buildTaskItem(task))
                              .toList(),
                        ),
                        SizedBox(height: 20.px),
                        if (!isAlreadyApproved)
                          _buildFeedbackField(isAcceptable, controller),
                        SizedBox(height: 20.px),
                      ],
                    ),
                  ),
                ),
                if (!isAlreadyApproved)
                  _buildBottomAction(
                      context, controller, isAcceptable, primary),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmployeeCard() {
    return Container(
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.px),
      ),
      child: Row(
        children: [
          CommonWidgets.imageView(
            image: reportData.image ?? '',
            height: 55.px,
            width: 55.px,
            borderRadius: BorderRadius.circular(30.px),
          ),
          SizedBox(width: 15.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${reportData.firstName ?? ''} ${reportData.lastName ?? ''}",
                  style: TextStyle(
                    fontSize: 16.px,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2.px,
                ),
                Text(
                  "${reportData.shiftDate ?? ''} | ${reportData.startTime ?? ''} - ${reportData.endTime ?? ''}",
                  style: TextStyle(
                    fontSize: 12.px,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(Color primary, double score) {
    return Container(
      padding: EdgeInsets.all(20.px),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primary, primary.withOpacity(0.85)]),
        borderRadius: BorderRadius.circular(18.px),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Performance Score : ",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                score >= 75 ? "Good Standing" : "Needs Improvement",
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 28.px,
            backgroundColor: Colors.white,
            child: Text(
              "${score.toInt()}",
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.bold,
                fontSize: 20.px,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTaskItem(Tasks task) {
    bool isCompleted = task.taskStatus?.toLowerCase() == 'complete';

    return Container(
      margin: EdgeInsets.only(bottom: 12.px),
      padding: EdgeInsets.all(15.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.px),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.description ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                isCompleted ? Icons.check_circle : Icons.warning_amber,
                color: isCompleted ? Colors.green : Colors.orange,
                size: 18.px,
              ),
            ],
          ),
          const Divider(),
          Text(
            "Hours: ${task.hours ?? ''} | Status: ${task.taskStatus ?? ''}",
            style: TextStyle(fontSize: 13.px),
          ),
          if (task.userReportContent != null) ...[
            SizedBox(height: 5.px),
            Text(
              "Remarks: ${task.userReportContent}",
              style: TextStyle(
                fontSize: 12.px,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFeedbackField(
    bool isAcceptable,
    ShiftReportDetailController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Supervisor Feedback",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.px),
        TextField(
          controller: controller.feedbackController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: isAcceptable
                ? "Add optional feedback..."
                : "Mandatory: Mention what needs revision",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.px),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(
    BuildContext context,
    ShiftReportDetailController controller,
    bool isAcceptable,
    Color primary,
  ) {
    return Container(
      padding: EdgeInsets.all(20.px),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50.px,
          child: ElevatedButton(
            onPressed: controller.inAsyncCall
                ? null
                : () {
                    controller.processReport(
                      reportId: reportData.reportId.toString(),
                      isApprove: isAcceptable,
                      context: context,
                      employeeName:
                          "${reportData.firstName ?? ''} ${reportData.lastName ?? ''}",
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: isAcceptable ? Colors.green : Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.px),
              ),
            ),
            child: controller.inAsyncCall
                ? SizedBox(
                    height: 22.px,
                    width: 22.px,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    isAcceptable ? "APPROVE REPORT" : "REQUEST REVISION",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
