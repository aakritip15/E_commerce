// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names, unnecessary_null_comparison

import 'package:app_1/Screens/landing_page.dart';
import 'package:app_1/models/uiHelper.dart';
import 'package:app_1/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/Screens/login.dart';
import '/consts/consts.dart';
import '/consts/strings.dart';
import '/widgets/registrationHeader.dart';
import '/widgets/myTextField.dart';

//TODO : Improve the Design
// TODO : Solve bottom Overflow bug. Occurance: while trying to give inputs in textFields

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final formGlobalKey = GlobalKey<FormState>();
//TODO: create TextEditingControllers for each fields
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void SignUp(String email, String password) async {
      UserCredential? credentials;
      if (formGlobalKey.currentState!.validate()) {
        UIHelper.showLoadingDialog(context, 'Creating Account...');
        try {
          credentials = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          String uid = credentials.user!.uid;
          UserModel userModel = UserModel(
            uid: uid,
            fullname: nameController.text,
            email: emailController.text,
            number: numberController.text,
            address: addressController.text,
            password: passwordController.text,
          );
          FirebaseFirestore.instance.collection('users').doc(uid).set(
                userModel.toMap(),
              );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account Created Successfully'),
            ),
          );
        } on Exception catch (e) {
          throw (e.toString());
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kYellow,
        elevation: 0,
        toolbarHeight: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyHeader(),
              Form(
                key: formGlobalKey,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Wrap(
                            runSpacing: 12.0,
                            children: [
                              //SEE: myTextField.dart
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Some Text';
                                  }
                                  return null;
                                },
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                          .hasMatch(value!)) {
                                    return 'Please Enter Valid mail';
                                  }
                                  return null;
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              TextFormField(
                                validator: (number) {
                                  if (number!.isEmpty ||
                                      !RegExp(r'^[0-9]+$').hasMatch(number!)) {
                                    return 'Please Enter Valid Number';
                                  }
                                  return null;
                                },
                                controller: numberController,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Some Text';
                                  }
                                  return null;
                                },
                                controller: addressController,
                                decoration: InputDecoration(
                                  hintText: 'Address',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              TextFormField(
                                validator: (password) {
                                  if (password == null ||
                                      password.length != 6) {
                                    return 'Please Enter Strong Password';
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                obscureText: true,
                                maxLength: 6,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 45.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                height: 40, width: 180),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kGreen,
                              ),
                              onPressed: () {
                                if (formGlobalKey.currentState!.validate()) {
                                  SignUp(emailController.text.trim(),
                                      passwordController.text.trim());
                                }
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: termsAndConditions,
                            style: const TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //TODO: Add navigation to terms and conditions page
                                  },
                              ),
                              const TextSpan(
                                text: '.',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0)
                      ],
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
