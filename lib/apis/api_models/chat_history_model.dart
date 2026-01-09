class GetChatHistoryModel {
  bool? success;
  List<ChatData>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  GetChatHistoryModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory GetChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return GetChatHistoryModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((v) => ChatData.fromJson(v as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      notification: json['notification'],
      error: json['error'],
      status: json['status'] as String?,
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

class ChatData {
  int? id;
  int? chatSenderId;
  int? chatReceiverId;
  String? chatMessage;
  String? chatType;
  String? chatCreatedAt;
  String? chatUpdatedAt;
  String? chatStatus;

  ChatData({
    this.id,
    this.chatSenderId,
    this.chatReceiverId,
    this.chatMessage,
    this.chatType,
    this.chatCreatedAt,
    this.chatUpdatedAt,
    this.chatStatus,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      id: json['id'] as int?,
      chatSenderId: json['chat_sender_id'] as int?,
      chatReceiverId: json['chat_receiver_id'] as int?,
      chatMessage: json['chat_message'] as String?,
      chatType: json['chat_type'] as String?,
      chatCreatedAt: json['chat_created_at'] as String?,
      chatUpdatedAt: json['chat_updated_at'] as String?,
      chatStatus: json['chat_status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_sender_id': chatSenderId,
      'chat_receiver_id': chatReceiverId,
      'chat_message': chatMessage,
      'chat_type': chatType,
      'chat_created_at': chatCreatedAt,
      'chat_updated_at': chatUpdatedAt,
      'chat_status': chatStatus,
    };
  }
}
