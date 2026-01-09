class GetUploadedDocumentModel {
  bool? success;
  List<DocumentData>? data;
  String? message;
  dynamic notification; // Changed from Null? to dynamic
  dynamic error;        // Changed from Null? to dynamic
  String? status;

  GetUploadedDocumentModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  GetUploadedDocumentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DocumentData>[];
      json['data'].forEach((v) {
        data!.add(DocumentData.fromJson(v));
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

class DocumentData {
  int? id;
  int? userId;
  String? document;
  String? createdAt;
  String? updatedAt;
  String? name;

  DocumentData({
    this.id,
    this.userId,
    this.document,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  DocumentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    document = json['document'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['user_id'] = userId;
    result['document'] = document;
    result['created_at'] = createdAt;
    result['updated_at'] = updatedAt;
    result['name'] = name;
    return result;
  }
}
