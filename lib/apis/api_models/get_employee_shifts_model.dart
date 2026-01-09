class SupervisorEmployeeShiftsModel {
  String? status;
  String? message;
  List<EmployeeShiftData>? data;

  SupervisorEmployeeShiftsModel({
    this.status,
    this.message,
    this.data,
  });

  factory SupervisorEmployeeShiftsModel.fromJson(Map<String, dynamic> json) {
    return SupervisorEmployeeShiftsModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? List<EmployeeShiftData>.from(
          json['data'].map((x) => EmployeeShiftData.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.map((x) => x.toJson()).toList(),
  };
}

class EmployeeShiftData {
  int? id;
  int? userId;
  String? name;
  int? employeeId;
  String? shiftDate;
  String? startTime;
  String? endTime;
  String? address;
  String? lat;
  String? lon;
  String? createdAt;
  String? updatedAt;
  String? breakMinutes;
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
  List<Task>? tasks;

  EmployeeShiftData({
    this.id,
    this.userId,
    this.name,
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
    this.tasks,
  });

  factory EmployeeShiftData.fromJson(Map<String, dynamic> json) {
    return EmployeeShiftData(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      employeeId: json['employee_id'],
      shiftDate: json['shift_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      address: json['address'],
      lat: json['lat'],
      lon: json['lon'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      breakMinutes: json['break_minutes']?.toString(),
      totalHours: json['total_hours']?.toString(),
      position: json['position'],
      amount: json['amount'],
      status: json['status'],
      checkInDate: json['check_in_date'],
      checkOutDate: json['check_out_date'],
      cancelIds: json['cancel_ids'],
      checkinLat: json['checkin_lat'],
      checkinLon: json['checkin_lon'],
      checkinAddress: json['checkin_address'],
      tasks: json['tasks'] != null
          ? List<Task>.from(json['tasks'].map((x) => Task.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'name': name,
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
    'tasks': tasks?.map((x) => x.toJson()).toList(),
  };
}

class Task {
  int? id;
  int? shiftId;
  String? heading;
  String? content;
  String? description;
  String? createdAt;
  String? taskStatus;
  String? updatedAt;

  Task({
    this.id,
    this.shiftId,
    this.heading,
    this.content,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.taskStatus
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      shiftId: json['shift_id'],
      heading: json['heading'],
      content: json['content'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      taskStatus:  json['task_status']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'shift_id': shiftId,
    'heading': heading,
    'content': content,
    'description': description,
    'created_at': createdAt,
    'updated_at': updatedAt,
    "task_status" : taskStatus
  };
}
