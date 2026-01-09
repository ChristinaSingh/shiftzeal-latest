class UploadUserDocumentModel {
  bool? success;
  Data? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  UploadUserDocumentModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  UploadUserDocumentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['success'] = success;
    if (data != null) {
      json['data'] = data!.toJson();
    }
    json['message'] = message;
    json['notification'] = notification;
    json['error'] = error;
    json['status'] = status;
    return json;
  }
}

class Data {
  int? id;
  String? name;
  String? document;

  Data({this.id, this.name, this.document});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['document'] = document;
    return json;
  }
}
