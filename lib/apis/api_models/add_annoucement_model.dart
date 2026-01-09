class AddAnnouncementModel {
  final bool success;
  final UploadData? data;
  final String message;
  final dynamic notification;
  final dynamic error;
  final String status;

  AddAnnouncementModel({
    required this.success,
    this.data,
    required this.message,
    this.notification,
    this.error,
    required this.status,
  });

  factory AddAnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AddAnnouncementModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? UploadData.fromJson(json['data']) : null,
      message: json['message'] ?? '',
      notification: json['notification'],
      error: json['error'],
      status: json['status'] ?? '',
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

class UploadData {
  final int id;
  final String userId;
  final String title;
  final String content;
  final String image;

  UploadData({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.image,
  });

  factory UploadData.fromJson(Map<String, dynamic> json) {
    return UploadData(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: json['image']?.toString().replaceAll('%22', '') ?? '', // Remove any stray %22
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'image': image,
    };
  }
}
