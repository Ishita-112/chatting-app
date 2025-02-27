import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/chat_bubble.dart';
import 'package:myapp/components/my_textfield.dart';
import 'package:myapp/services/auth/auth_service.dart';
import 'package:myapp/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String recieverID;
  ChatPage({super.key, required this.recieverEmail, required this.recieverID});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(recieverID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(recieverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        ),
      body: Column(children: [Expanded(
        child: _buildMessageList()),

        _buildUserInput(),
        ]),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(recieverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;


    var alignment = isCurrentUser ? Alignment.centerRight: Alignment.centerLeft;



    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: 
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data["message"],
              isCurrentUser : isCurrentUser,

            )
          ],
        ),
        );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
      // Suggested code may be subject to a license. Learn more: ~LicenseLog:3037316198.
          Expanded(
            child: MyTextfield(
              controller: _messageController,
              hintText: "Type a Message...",
              obscureText: false,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
