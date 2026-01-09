class UpdatedProfileModel {
  bool? success;
  String? data;
  String? message;
  String? notification;
  String? error;
  String? status;

  UpdatedProfileModel(
      {this.success,
        this.data,
        this.message,
        this.notification,
        this.error,
        this.status});

  UpdatedProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    data['notification'] = this.notification;
    data['error'] = this.error;
    data['status'] = this.status;
    return data;
  }
}
