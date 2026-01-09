import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/progress_bar.dart';
import '../../constants/icons_constant.dart';
import 'chat_detail_controller.dart';

class ChatDetailScreen extends StatefulWidget {
  final String senderId;
  final String userName;
  final String receiverId;
  final String receiverName;

  ChatDetailScreen({
    super.key,
    required this.senderId,
    required this.userName,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  ChatDetailController? _chatController;

  @override
  void initState() {
    super.initState();
    var chatController =
        Provider.of<ChatDetailController>(context, listen: false);
    chatController.userName = widget.userName;
    chatController.receiverId = widget.receiverId;
    chatController.initMethod(
        context: context, newReceiverId: widget.receiverId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 200), () {
        if (chatController.scrollController.hasClients) {
          chatController.scrollController.jumpTo(
            chatController.scrollController.position.maxScrollExtent,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _chatController?.timerValue?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatDetailController>(
      builder: (context, controller, child) {
        // ✅ Scroll to bottom when chat updates
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (controller.scrollController.hasClients &&
              controller.chatHistory.isNotEmpty) {
            controller.scrollController.jumpTo(
              controller.scrollController.position.maxScrollExtent,
            );
          }
        });

        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: Column(
              children: [
                _buildAppBar(controller, widget.receiverName),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.px),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.px),
                        topRight: Radius.circular(20.px),
                      ),
                    ),
                    child: controller.chatHistory.isEmpty
                        ? Center(
                            child: Text(
                              "No chats available\nPlease send a message to start chat",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: controller.scrollController,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            itemCount: controller.chatHistory.length,
                            itemBuilder: (context, index) {
                              final msg = controller.chatHistory[index];
                              final myId = int.tryParse(controller.senderId);
                              final isSentByMe = msg.chatSenderId == myId;

                              final messageText =
                                  msg.chatMessage?.trim().isNotEmpty == true
                                      ? msg.chatMessage!
                                      : "[No message]";

                              return Align(
                                alignment: isSentByMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSentByMe
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomLeft: isSentByMe
                                          ? Radius.circular(16)
                                          : Radius.circular(0),
                                      bottomRight: isSentByMe
                                          ? Radius.circular(0)
                                          : Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: isSentByMe
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messageText,
                                        style: TextStyle(
                                          color: isSentByMe
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        msg.chatCreatedAt != null
                                            ? DateFormat('hh:mm a').format(
                                                DateTime.tryParse(
                                                        msg.chatCreatedAt!) ??
                                                    DateTime.now(),
                                              )
                                            : "",
                                        style: TextStyle(
                                          color: isSentByMe
                                              ? Colors.white70
                                              : Colors.black45,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                _buildChatInput(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(ChatDetailController controller, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 120,
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.back,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 32.px,
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(IconConstants.icUserLogoPng),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("Online",
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
          Spacer(),
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildChatInput(ChatDetailController controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                hintText: "Start typing...",
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                fillColor: Colors.grey.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: controller.inMessageProcessing
                ? null
                : () async {
                    String text = controller.textController.text.trim();
                    if (text.isEmpty) return;

                    await controller.addMessage(context: context);
                  },
            child: controller.inMessageProcessing
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(Icons.send,
                    color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
