import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/messageTextField.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[400],
        title: Row(
          children: [
            CircleAvatar(child: Icon(Icons.camera_alt)),
            SizedBox(width: 15),
            Text('Full name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 23,
                )),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        Stack(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: Colors.white,
              ),
            ),
            messageTextField(
              text: 'Type messages here....',
              messageController: messageController,
            ),
          ],
        )
      ]),
    );
  }
}
