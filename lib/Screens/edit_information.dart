// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:app_1/models/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/consts/colors.dart';
import '/widgets/customTextFormField.dart';
import '/widgets/myTextField.dart';
import 'package:image_picker/image_picker.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({super.key});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String imageUrl = "";

  void updateInformationinDatabase() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();
    //If any of the fields are empty, then return
    if (name.isNotEmpty && phone.isNotEmpty && address.isNotEmpty) {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': name,
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
    return Scaffold(
      appBar: APPBAR(context),
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
                ],
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            const Text(
              'Name',
              style: TextStyle(
                fontFamily: 'Times',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Username',
                      filled: true,
                      fillColor: Color(0xffD9D9D9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        gapPadding: 4.0,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit,
                    //color: Colors.white12,
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            const Text(
              'Phone',
              style: TextStyle(
                fontFamily: 'Times',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                      isDense: true,
                      hintText: '+977-',
                      filled: true,
                      fillColor: Color(0xffD9D9D9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        gapPadding: 4.0,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit,
                    //color: Colors.white12,
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            const Text(
              'Address',
              style: TextStyle(
                fontFamily: 'Times',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Address',
                      filled: true,
                      fillColor: Color(0xffD9D9D9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        gapPadding: 4.0,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit,
                    //color: Colors.white12,
                  ),
                )
              ],
            ),
            SizedBox(height: 30.0),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  updateInformationinDatabase();
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  child: Text(
                    'Change Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
