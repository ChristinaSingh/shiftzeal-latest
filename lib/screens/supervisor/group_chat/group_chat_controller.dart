import 'package:flutter/material.dart';

class GroupListController extends ChangeNotifier {
  bool inAsyncCall = false;
  final TextEditingController groupNameController = TextEditingController();
  // Selected members maintain karne ke liye list
  List<Map<String, dynamic>> selectedEmployees = [];

  List<Map<String, dynamic>> groups = [
    {
      "id": "101",
      "name": "Morning Shift Team",
      "lastMsg": "Please ensure the floor is dry.",
      "type": "Shift-based",
      "memberCount": 12,
      "time": "10:30 AM"
    },
    {
      "id": "102",
      "name": "Safety Announcements",
      "lastMsg": "New SOPs are uploaded.",
      "type": "Announcement",
      "memberCount": 45,
      "time": "Yesterday"
    }
  ];

  List<Map<String, dynamic>> allEmployees = [
    {"id": "1", "name": "Amit Sharma", "role": "Full-time"},
    {"id": "2", "name": "Priya Singh", "role": "Part-time"},
    {"id": "3", "name": "Rahul Verma", "role": "Full-time"},
    {"id": "4", "name": "Sonia Malik", "role": "Contract"},
  ];

  void toggleSelection(Map<String, dynamic> emp) {
    if (selectedEmployees.contains(emp)) {
      selectedEmployees.remove(emp);
    } else {
      selectedEmployees.add(emp);
    }
    notifyListeners();
  }

  void setLoading(bool val) {
    inAsyncCall = val;
    notifyListeners();
  }

  Future<void> createGroup(BuildContext context) async {
    if (groupNameController.text.isEmpty || selectedEmployees.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter name and select members")));
      return;
    }

    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));

    groups.insert(0, {
      "id": DateTime.now().toString(),
      "name": groupNameController.text,
      "lastMsg": "Group created with ${selectedEmployees.length} members",
      "type": "Team-based",
      "memberCount": selectedEmployees.length,
      "time": "Just now"
    });

    groupNameController.clear();
    selectedEmployees.clear();
    setLoading(false);
    Navigator.pop(context); // Close Screen
  }
}
