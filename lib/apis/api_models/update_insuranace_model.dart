class UpdateInsuranceDetailsModel {
  bool? success;
  List<dynamic>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  UpdateInsuranceDetailsModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  UpdateInsuranceDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? List<dynamic>.from(json['data']) : null;
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['success'] = success;
    if (data != null) {
      json['data'] = data;
    }
    json['message'] = message;
    json['notification'] = notification;
    json['error'] = error;
    json['status'] = status;
    return json;
  }
}
