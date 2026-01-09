class GetLastMessagesListModel {
  bool? success;
  List<LastMessageData>? data;
  String? message;
  String? notification;
  String? error;
  String? status;

  GetLastMessagesListModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory GetLastMessagesListModel.fromJson(Map<String, dynamic> json) {
    return GetLastMessagesListModel(
      success: json['success'],
      data: json['data'] != null
          ? List<LastMessageData>.from(
          json['data'].map((x) => LastMessageData.fromJson(x)))
          : null,
      message: json['message'],
      notification: json['notification'],
      error: json['error'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
      'message': message,
      'notification': notification,
      'error': error,
      'status': status,
    };
  }
}

class LastMessageData {
  int? id;
  int? chatSenderId;
  int? chatReceiverId;
  String? chatMessage;
  String? chatType;
  String? chatCreatedAt;
  String? chatUpdatedAt;
  String? senderFirstName;
  String? senderLastName;
  String? senderImage;
  String? receiverFirstName;
  String? receiverLastName;
  String? receiverImage;
  String? timeAgo;
  int? conversationUserId;
  String? conversationFirstName;
  String? conversationLastName;
  String? conversationImage;

  LastMessageData({
    this.id,
    this.chatSenderId,
    this.chatReceiverId,
    this.chatMessage,
    this.chatType,
    this.chatCreatedAt,
    this.chatUpdatedAt,
    this.senderFirstName,
    this.senderLastName,
    this.senderImage,
    this.receiverFirstName,
    this.receiverLastName,
    this.receiverImage,
    this.timeAgo,
    this.conversationUserId,
    this.conversationFirstName,
    this.conversationLastName,
    this.conversationImage,
  });

  factory LastMessageData.fromJson(Map<String, dynamic> json) {
    return LastMessageData(
      id: json['id'],
      chatSenderId: json['chat_sender_id'],
      chatReceiverId: json['chat_receiver_id'],
      chatMessage: json['chat_message'],
      chatType: json['chat_type'],
      chatCreatedAt: json['chat_created_at'],
      chatUpdatedAt: json['chat_updated_at'],
      senderFirstName: json['sender_first_name'],
      senderLastName: json['sender_last_name'],
      senderImage: json['sender_image'],
      receiverFirstName: json['receiver_first_name'],
      receiverLastName: json['receiver_last_name'],
      receiverImage: json['receiver_image'],
      timeAgo: json['time_ago'],
      conversationUserId: json['conversation_user_id'],
      conversationFirstName: json['conversation_first_name'],
      conversationLastName: json['conversation_last_name'],
      conversationImage: json['conversation_image'],
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
      'sender_first_name': senderFirstName,
      'sender_last_name': senderLastName,
      'sender_image': senderImage,
      'receiver_first_name': receiverFirstName,
      'receiver_last_name': receiverLastName,
      'receiver_image': receiverImage,
      'time_ago': timeAgo,
      'conversation_user_id': conversationUserId,
      'conversation_first_name': conversationFirstName,
      'conversation_last_name': conversationLastName,
      'conversation_image': conversationImage,
    };
  }
}
