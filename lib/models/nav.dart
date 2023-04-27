// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_1/Screens/chatHome.dart';
import 'package:app_1/Screens/sell_item.dart';
import 'package:app_1/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screens/donation.dart';
import 'firebaseHelper.dart';

class NavBar extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = FirebaseAuth.instance.currentUser!.uid;

  NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 197, 197, 197),
              blurRadius: 3,
              offset: Offset(
                0,
                5,
              ),
            )
          ],
          color: Color.fromRGBO(245, 248, 254, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.format_list_bulleted_add),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add_box_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SellItem(
                            firebaseUser: currentUser,
                          )),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.message_outlined),
              onPressed: () async {
                UserModel? userModel =
                    await FirebaseHelper.getUserModelById(currentUser!.uid);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatHome(
                              userModel: userModel,
                              firebaseUser: currentUser,
                            )));
              },
            ),
            IconButton(
              icon: const Icon(Icons.clean_hands_rounded),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Donation(firebaseUser: currentUser,))));
             
              },
            ),
          ],
        ));
  }
}
