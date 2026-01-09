class VerifyOtpModel {
  bool? success;
  Data? data;
  String? message;
  String? notification;
  String? error;
  String? status;

  VerifyOtpModel(
      {this.success,
        this.data,
        this.message,
        this.notification,
        this.error,
        this.status});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['notification'] = this.notification;
    data['error'] = this.error;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? userId;

  Data({this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    return data;
  }
}
