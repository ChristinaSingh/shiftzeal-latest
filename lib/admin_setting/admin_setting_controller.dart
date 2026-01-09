import 'package:flutter/cupertino.dart';

class AdminsettingController extends ChangeNotifier {


  final List<Map<String, String>> cards = [
    {"title": "Time-Off Request Status"},
    {"title": "Swap/Drop Requests"},
    {"title": "OpenShift Requests"},
    {"title": "Schedule Updates"},
    {"title": "Clock In/Out Reminders"},
  ];

  final List<String> toggles = [
    "Time-off Approved Notifications",
    "Schedule Updated Notifications",
    "Clock In/Out Notifications",
  ];


}