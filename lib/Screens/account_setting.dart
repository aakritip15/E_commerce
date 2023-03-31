// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '/authentication/authentication.dart';
import '/models/profile.dart';
import '/services/database_service.dart';
import '/Screens/login.dart';

class AccountSetting extends StatefulWidget {
  // final String email;
  AccountSetting({Key? key,}) : super(key: key);
  // AccountSetting({Key? key, required this.email}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  final Profile profileInfo = Profile('', '', '');
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   DatabaseService().getUser(email: widget.email).then((userInfo) {
  //     if (userInfo != null) {
  //       setState(() {
  //         profileInfo.name = userInfo['name'];
  //         profileInfo.email = widget.email;
  //         profileInfo.location = userInfo['address'];
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Account Setting',
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    children: [
                      ProfileView(profileInfo: profileInfo.name),
                      SizedBox(
                        height: 12,
                      ),
                      ProfileView(profileInfo: profileInfo.email),
                      ProfileView(profileInfo: profileInfo.location),
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
                        //Image need to be added
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
                leading: Icon(Icons.local_mall),
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
                    onPressed: ()async {
                      final result=await AuthService().SignOut();
                      if(result!.contains('success'))
                      {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => Login())));
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
        ));
  }
}

class ProfileView extends StatelessWidget {
  ProfileView({
    Key? key,
    required this.profileInfo,
  }) : super(key: key);

  String? profileInfo;

  @override
  Widget build(BuildContext context) {
    return Text('$profileInfo',
        style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic));
  }
}
