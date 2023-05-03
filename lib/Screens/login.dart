// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:app_1/Screens/landing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../models/uiHelper.dart';
import '../models/userModel.dart';
import '/Screens/homepage.dart';
import '/consts/consts.dart';
import '/widgets/myTextField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ResetemailController = TextEditingController();
  IconData visibility_off = EvaIcons.eyeOffOutline;
  //Update with actual Terms and Condition;
  String TandC =
      "A Terms and Conditions agreement acts as a legal contract between you (the company) and the user. Its where you maintain your rights to exclude users from your app in the event that they abuse your website/app, set out the rules for using your service and note other important details and disclaimers.Having a Terms and Conditions agreement is completely optional. No laws require you to have one. Not even the super-strict and wide-reaching General Data Protection Regulation (GDPR).Your Terms and Conditions agreement will be uniquely yours. While some clauses are standard and commonly seen in pretty much every Terms and Conditions agreement, it's up to you to set the rules and guidelines that the user must agree to.Terms and Conditions agreements are also known as Terms of Service or Terms of Use agreements. These terms are interchangeable, practically speaking.";

  void forgotPassWord() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Forgot Password"),
          content: Container(
            height: 90,
            child: Column(
              children: [
                Text("Email:"),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                        controller: ResetemailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ))),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (ResetemailController.text.trim().isNotEmpty) {
                  Navigator.pop(context);
                  FirebaseAuth.instance.sendPasswordResetEmail(
                      email: ResetemailController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Reset Password Email Sent!"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Enter Email!"),
                    ),
                  );
                }
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void loginAttempt() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      // Close the loading dialog
      print(ex.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Credentials"),
        ),
      );
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      UIHelper.showLoadingDialog(context, "Logging In..");

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);

      // Go to HomePage
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Log In Successful!"),
        ),
      );
      //
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          /* return AccountSetting(
            user: userModel,
          );*/
          return MyHomePage(user: userModel);
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 45,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                image: AssetImage(appIcon),
                height: 100,
              ),
              const Text(
                'Welcome back User!!!',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: kBrown,
                ),
              ),
              SizedBox(
                height: 300,
                width: 350,
                child: Image(image: AssetImage("images/images/Login.png")),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Wrap(
                  runSpacing: 12.0,
                  children: [
                    //SEE: myTextField.dart
                    myTextField(
                        text: 'Email',
                        fieldController: emailController,
                        label: 'Email',
                        obscure: false),

                    myTextField(
                        text: 'Password',
                        fieldController: passwordController,
                        label: 'Password',
                        obscure: true),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  forgotPassWord();
                },
                child: Text('Forgot Password?'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                ),
                onPressed: () {
                  loginAttempt();
                  // final result = await AuthService().SignIn(
                  //     emailText: emailController.text,
                  //     passwordText: passwordController.text);
                  // if (result!.contains('success')) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: ((context) => AccountSetting(
                  //             email: emailController.text,
                  //           )),
                  //     ),
                  //   );
                  // }
                  // else{
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('Invalid Email or Password'),
                  //     ),
                  //   );
                  // }
                },
                child: const Padding(
                  padding: EdgeInsets.only(
                      top: 16.0, bottom: 16.0, right: 30.0, left: 30.0),
                  child: Text('Login'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "By signing up you will be accepting our ",
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Terms and Conditions',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return (Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'Terms and Conditions',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Expanded(
                                            child: Text(
                                              TandC,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ));
                                },
                              );
                            }),
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
        ),
      ), //, This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
