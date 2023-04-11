import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/chatRoom.dart';
import '../main.dart';
import '../models/chatRoomModel.dart';
import '../models/userModel.dart';

class SearchTextField extends StatefulWidget {
  final String? text;
  final TextEditingController searchController;
  final UserModel userModel;
  final User firebaseUser;

  const SearchTextField(
      {super.key,
      this.text,
      required this.searchController,
      required this.userModel,
      required this.firebaseUser});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${widget.userModel.uid}', isEqualTo: true)
        .where('participants.${targetUser.uid}', isEqualTo: true)
        .get();
    if (snapshot.docs.length > 0) {
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatRoom;
      print('Chatroom already created');
    } else {
      ChatRoomModel newChatroom =
          ChatRoomModel(chatRoomId: uuid.v1(), lastMessage: '', participants: {
        widget.userModel.uid.toString(): true,
        targetUser.uid.toString(): true,
      });
      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(newChatroom.chatRoomId)
          .set(newChatroom.toMap());
      print('New chatroom created');
      chatRoom = newChatroom;
    }
    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {});
              },
            ),
            hintText: widget.text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        if (widget.searchController.text
            .isNotEmpty) // Check if searchController text is not empty
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: widget.searchController.text)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                  if (dataSnapshot.docs.length > 0) {
                    Map<String, dynamic> userMap =
                        dataSnapshot.docs[0].data() as Map<String, dynamic>;
                    UserModel searchedUser = UserModel.fromMap(userMap);

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: Colors.white,
                          textColor: Colors.black,
                          title: Text(searchedUser.fullName!),
                          subtitle: Text(searchedUser.email!),
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () async {
                            ChatRoomModel? chatroomModel =
                                await getChatroomModel(searchedUser);
                            if (chatroomModel != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                            targetUser: searchedUser,
                                            chatRoom: chatroomModel,
                                            userModel: widget.userModel!,
                                            firebaseUser: widget.firebaseUser!,
                                          )));
                            }
                          }),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                      child: ListTile(title: Text('No results found')),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                    child: ListTile(title: Text('An error occurred')),
                  );
                } else {
                  return Container();
                }
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
      ],
    );
  }
}
