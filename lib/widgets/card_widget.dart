
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ChatCard extends StatefulWidget {


  const ChatCard({super.key});

  

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: InkWell(
        onTap: () {
         
        },
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text("UserName"),
          subtitle: Text("Last Message"),
          trailing: Text('12 pm'),
          
        ),
      ),
    );
  }
}
