import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chatRoomModel.dart';
import '../models/userModel.dart';
import '../widgets/card_widget.dart';
import '../widgets/searchTextField.dart';
import '../models/firebaseHelper.dart';

class ChatHome extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;

  const ChatHome({super.key, required this.userModel, this.firebaseUser});

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
        title: const Text('Chats',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              letterSpacing: 3,
              fontSize: 25,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: SearchTextField(
                userModel: widget.userModel!,
                firebaseUser: widget.firebaseUser!,
                text: 'Search messages',
                searchController: searchController),
          ),
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatrooms")
                    .where("participants.${widget.userModel?.uid}",
                        isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot chatRoomSnapshot =
                          snapshot.data as QuerySnapshot;

                      return ListView.builder(
                        itemCount: chatRoomSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                              chatRoomSnapshot.docs[index].data()
                                  as Map<String, dynamic>);

                          Map<String, dynamic> participants =
                              chatRoomModel.participants!;

                          List<String> participantKeys =
                              participants.keys.toList();
                          participantKeys.remove(widget.userModel?.uid);

                          return FutureBuilder(
                            future: FirebaseHelper.getUserModelById(
                                participantKeys[0]),
                            builder: (context, userData) {
                              if (userData.connectionState ==
                                  ConnectionState.done) {
                                if (userData.data != null) {
                                  UserModel targetUser = userData.data!;
                                  return ChatCard(
                                      userModel: widget.userModel!,
                                      chatRoomModel: chatRoomModel,
                                      firebaseUser: widget.firebaseUser!,
                                      targetUser: targetUser);
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const Center(
                        child: Text("No Chats"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

            // ListView.builder(
            //     physics: BouncingScrollPhysics(),
            //     itemCount: 2,
            //     itemBuilder: ((context, index) {
            //       return ChatCard();
            //     })),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber[400],
        child: const Icon(Icons.chat),
      ),
    );
  }
}
