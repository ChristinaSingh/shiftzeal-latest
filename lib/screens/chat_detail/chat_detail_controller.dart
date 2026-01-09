import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/chat_history_model.dart';
import '../../apis/api_models/send_message_response_model.dart' as send;
import '../../common/common_widgets.dart';

class ChatDetailController extends ChangeNotifier {
  TextEditingController textController = TextEditingController();
  String senderId = '';
  String userName = '';
  String receiverId = '';

  List<ChatData> chatHistory = [];
  bool inAsyncCall = false;
  bool inMessageProcessing = false;
  final ScrollController scrollController = ScrollController();
  Timer? timerValue;

  bool _isInitialized = false;
  bool _isFirstLoad = true;


  void scrollToBottom() {
    if (scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    }
  }
  /// Fetch chat history (server only)
  Future<void> fetchChatHistory(
      {required BuildContext context, bool showLoader = false}) async {
    if (showLoader) {
      inAsyncCall = true;
      notifyListeners();
    }

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";
    senderId = userId;

    final body = {
      ApiKeyConstants.sender_id: userId,
      ApiKeyConstants.receiverId: receiverId,
    };

    final response = await ApiMethods.getChatHistoryApi(
      context: context,
      bodyParams: body,
    );

    if (showLoader) {
      inAsyncCall = false;
      notifyListeners();
    }
    if (response == null) {
      CommonWidgets.showMyToastMessage("No response from server");
      return;
    }

    if (response.success == true && response.data != null) {
      // 🔹 Step 1: Local unsent messages preserve karo
      final localUnsent = chatHistory.where((m) =>
      (m.id ?? 0) < 0 || m.chatStatus == "SENDING" || m.chatStatus == "FAILED").toList();

      // 🔹 Step 2: Server messages overwrite karo
      chatHistory = response.data!;

      // 🔹 Step 3: Local unsent messages wapas add karo
      chatHistory.addAll(localUnsent);

      // 🔹 Step 4: Sort karo time ke basis par
      chatHistory.sort((a, b) {
        final dateA = DateTime.tryParse(a.chatCreatedAt ?? '') ?? DateTime.now();
        final dateB = DateTime.tryParse(b.chatCreatedAt ?? '') ?? DateTime.now();
        return dateA.compareTo(dateB);
      });

      notifyListeners();

      // 🔹 Step 5: Scroll maintain karo
      if (_isFirstLoad) {
        scrollToBottom();
        _isFirstLoad = false;
      } else {
        if (_isNearBottom()) {
          scrollToBottom();
        }
      }
    } else {

    }
  }


  /// Check if user is near bottom
  bool _isNearBottom() {
    if (!scrollController.hasClients) return true;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    const threshold = 100.0; // px (100px के अंदर है तो near bottom मानेंगे)
    return (maxScroll - currentScroll) <= threshold;
  }

  /// Send message
  Future<void> addMessage({required BuildContext context}) async {
    String messageText = textController.text.trim();
    if (messageText.isEmpty) return;

    // Step 1: Add local temp message
    final tempId = addLocalMessage(messageText);

    // Step 2: Clear input
    textController.clear();

    // Step 3: API call
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    final body = {
      ApiKeyConstants.sender_id: userId,
      ApiKeyConstants.receiverId: receiverId,
      ApiKeyConstants.chat_message: messageText,
    };

    final response =
        await ApiMethods.sendMessageApi(context: context, bodyParams: body);

    // Step 4: Handle response
    if (response != null && response.success == true && response.data != null) {
      _replaceTempMessage(tempId, response.data!);
    } else {
      _markMessageFailed(tempId);
      CommonWidgets.showMyToastMessage(
          response?.message ?? "Failed to send message");
    }
  }

  /// Add local temp message -> return tempId
  int addLocalMessage(String message) {
    final tempId = DateTime.now().millisecondsSinceEpoch * -1;

    final newMsg = ChatData(
      id: tempId,
      chatSenderId: int.tryParse(senderId) ?? 0,
      chatReceiverId: int.tryParse(receiverId) ?? 0,
      chatMessage: message,
      chatType: "TEXT",
      chatCreatedAt: DateTime.now().toIso8601String(),
      chatUpdatedAt: DateTime.now().toIso8601String(),
      chatStatus: "SENDING",
    );

    chatHistory.add(newMsg);
    notifyListeners();
    scrollToBottom();
    return tempId;
  }

  /// Replace temp message with server message
  void _replaceTempMessage(int tempId, send.ChatData serverMsg) {
    final index = chatHistory.indexWhere((m) => m.id == tempId);
    if (index != -1) {
      chatHistory[index] = ChatData(
        id: serverMsg.id,
        chatSenderId: serverMsg.chatSenderId,
        chatReceiverId: serverMsg.chatReceiverId,
        chatMessage: serverMsg.chatMessage,
        chatType: serverMsg.chatType,
        chatCreatedAt: serverMsg.chatCreatedAt,
        chatUpdatedAt: serverMsg.chatUpdatedAt,
        chatStatus: "SENT",
      );
      notifyListeners();
      scrollToBottom();
    }
  }


  void _markMessageFailed(int tempId) {
    final index = chatHistory.indexWhere((m) => m.id == tempId);
    if (index != -1) {
      chatHistory[index].chatStatus = "FAILED";
      notifyListeners();
    }
  }


  Future<void> initMethod({required BuildContext context, required String newReceiverId}) async {
    if (receiverId != newReceiverId) {
      _isInitialized = false;
      _isFirstLoad = true;
      receiverId = newReceiverId;
    }

    if (_isInitialized) return;

    _isInitialized = true;
    chatHistory.clear();
    notifyListeners();
    await fetchChatHistory(context: context, showLoader: true);
    timerValue?.cancel();
    timerValue = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await fetchChatHistory(context: context, showLoader: false);
    });
  }



  @override
  void dispose() {
    timerValue?.cancel();
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
