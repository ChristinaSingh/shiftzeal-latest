import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'group_chat_controller.dart';

class GroupChatDetailScreen extends StatelessWidget {
  final Map<String, dynamic> group;
  const GroupChatDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final controller = Provider.of<GroupListController>(context);

    // Mock Messages (Aap isse Controller se bhi handle kar sakte hain)
    List<Map<String, dynamic>> messages = [
      {
        "sender": "You",
        "text": "Team, please focus on Section B today.",
        "isMe": true,
        "time": "10:00 AM"
      },
      {
        "sender": "Amit Sharma",
        "text": "Okay sir, understood.",
        "isMe": false,
        "time": "10:05 AM"
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F2F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leadingWidth: 70.px,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              SizedBox(width: 8.px),
              const Icon(Icons.arrow_back_ios_new,
                  color: Colors.black, size: 20),
              SizedBox(width: 4.px),
              CircleAvatar(
                radius: 18.px,
                backgroundColor: primary.withOpacity(0.1),
                child: Icon(Icons.groups_rounded, color: primary, size: 20),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group['name'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.px,
                    fontWeight: FontWeight.bold)),
            Text("${group['memberCount']} Members online",
                style: TextStyle(color: Colors.green, fontSize: 11.px)),
          ],
        ),
      ),
      body: Column(
        children: [
          // --- Messages Area ---
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15.px),
              reverse: true, // Naye messages niche dikhane ke liye
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return _buildChatBubble(msg, primary);
              },
            ),
          ),

          // --- Input Area ---
          _buildInputSection(primary, controller, context),
        ],
      ),
    );
  }

  Widget _buildChatBubble(Map<String, dynamic> msg, Color primary) {
    bool isMe = msg['isMe'];
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.px),
        padding: EdgeInsets.symmetric(horizontal: 14.px, vertical: 10.px),
        constraints: BoxConstraints(maxWidth: 75.w),
        decoration: BoxDecoration(
          color: isMe ? primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.px),
            topRight: Radius.circular(15.px),
            bottomLeft: isMe ? Radius.circular(15.px) : Radius.circular(0),
            bottomRight: isMe ? Radius.circular(0) : Radius.circular(15.px),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: const Offset(0, 1))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Text(msg['sender'],
                  style: TextStyle(
                      fontSize: 11.px,
                      color: primary,
                      fontWeight: FontWeight.bold)),
            Text(msg['text'],
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black87,
                    fontSize: 14.px)),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(msg['time'],
                  style: TextStyle(
                      color: isMe ? Colors.white70 : Colors.grey,
                      fontSize: 10.px)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection(
      Color primary, GroupListController controller, BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.only(
          left: 10.px,
          right: 10.px,
          top: 10.px,
          bottom: 10.px,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(25.px),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: "Type a message...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.px),
            CircleAvatar(
              backgroundColor: primary,
              radius: 24.px,
              child: IconButton(
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                onPressed: () {
                  // send message logic
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
