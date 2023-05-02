import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/chatRoomModel.dart';
import '../models/messageModel.dart';
import '../models/userModel.dart';

class messageTextField extends StatefulWidget {
  final String? text;
  final TextEditingController messageController;
  final UserModel userModel;
  final ChatRoomModel chatRoom;

  const messageTextField(
      {super.key,
      this.text,
      required this.messageController,
      required this.userModel,
      required this.chatRoom});

  @override
  State<messageTextField> createState() => _messageTextFieldState();
}

class _messageTextFieldState extends State<messageTextField> {
  void sendMessage() async {
    String msg = widget.messageController.text.trim();
    MessageModel newMessage = MessageModel(
      messageId: uuid.v1(),
      sender: widget.userModel.uid,
      text: msg,
      createdOn: DateTime.now(),
      seen: false,
    );

    FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(widget.chatRoom.chatRoomId)
        .collection('messages')
        .doc(newMessage.messageId)
        .set(newMessage.toMap());
    widget.chatRoom.lastMessage = msg;
    FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(widget.chatRoom.chatRoomId)
        .set(widget.chatRoom.toMap());
  }

 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 32, 18, 18),
      child: TextField(
          controller: widget.messageController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            suffixIcon: IconButton(
              onPressed: () {},
              icon: IconButton(
                onPressed: () {
                  sendMessage();
                  widget.messageController.clear();
                  print('Message sent');
                },
                icon: const Icon(Icons.send),
                color: Colors.amber,
              ),
            ),
            hintText: widget.text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          )),
    );
  }
}
