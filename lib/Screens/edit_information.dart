// ignore_for_file: prefer_const_constructors

import 'package:app_1/models/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
// =======
//               const Text(
//                 'Name',
//                 style: TextStyle(
//                   fontFamily: 'Times',
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Stack(
//                 alignment: Alignment.centerRight,
//                 children: [
//                   TextFormField(
//                     maxLines: 1,
//                     decoration: const InputDecoration(
//                         isDense: true,
//                         hintText: 'Username',
//                         filled: true,
//                         fillColor: Color(0xffD9D9D9),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                           gapPadding: 4.0,
//                         )),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.edit,
//                       //color: Colors.white12,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 10.0),
//               const Text(
//                 'Email',
//                 style: TextStyle(
//                   fontFamily: 'Times',
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Stack(
//                 alignment: Alignment.centerRight,
//                 children: [
//                   TextFormField(
//                     maxLines: 1,
//                     decoration: const InputDecoration(
//                         isDense: true,
//                         hintText: 'username@gmail.com',
//                         filled: true,
//                         fillColor: Color(0xffD9D9D9),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                           gapPadding: 4.0,
//                         )),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.edit,
//                       //color: Colors.white12,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 10.0),
//               const Text(
//                 'Phone',
//                 style: TextStyle(
//                   fontFamily: 'Times',
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Stack(
//                 alignment: Alignment.centerRight,
//                 children: [
//                   TextFormField(
//                     maxLines: 1,
//                     decoration: const InputDecoration(
//                         isDense: true,
//                         hintText: '+977-',
//                         filled: true,
//                         fillColor: Color(0xffD9D9D9),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                           gapPadding: 4.0,
//                         )),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.edit,
//                       //color: Colors.white12,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 10.0),
//               const Text(
//                 'Address',
//                 style: TextStyle(
//                   fontFamily: 'Times',
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Stack(
//                 alignment: Alignment.centerRight,
//                 children: [
//                   TextFormField(
//                     maxLines: 1,
//                     decoration: const InputDecoration(
//                         isDense: true,
//                         hintText: 'Address',
//                         filled: true,
//                         fillColor: Color(0xffD9D9D9),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                           gapPadding: 4.0,
//                         )),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.edit,
//                       //color: Colors.white12,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 30.0),
//               Center(
//                 child: OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                       side: BorderSide(
//                         color: Colors.black,
//                       ),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20))),
//                   onPressed: () {},
//                   child: const Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
//                     child: Text(
//                       'Change Now',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
// >>>>>>> 16acfb2f9af071af36342b9eeef1b6e8dae56bb4
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
