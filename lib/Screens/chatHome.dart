
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/card_widget.dart';
import '../widgets/searchTextField.dart';


class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {

    TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[400],
        title: Text('Chats',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              letterSpacing: 2,
              fontSize: 25,
            )),
        centerTitle: true,
        
      ),
     
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: SearchTextField(
                text: 'Search messages',
                searchController: searchController),
          ),
          Expanded(
          child:ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 2,
                itemBuilder: ((context, index) {
                  return ChatCard();
                })),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber[400],
        child: Icon(Icons.chat),
      ),
    );
  }
  }

