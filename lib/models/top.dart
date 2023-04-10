// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names

import 'package:app_1/Screens/account_setting.dart';
import 'package:app_1/models/firebaseHelper.dart';
import 'package:app_1/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

Row TOP(BuildContext context) {
  String NAME = 'Shashinoor';
  String INFORMATION = 'Active';
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Logo',
        style: TextStyle(color: Colors.black),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: Colors.brown,
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NAME,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  Text(
                    INFORMATION,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              ),
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
                    builder: (context) => AccountSetting(
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
