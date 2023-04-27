// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names

import 'package:app_1/Screens/profile.dart';
import 'package:app_1/models/firebaseHelper.dart';
import 'package:app_1/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

Row TOP(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image(
        image: AssetImage('images/images/logo.png'),
        height: 45,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: Colors.brown,
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
            IconButton(
              icon: Icon(
                FeatherIcons.user,
                color: Colors.brown,
              ),
              onPressed: () async {
                User? currentUser = FirebaseAuth.instance.currentUser;
                UserModel? thisUser =
                    await FirebaseHelper.getUserModelById(currentUser!.uid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(
                      user: thisUser!,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      )
    ],
  );
}
