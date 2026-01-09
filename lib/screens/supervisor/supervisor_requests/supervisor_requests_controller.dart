import 'package:flutter/material.dart';

class SupervisorRequestsController extends ChangeNotifier {
  bool inAsyncCall = false;
  String selectedFilter = "All";
  final List<String> filters = ["All", "Shift Swap", "Time-off"];
  final TextEditingController commentController = TextEditingController();

  // Mock Data
  List<Map<String, dynamic>> requests = [
    {
      "id": "1",
      "name": "Amit Sharma",
      "type": "Shift Swap",
      "date": "20 Dec 2023",
      "shift": "Morning (08:00 - 16:00)",
      "status": "Pending",
      "reason": "Family emergency, need to swap with Rahul."
    },
    {
      "id": "2",
      "name": "Priya Singh",
      "type": "Time-off",
      "date": "22 Dec - 24 Dec",
      "shift": "Full Day",
      "status": "Pending",
      "reason": "Personal work at home."
    }
  ];

  void setFilter(String val) {
    selectedFilter = val;
    notifyListeners();
  }

  void setLoading(bool val) {
    inAsyncCall = val;
    notifyListeners();
  }

  Future<void> handleAction({required String requestId, required bool isApprove, required BuildContext context}) async {
    setLoading(true);
    // Simulate API Call
    await Future.delayed(const Duration(seconds: 2));

    setLoading(false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isApprove ? "Request Approved" : "Request Rejected"),
        backgroundColor: isApprove ? Colors.green : Colors.red,
      ),
    );
    // Real logic: remove from list or update status
  }
}