import 'package:app_1/Screens/account_setting.dart';
import 'package:app_1/consts/consts.dart';
import 'package:app_1/models/userModel.dart';
import 'package:flutter/material.dart';

import '../models/nav.dart';
import 'homepage.dart';

class Profile extends StatefulWidget {
  final UserModel user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    String letter = widget.user.fullname!;
    String l = letter[0];
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: NavBar(),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AccountSetting(user: widget.user)));
              },
              color: kBrown,
              icon: Icon(Icons.settings))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Text(
                    l,
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 60,
                        color: Colors.white),
                  ),
                  //child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
                ),
                SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    //Name
                    Text(
                      widget.user.fullname!,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Email:${widget.user.email!}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Address:${widget.user.address!}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    //Address
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
