class SendMessageResponse {
  bool? success;
  ChatData? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  SendMessageResponse({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) => SendMessageResponse(
    success: json["success"],
    data: json["data"] != null ? ChatData.fromJson(json["data"]) : null,
    message: json["message"],
    notification: json["notification"],
    error: json["error"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "notification": notification,
    "error": error,
    "status": status,
  };
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

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
    id: json["id"],
    chatSenderId: json["chat_sender_id"],
    chatReceiverId: json["chat_receiver_id"],
    chatMessage: json["chat_message"],
    chatType: json["chat_type"],
    chatCreatedAt: json["chat_created_at"],
    chatUpdatedAt: json["chat_updated_at"],
    chatStatus: json["chat_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat_sender_id": chatSenderId,
    "chat_receiver_id": chatReceiverId,
    "chat_message": chatMessage,
    "chat_type": chatType,
    "chat_created_at": chatCreatedAt,
    "chat_updated_at": chatUpdatedAt,
    "chat_status": chatStatus,
  };
}
