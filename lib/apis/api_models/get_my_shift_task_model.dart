class GetMyShiftTaskModel {
  bool? success;
  List<ShiftTaskData>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  GetMyShiftTaskModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory GetMyShiftTaskModel.fromJson(Map<String, dynamic> json) {
    return GetMyShiftTaskModel(
      success: json['success'],
      data: json['data'] != null
          ? List<ShiftTaskData>.from(json['data'].map((v) => ShiftTaskData.fromJson(v)))
          : null,
      message: json['message'],
      notification: json['notification'],
      error: json['error'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((v) => v.toJson()).toList(),
      'message': message,
      'notification': notification,
      'error': error,
      'status': status,
    };
  }
}

class ShiftTaskData {
  int? id;
  int? userId;
  String? heading;
  String? content;
  String? createdAt;
  String? updatedAt;
  int? shiftId;

  ShiftTaskData({
    this.id,
    this.userId,
    this.heading,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.shiftId,
  });

  factory ShiftTaskData.fromJson(Map<String, dynamic> json) {
    return ShiftTaskData(
      id: json['id'],
      userId: json['user_id'],
      heading: json['heading'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      shiftId: json['shift_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'heading': heading,
      'content': content,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'shift_id': shiftId,
    };
  }
}
