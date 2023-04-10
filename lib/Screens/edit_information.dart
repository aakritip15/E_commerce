// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/consts/colors.dart';
import '/widgets/customTextFormField.dart';
import '/widgets/myTextField.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({super.key});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void updateInformationinDatabase() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();
    //If any of the fields are empty, then return
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty) {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Information Updated!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all the fields!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kBrown,
            ),
          ),
          backgroundColor: kAlmond,
          foregroundColor: kBrown,
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
                        child: Icon(Icons.photo_camera_back_rounded),
                        radius: 60.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //TODO: Add functionality to Edit Button
                      },
                      child: Container(
                        width: 60,
                        height: 25,

                        // color: kBlue,
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(child: Text('Edit')),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text('Name'),
              textFieldEditInfo(
                  text: 'username', fieldController: nameController),
              SizedBox(height: 8.0),
              Text('Email:'),
              textFieldEditInfo(
                  text: 'username@gmail.com', fieldController: emailController),
              SizedBox(height: 8.0),
              Text('Phone'),
              textFieldEditInfo(
                  text: '+977-', fieldController: phoneController),
              SizedBox(height: 8.0),
              Text('Address:'),
              textFieldEditInfo(
                text: 'address',
                fieldController: addressController,
              ),
              SizedBox(height: 15.0),
              Text('Note:Login Email will not be changed'),
              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () {
                    updateInformationinDatabase();
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
