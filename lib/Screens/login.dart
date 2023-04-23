// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:app_1/Screens/housepage.dart';
import 'package:app_1/Screens/landing_page.dart';
import 'package:app_1/Screens/splashscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../models/uiHelper.dart';
import '../models/userModel.dart';
import '/Screens/account_setting.dart';
import '/Screens/homepage.dart';
import '/authentication/authentication.dart';
import '/consts/consts.dart';
import '/widgets/myTextField.dart';
import '/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginAttempt() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
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
                height: 250,
                width: 350,
                child: Expanded(
                  child: Image(
                    image: AssetImage("images/images/Login.png"),
                  ),
                ),
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
              const SizedBox(
                height: 30.0,
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
                height: 50,
              ),
              RichText(
                text: TextSpan(
                  text: "By signing up you will be accepting our ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                    const TextSpan(
                      text: '.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), //, This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
