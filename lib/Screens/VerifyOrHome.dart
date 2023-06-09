import 'dart:async';

import 'package:app_1/Screens/homepage.dart';
import 'package:app_1/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/firebaseHelper.dart';
import '../models/userModel.dart';
//import 'package:main/Interfaces/allRoutes.dart';
//import 'package:main/Interfaces/home-page.dart';

class VerifyOrHome extends StatefulWidget {
  const VerifyOrHome({super.key});

  @override
  State<VerifyOrHome> createState() => _VerifyOrHomeState();
}

class _VerifyOrHomeState extends State<VerifyOrHome> {
  bool isEmailVerified = false;
  bool canResendEmail = true;
  Timer? timer;
  late UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    //call after email verification
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  void sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      userModel = await FirebaseHelper.getUserModelById(
          FirebaseAuth.instance.currentUser!.uid);
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => canResendEmail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Something went wrong. Please try after some time")),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? MyHomePage(user: userModel!)
      : Scaffold(
          appBar: AppBar(
            backgroundColor: kYellow,
            title: const Text("Verify your Email")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('images/images/emailverify.png')),
                  //Image.asset('images/images/emailverify.png'),
                  Text(
                    "A verification mail has been sent to your Email",
                    style: TextStyle(
                      fontSize: 20,
                      color: kBrown
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Wait for some time before pressing again",
                    style: TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 16, color: kBrown),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: 380,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kYellow,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        icon: const Icon(Icons.email),
                        label: const Text("Resent Email"),
                        onPressed:
                            canResendEmail ? sendVerificationEmail : () {}),
                  ),
                  
                  TextButton(
                      onPressed: () {FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 22,color: kBrown),
                      ))
                ],
              ),
            ),
          ),
        );
}
