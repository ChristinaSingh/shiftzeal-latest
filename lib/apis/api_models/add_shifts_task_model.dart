class AddShiftTasksModel {
  bool? success;
  Data? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  AddShiftTasksModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  AddShiftTasksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['message'] = message;
    map['notification'] = notification;
    map['error'] = error;
    map['status'] = status;
    return map;
  }
}

class Data {
  int? id;
  dynamic userId;
  String? heading;
  String? content;
  String? createdAt;
  String? updatedAt;
  int? shiftId;
  String? description;
  List<Details>? details;

  Data({
    this.id,
    this.userId,
    this.heading,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.shiftId,
    this.description,
    this.details,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    heading = json['heading'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shiftId = json['shift_id'];
    description = json['description'];
    if (json['details'] != null) {
      details = (json['details'] as List)
          .map((v) => Details.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['user_id'] = userId;
    map['heading'] = heading;
    map['content'] = content;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['shift_id'] = shiftId;
    map['description'] = description;
    if (details != null) {
      map['details'] = details!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Details {
  int? id;
  int? taskId;
  String? taskPoint;
  String? status;
  String? dateTime;

  Details({
    this.id,
    this.taskId,
    this.taskPoint,
    this.status,
    this.dateTime,
  });

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['task_id'];
    taskPoint = json['task_point'];
    status = json['status'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['task_id'] = taskId;
    map['task_point'] = taskPoint;
    map['status'] = status;
    map['date_time'] = dateTime;
    return map;
  }
}
