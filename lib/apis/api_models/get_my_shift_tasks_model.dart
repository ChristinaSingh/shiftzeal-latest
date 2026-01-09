class GetShiftTasksModel {
  bool? success;
  List<ShiftTaskData>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  GetShiftTasksModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  GetShiftTasksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ShiftTaskData>[];
      json['data'].forEach((v) {
        data!.add(ShiftTaskData.fromJson(v));
      });
    }
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['success'] = success;
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    result['message'] = message;
    result['notification'] = notification;
    result['error'] = error;
    result['status'] = status;
    return result;
  }
}

class ShiftTaskData {
  int? id;
  int? userId;
  String? heading;
  String? content;
  String? createdAt;
  String? description;
  String? updatedAt;
  int? shiftId;

  ShiftTaskData({
    this.id,
    this.userId,
    this.heading,
    this.content,
    this.createdAt,
    this.description,
    this.updatedAt,
    this.shiftId,
  });

  ShiftTaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    heading = json['heading'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shiftId = json['shift_id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['user_id'] = userId;
    result['heading'] = heading;
    result['content'] = content;
    result['created_at'] = createdAt;
    result['updated_at'] = updatedAt;
    result['shift_id'] = shiftId;
    result['description'] = description;
    return result;
  }
}
