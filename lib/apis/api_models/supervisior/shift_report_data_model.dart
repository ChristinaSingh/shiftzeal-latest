class GetShiftReportModel {
  String? status;
  String? message;
  List<ShiftReportData>? data;

  GetShiftReportModel({this.status, this.message, this.data});

  factory GetShiftReportModel.fromJson(Map<String, dynamic> json) {
    return GetShiftReportModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => ShiftReportData.fromJson(e))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class ShiftReportData {
  int? reportId;
  String? reportContent;
  String? reportStatus;
  int? id;
  int? userId;
  int? employeeId;
  String? shiftDate;
  String? startTime;
  String? endTime;
  String? address;
  String? lat;
  String? lon;
  String? createdAt;
  String? updatedAt;
  int? breakMinutes;
  String? totalHours;
  String? position;
  String? amount;
  String? status;
  String? checkInDate;
  String? checkOutDate;
  String? cancelIds;
  String? checkinLat;
  String? checkinLon;
  String? checkinAddress;
  String? score;
  String? firstName;
  String? lastName;
  String? image;
  List<Tasks>? tasks;

  ShiftReportData({
    this.reportId,
    this.reportContent,
    this.reportStatus,
    this.id,
    this.userId,
    this.employeeId,
    this.shiftDate,
    this.startTime,
    this.endTime,
    this.address,
    this.lat,
    this.lon,
    this.createdAt,
    this.updatedAt,
    this.breakMinutes,
    this.totalHours,
    this.position,
    this.amount,
    this.status,
    this.checkInDate,
    this.checkOutDate,
    this.cancelIds,
    this.checkinLat,
    this.checkinLon,
    this.checkinAddress,
    this.score,
    this.firstName,
    this.lastName,
    this.image,
    this.tasks,
  });

  factory ShiftReportData.fromJson(Map<String, dynamic> json) {
    return ShiftReportData(
      reportId: json['report_id'],
      reportContent: json['report_content'],
      reportStatus: json['report_status'],
      id: json['id'],
      userId: json['user_id'],
      employeeId: json['employee_id'],
      shiftDate: json['shift_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      address: json['address'],
      lat: json['lat'],
      lon: json['lon'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      breakMinutes: json['break_minutes'],
      totalHours: json['total_hours'],
      position: json['user_position'] ?? json['position'],
      amount: json['amount'],
      status: json['status'],
      checkInDate: json['check_in_date'],
      checkOutDate: json['check_out_date'],
      cancelIds: json['cancel_ids'],
      checkinLat: json['checkin_lat'],
      checkinLon: json['checkin_lon'],
      checkinAddress: json['checkin_address'],
      score: json['score'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
      tasks: json['tasks'] != null
          ? (json['tasks'] as List).map((e) => Tasks.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'report_id': reportId,
      'report_content': reportContent,
      'report_status': reportStatus,
      'id': id,
      'user_id': userId,
      'employee_id': employeeId,
      'shift_date': shiftDate,
      'start_time': startTime,
      'end_time': endTime,
      'address': address,
      'lat': lat,
      'lon': lon,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'break_minutes': breakMinutes,
      'total_hours': totalHours,
      'position': position,
      'amount': amount,
      'status': status,
      'check_in_date': checkInDate,
      'check_out_date': checkOutDate,
      'cancel_ids': cancelIds,
      'checkin_lat': checkinLat,
      'checkin_lon': checkinLon,
      'checkin_address': checkinAddress,
      'score': score,
      'first_name': firstName,
      'last_name': lastName,
      'image': image,
      'tasks': tasks?.map((e) => e.toJson()).toList(),
    };
  }
}

class Tasks {
  int? id;
  int? shiftId;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? taskStatus;
  String? userReportContent;
  String? heading;
  String? content;
  int? userId;
  String? hours;

  Tasks({
    this.id,
    this.shiftId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.taskStatus,
    this.userReportContent,
    this.heading,
    this.content,
    this.userId,
    this.hours,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      id: json['id'],
      shiftId: json['shift_id'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      taskStatus: json['task_status'],
      userReportContent: json['user_report_content'],
      heading: json['heading'],
      content: json['content'],
      userId: json['user_id'],
      hours: json['hours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shift_id': shiftId,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'task_status': taskStatus,
      'user_report_content': userReportContent,
      'heading': heading,
      'content': content,
      'user_id': userId,
      'hours': hours,
    };
  }
}
