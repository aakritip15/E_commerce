import 'package:app_1/Screens/registration_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../models/uiHelper.dart';
import '../models/userModel.dart';
import 'login.dart';

class otpVerification extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String number;
  final String address;

  const otpVerification(
      {super.key,
      required this.email,
      required this.password,
      required this.name,
      required this.number,
      required this.address});

  @override
  State<otpVerification> createState() => _otpVerificationState();
}

class _otpVerificationState extends State<otpVerification> {
  @override
  final FirebaseAuth auth = FirebaseAuth.instance;
  void SignUp(String email, String password) async {
    UserCredential? credentials;
    // UIHelper.showLoadingDialog(context, 'Creating Account...');
    try {
      credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = credentials.user!.uid;
      UserModel userModel = UserModel(
        uid: uid,
        fullname: widget.name,
        email: widget.email,
        number: widget.number,
        address: widget.address,
        password: widget.password,
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

  var code = '';
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: const [],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/images/otp.jpg',
                height: 300,
              ),
              const Center(
                child: Text(
                  'Phone Verification',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Enter the OTP send to your mobile number',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 15),
              Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                length: 6,
                onChanged: (value) {
                  code = value;
                },
              ),
              const SizedBox(height: 17),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.amber),
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(350, 38),
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: RegisterPage.verify,
                              smsCode: code);
                      await auth.signInWithCredential(credential);

                      print('correct otp');
                      UIHelper.showLoadingDialog(
                          context, 'Creating Account...');
                      SignUp(widget.email, widget.password);
                    } catch (e) {
                      print('wrong otp');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Wrong OTP'),
                        ),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      'Verify',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive a code?',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Resend',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
