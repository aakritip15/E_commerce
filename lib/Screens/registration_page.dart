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
  const RegisterPage({Key? key}) : super(key: key);
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

    void CheckValues() {
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          numberController.text.isEmpty ||
          addressController.text.isEmpty ||
          passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all the fields'),
          ),
        );
      } else {
        SignUp(emailController.text.trim(), passwordController.text.trim());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kYellow,
        elevation: 0,
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
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Wrap(
                      runSpacing: 15.0,
                      children: [
                        //SEE: myTextField.dart
                        myTextField(
                          text: 'Name',
                          label: 'Name',
                          fieldController: nameController,
                          obscure: false,
                        ),
                        myTextField(
                          text: 'Email',
                          label: 'Email',
                          fieldController: emailController,
                          obscure: false,
                        ),
                        myTextField(
                            text: 'Phone Number',
                            label: 'Phone Number',
                            fieldController: numberController,
                            obscure: false),
                        myTextField(
                            text: 'Address',
                            label: 'Address',
                            fieldController: addressController,
                            obscure: false),
                        myTextField(
                            text: 'Password',
                            obscure: true,
                            label: 'Password',
                            fieldController: passwordController),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(height: 40, width: 180),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kGreen,
                        ),
                        onPressed: () async {
                          CheckValues();
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
                  Center(
                    child: RichText(
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
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
