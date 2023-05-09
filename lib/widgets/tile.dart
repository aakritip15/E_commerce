// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

//import 'dart:html';

import 'package:app_1/Screens/chatRoom.dart';
import 'package:app_1/Screens/homepage.dart';
import 'package:app_1/Screens/itemview.dart';
import 'package:app_1/models/ProductDetails.dart';
import 'package:app_1/models/firebaseHelper.dart';
import 'package:app_1/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_1/Screens/profile.dart';
import '../main.dart';
import '../models/chatRoomModel.dart';

//TODO:Provide Context as to use Navigation

//Tile that is Shown in The Homepage
//Takes in instance of Prdouct Details as an argument
//Navigates to Product Details Page
Tile(context, {required Products product, required user}) {
  String NAME = product.ProductName!;
  String PRICE = product.ProductPrice!;
  String DESCRIPTION = product.ProductDescription!.length > 20
      ? '${product.ProductDescription!.substring(0, 20)}...'
      : product.ProductDescription!;
  String? IMAGE = product.ProductImage;
  // ignore: unused_local_variable
  String? sellerName =
      product.ProductSellerName; //! Use this Name in card to show seller name
  return Padding(
    padding: EdgeInsets.all(7),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemView(product: product)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 249, 254, 249),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 178, 178, 178),
                blurRadius: 3,
                offset: Offset(0, 7),
              ),
            ]),
        height: 196,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Image
            SizedBox(
              height: 155,
              width: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.network(
                  IMAGE!,
                  scale: 1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //Information
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    child: Text(
                      NAME,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 4, 9, 35),
                      ),
                    ),
                  ),
                ),

                //Description
                SizedBox(
                  height: 60,
                  width: 150,
                  child: Text(
                    DESCRIPTION,
                  ),
                ),
                //Price
                Text(
                  'Nrs.$PRICE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Call Buttons
                product.ProductSellerID != FirebaseAuth.instance.currentUser!.uid ?  Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      maxRadius: 15,
                      child: IconButton(
                        onPressed: () async {
                          ChatRoomModel? chatRoom;
                          User you = FirebaseAuth.instance.currentUser!;
                          final chatroomQuery = await FirebaseFirestore.instance
                              .collection('chatrooms')
                              .where('participants.${product.ProductSellerID!}',
                                  isEqualTo: true)
                              .where('participants.${you.uid}', isEqualTo: true)
                              .get();
                          if (chatroomQuery.docs.isEmpty) {
                            ChatRoomModel newChatroom = ChatRoomModel(
                              chatRoomId: uuid.v1(),
                              lastMessage: "",
                              participants: {
                                you.uid.toString(): true,
                                product.ProductSellerID!: true,
                              },
                            );
                            await FirebaseFirestore.instance
                                .collection("chatrooms")
                                .doc(newChatroom.chatRoomId)
                                .set(newChatroom.toMap());
                            chatRoom = newChatroom;
                          } else {
                            chatRoom = ChatRoomModel.fromMap(
                                chatroomQuery.docs.first.data());
                          }
                          //firebaseUser as required fromChatRoom.dart
                          //seller Information as required fromChatRoom.dart
                          UserModel? userModel =
                              await FirebaseHelper.getUserModelById(uid!);
                          UserModel? sellerModel =
                              await FirebaseHelper.getUserModelById(
                                  product.ProductSellerID!);
                          print(userModel!.fullname);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatPage(
                              targetUser: sellerModel!,
                              chatRoom: chatRoom!,
                              userModel: userModel,
                              firebaseUser: you,
                            );
                          }));
                        },
                        icon: Icon(
                          EvaIcons.messageCircle,
                          size: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      maxRadius: 15,
                      child: IconButton(
                        onPressed: () {
                          print('FAVOURITE');
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                )
                 : ElevatedButton(onPressed: (){
                  DeleteOrder(context, product);
                    Navigator.pushReplacement(context, MaterialPageRoute(
               builder: (context) => Profile(user: user)));

                 }, child: Text('Delete')),
               
              ],
            )
          ],
        ),
      ),
    ),
  );

  
}

 void DeleteOrder(BuildContext context, @required Product) async {
    FirebaseFirestore.instance
        .collection('Products')
        .doc(Product.ProductID)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Product Deleted"),
      ),
    );
   
  }
