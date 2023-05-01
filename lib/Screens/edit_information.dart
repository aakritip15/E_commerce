// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:app_1/Screens/account_setting.dart';
import 'package:app_1/models/firebaseHelper.dart';
import 'package:app_1/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/consts/colors.dart';
import '/widgets/myTextField.dart';

class EditInfo extends StatefulWidget {
  final UserModel user;
  const EditInfo({super.key, required this.user});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void updateInformationinDatabase() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();

    if (name.isEmpty) {
      name = widget.user.fullname!;
    }
    if (email.isEmpty) {
      email = widget.user.email!;
    }
    if (phone.isEmpty) {
      phone = widget.user.number!;
    }
    if (address.isEmpty) {
      address = widget.user.address!;
    }

    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'fullname': name,
      'email': email,
      'phone': phone,
      'address': address,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Information Updated!"),
      ),
    );
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      widget.user.fullname = value['fullname'];
      widget.user.email = value['email'];
      widget.user.number = value['phone'];
      widget.user.address = value['address'];
    });
    setState(() {});
    String uid1 = FirebaseAuth.instance.currentUser!.uid;
    UserModel? newInfo = await FirebaseHelper.getUserModelById(uid1);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AccountSetting(
          user: newInfo!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Information',
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.transparent,
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
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: kBrown,
                        radius: 60.0,
                        child: Icon(Icons.photo_camera_back_rounded),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //TODO: Add functionality to Edit Button
                      },
                      child: Container(
                        width: 70,
                        height: 27,

                        // color: kBlue,
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                            child: Text(
                          'Edit',
                          style: TextStyle(
                            fontFamily: 'Times',
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              Text('Name'),
              textFieldEditInfo(
                text: 'username',
                fieldController: nameController,
                inActive: false,
              ),
              SizedBox(height: 8.0),
              Text('Email:'),
              textFieldEditInfo(
                text: widget.user.email!,
                fieldController: emailController,
                inActive: true,
              ),
              SizedBox(height: 8.0),
              Text('Phone'),
              textFieldEditInfo(
                  text: '+977-',
                  fieldController: phoneController,
                  inActive: false),
              SizedBox(height: 8.0),
              Text('Address:'),
              textFieldEditInfo(
                text: 'address',
                fieldController: addressController,
                inActive: false,
              ),
              SizedBox(height: 15.0),
              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () {
                    updateInformationinDatabase();
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 15.0),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
