import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../apis/api_models/get_all_users_list_model.dart';
import 'chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var chatController = Provider.of<ChatController>(context, listen: false);
      chatController.fetchAllUsers(context: context);
      chatController.fetchLastMessages(context: context);
      // chatController.startLastMessagesPolling(context);
    });
  }

  @override
  void dispose() {
    Provider.of<ChatController>(context, listen: false)
        .stopLastMessagesPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Column(
                children: [
                  Text(
                    StringConstants.chat,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 20.px),
                  ),
                  const SizedBox(height: 15),
                  TabBar(
                    indicator: BoxDecoration(
                      color: const Color(0xffE60001),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black54,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(
                        child: Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Users",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                // 🔍 Search Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: Color(0XFF595F67)),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Color(0XFF595F67)),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    children: [
                      // ------------------ Chats Tab ------------------
                      controller.lastMessages.isNotEmpty
                          ? ListView.builder(
                              itemCount: controller.lastMessages.length,
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, index) {
                                final chat = controller.lastMessages[index];
                                final name =
                                    "${chat.conversationFirstName ?? ''} ${chat.conversationLastName ?? ''}"
                                        .toLowerCase();

                                if (searchQuery.isNotEmpty &&
                                    !name.contains(searchQuery) &&
                                    !(chat.chatMessage ?? "")
                                        .toLowerCase()
                                        .contains(searchQuery)) {
                                  return const SizedBox();
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () {
                                        controller.clickOnListTile(
                                          context: context,
                                          user: UserData(),
                                          receiverName:
                                              "${chat.conversationFirstName ?? ""} ${chat.conversationLastName ?? ""}",
                                          receiverId: chat.conversationUserId
                                              .toString(),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 26,
                                              backgroundImage: NetworkImage(
                                                chat.conversationImage ??
                                                    "https://via.placeholder.com/150",
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${chat.conversationFirstName ?? ''} ${chat.conversationLastName ?? ''}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    chat.chatMessage ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  _formatTime(
                                                      chat.chatUpdatedAt),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                ),
                                                const Icon(Icons.done_all,
                                                    color: Colors.green),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text("No chats yet"),
                            ),

                      // ------------------ Users Tab ------------------
                      controller.allUsersList.isNotEmpty
                          ? ListView.builder(
                              itemCount: controller.allUsersList.length,
                              itemBuilder: (context, index) {
                                final user = controller.allUsersList[index];
                                final name =
                                    "${user.firstName ?? ''} ${user.lastName ?? ''}"
                                        .toLowerCase();

                                if (searchQuery.isNotEmpty &&
                                    !name.contains(searchQuery)) {
                                  return const SizedBox();
                                }

                                return InkWell(
                                  onTap: () {
                                    controller.clickOnListTile(
                                      context: context,
                                      user: user,
                                      receiverName:
                                          "${user.firstName ?? ''} ${user.lastName ?? ''}",
                                      receiverId: user.id.toString(),
                                    );
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        user.image ??
                                            "https://via.placeholder.com/150",
                                      ),
                                    ),
                                    title: Text(
                                      "${user.firstName ?? ''} ${user.lastName ?? ''}",
                                      style: const TextStyle(
                                          color: Colors.black87),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "No users found",
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.5),
                                    fontSize: 16.px,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "";
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat("hh:mm a").format(parsedDate);
    } catch (e) {
      return "";
    }
  }
}
