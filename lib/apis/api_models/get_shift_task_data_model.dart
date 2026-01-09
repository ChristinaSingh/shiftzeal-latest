class GetShiftTasksModel {
  bool? success;
  Data? data;
  String? message;
  String? status;

  GetShiftTasksModel({this.success, this.data, this.message, this.status});

  GetShiftTasksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}

class Data {
  int? shiftId;
  String? shiftName;
  String? shiftStart;
  String? shiftEnd;
  List<Tasks>? tasks;

  Data({this.shiftId, this.shiftName, this.shiftStart, this.shiftEnd, this.tasks});

  Data.fromJson(Map<String, dynamic> json) {
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    shiftStart = json['shift_start'];
    shiftEnd = json['shift_end'];
    if (json['tasks'] != null) {
      tasks = [];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['shift_id'] = shiftId;
    map['shift_name'] = shiftName;
    map['shift_start'] = shiftStart;
    map['shift_end'] = shiftEnd;
    if (tasks != null) {
      map['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Tasks {
  int? taskId;
  String? description;
  List<TaskDetails>? taskDetails;

  Tasks({this.taskId, this.description, this.taskDetails});

  Tasks.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    description = json['description'];
    if (json['task_details'] != null) {
      taskDetails = [];
      json['task_details'].forEach((v) {
        taskDetails!.add(TaskDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['task_id'] = taskId;
    map['description'] = description;
    if (taskDetails != null) {
      map['task_details'] = taskDetails!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TaskDetails {
  int? id;
  String? taskPoint;
  String? status;
  String? dateTime;

  TaskDetails({this.id, this.taskPoint, this.status, this.dateTime});

  TaskDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskPoint = json['task_point'];
    status = json['status'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['task_point'] = taskPoint;
    map['status'] = status;
    map['date_time'] = dateTime;
    return map;
  }
}
