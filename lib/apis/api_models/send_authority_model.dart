class SendMessageToAuthorityModel {
  final bool? success;
  final Data? data;
  final String? message;
  final String? notification;
  final String? error;
  final String? status;

  SendMessageToAuthorityModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory SendMessageToAuthorityModel.fromJson(Map<String, dynamic> json) {
    return SendMessageToAuthorityModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'] as String?,
      notification: json['notification']?.toString(),
      error: json['error']?.toString(),
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
      'notification': notification,
      'error': error,
      'status': status,
    };
  }
}

class Data {
  final int? id;
  final int? userId;
  final int? emailSenderId;
  final String? subject;
  final String? message;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.userId,
    this.emailSenderId,
    this.subject,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      emailSenderId: json['email_sender_id'] as int?,
      subject: json['subject'] as String?,
      message: json['message'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'email_sender_id': emailSenderId,
      'subject': subject,
      'message': message,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
