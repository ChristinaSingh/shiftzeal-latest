import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_constants/api_key_constants.dart';
import 'package:shiftzeal/apis/api_methods/api_methods.dart';
import '../../../apis/api_models/supervisior/shift_report_data_model.dart';

class SupervisorShiftReportsController extends ChangeNotifier {
  bool inAsyncCall = false;
  String selectedStatus = "All";
  final List<String> statusFilters = ["All", "Pending", "Approved", "Revision"];

  GetShiftReportModel? shiftReportModel;
  List<ShiftReportData> allReports = [];
  List<ShiftReportData> filteredReports = [];

  void setStatus(String status) {
    selectedStatus = status;
    _applyFilter();
    notifyListeners();
  }

  void setLoading(bool value) {
    inAsyncCall = value;
    notifyListeners();
  }

  Future<void> getAllShiftReports(BuildContext context) async {
    try {
      setLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString(ApiKeyConstants.userId) ?? "";

      final response = await ApiMethods.supervisorShiftReportDataApi(
        context: context,
        bodyParams: {"user_id": userId},
      );

      if (response != null && response.data != null) {
        shiftReportModel = response;
        allReports = response.data ?? [];
        _applyFilter();
      }
    } catch (e) {
      debugPrint("GetAllShiftReports Error: $e");
    } finally {
      setLoading(false);
    }
  }

  void _applyFilter() {
    if (selectedStatus == "All") {
      filteredReports = List.from(allReports);
    } else {
      filteredReports = allReports.where((report) {
        final status = report.reportStatus?.toLowerCase();

        if (selectedStatus == "Approved") {
          return status == "approvel";
        }

        if (selectedStatus == "Revision") {
          return status == "revision" || status == "reassigne";
        }

        return status == selectedStatus.toLowerCase();
      }).toList();
    }
  }
}
