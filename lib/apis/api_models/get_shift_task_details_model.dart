class GetShiftTasksDetailsModel {
  bool? success;
  List<TaskDetailData>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  GetShiftTasksDetailsModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  GetShiftTasksDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TaskDetailData>[];
      json['data'].forEach((v) {
        data!.add(TaskDetailData.fromJson(v));
      });
    }
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['success'] = success;
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    dataMap['message'] = message;
    dataMap['notification'] = notification;
    dataMap['error'] = error;
    dataMap['status'] = status;
    return dataMap;
  }
}

class TaskDetailData {
  int? id;
  int? taskId;
  String? taskPoint;
  String? status;
  String? dateTime;

  TaskDetailData({
    this.id,
    this.taskId,
    this.taskPoint,
    this.status,
    this.dateTime,
  });

  TaskDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['task_id'];
    taskPoint = json['task_point'];
    status = json['status'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'task_point': taskPoint,
      'status': status,
      'date_time': dateTime,
    };
  }
}
