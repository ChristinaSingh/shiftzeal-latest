class DeleteEmployeeModel {
  bool? success;
  List<dynamic>? data; // can hold any type, since not defined
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  DeleteEmployeeModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory DeleteEmployeeModel.fromJson(Map<String, dynamic> json) {
    return DeleteEmployeeModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? List<dynamic>.from(json['data']) : [],
      message: json['message'] as String?,
      notification: json['notification'],
      error: json['error'],
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'message': message,
      'notification': notification,
      'error': error,
      'status': status,
    };
  }
}
