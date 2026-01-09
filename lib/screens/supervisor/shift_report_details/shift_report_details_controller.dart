import 'package:flutter/material.dart';
import 'package:shiftzeal/apis/api_methods/api_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';

class ShiftReportDetailController extends ChangeNotifier {
  bool inAsyncCall = false;
  final TextEditingController feedbackController = TextEditingController();

  List<Map<String, dynamic>> tasks = [
    {
      "taskName": "Clear Room",
      "completion": "Completed",
      "quality": "Good",
      "remarks": "Cleaned all areas as per SOP.",
      "isWarning": false,
    },
    {
      "taskName": "Wash Parking",
      "completion": "Partial",
      "quality": "Average",
      "remarks": "Water supply issue, section B pending.",
      "isWarning": true,
    },
  ];

  void setLoading(bool value) {
    inAsyncCall = value;
    notifyListeners();
  }

  Future<void> processReport({
    required BuildContext context,
    required bool isApprove,
    required String reportId,
    required String employeeName,
  }) async {
    if (!isApprove && feedbackController.text.trim().isEmpty) {
      CommonWidgets.showMyToastMessage("Feedback is required");
      return;
    }

    setLoading(true);

    try {
      final response = await ApiMethods.updateShiftReportStatusApi(
        context: context,
        bodyParams: {
          "report_id": reportId,
          "status": isApprove ? "Approvel" : "Reassigne",
          "reason": isApprove ? "" : feedbackController.text.trim(),
        },
      );

      if (response != null && response['status'] == "1") {
        CommonWidgets.showMyToastMessage(
          isApprove
              ? "Report approved for $employeeName"
              : "Revision requested for $employeeName",
        );

        Navigator.pop(context, true);
      } else {
        CommonWidgets.showMyToastMessage(
          response?['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}
