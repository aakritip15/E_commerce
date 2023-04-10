// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously, prefer_const_constructors_in_immutables, unused_element, prefer_const_literals_to_create_immutables, prefer_final_fields, non_constant_identifier_names

import 'package:app_1/Screens/Orders.dart';
import 'package:app_1/Screens/edit_information.dart';
import 'package:app_1/Screens/homepage.dart';
import 'package:app_1/models/nav.dart';
import 'package:app_1/models/uiHelper.dart';
import 'package:app_1/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/authentication/authentication.dart';
import '/models/profile.dart';
import '/services/database_service.dart';
import '/Screens/login.dart';

class AccountSetting extends StatefulWidget {
  final UserModel user;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  AccountSetting({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _CnewPassword = TextEditingController();

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text("Are you sure you want to delete your account?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () async {
                print(widget.uid);
                UIHelper.showLoadingDialog(context, 'Deleting Account...');
                await Future.delayed(
                  Duration(seconds: 1),
                );
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.uid)
                    .delete();
                FirebaseAuth.instance.currentUser!.delete();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account Deleted Successfully"),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  changePassword() async {
    if (_newPassword.text.isNotEmpty) {
      if (_oldPassword.text == widget.user.password) {
        if (_newPassword.text == _CnewPassword.text) {
          FirebaseAuth.instance.currentUser!.updatePassword(_newPassword.text);
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update(
            {
              'password': _newPassword.text,
            },
          );
          Navigator.pop(context);
          UIHelper.showLoadingDialog(context, 'Changing Password...');
          await Future.delayed(Duration(seconds: 1));
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password Changed Successfully"),
            ),
          );
        } else {
          UIHelper.showAlertDialog(
              context, "An error occured", "Passwords do not match");
        }
      } else {
        UIHelper.showAlertDialog(
            context, "An error occured", "Old password is incorrect");
      }
    } else {
      UIHelper.showAlertDialog(
          context, "An error occured", "Cannot place empty password");
    }
  }

  void _displayPasswordChangeDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Password'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _oldPassword,
                  decoration: InputDecoration(
                    hintText: 'Enter Old Password',
                  ),
                ),
                TextField(
                  controller: _newPassword,
                  decoration: InputDecoration(
                    hintText: 'Enter New Password',
                  ),
                ),
                TextField(
                  controller: _CnewPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm New Password',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  changePassword();
                },
                child: Text('Change'),
              ),
            ],
          );
        });
  }

  // AccountSetting({Key? key, required this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: NavBar(),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Account Setting',
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.brown),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child:
                          Icon(Icons.camera_alt, size: 30, color: Colors.white),
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
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(14),
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[300],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                              'Help sustainable development of environment by selling your item to your community')),
                      SizedBox(width: 15),
                      Column(
                        children: [
                          // Image need to be added
                          // Image(
                          //   image: AssetImage(
                          //     'images/images/sell_item.png',
                          //   ),
                          //   height: 27,
                          //   width: 56,
                          // ),
                          Container(
                            height: 35,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(9)),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Sell your item',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditInfo()));
                  },
                  leading: Icon(Icons.edit),
                  title: Text(
                    'Edit Information',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_sharp),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  onTap: () {
                    _displayPasswordChangeDialog();
                  },
                  leading: Icon(Icons.password_outlined),
                  title: Text(
                    'Change password',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_sharp),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Orders()));
                  },
                  leading: Icon(Icons.shopping_bag_outlined),
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_sharp),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(Icons.store),
                  title: Text(
                    'My items',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_sharp),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  onTap: () {
                    _deleteAccount();
                  },
                  leading: Icon(Icons.delete),
                  title: Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_sharp),
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 40,
                    width: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    child: TextButton.icon(
                      onPressed: () async {
                        final result = await AuthService().SignOut();
                        if (result!.contains('success')) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => Login()),
                            ),
                          );
                        }
                      },
                      label: Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
