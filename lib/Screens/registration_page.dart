// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names, unnecessary_null_comparison
import 'package:app_1/Screens/landing_page.dart';
import 'package:app_1/Screens/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/consts/consts.dart';
import '/consts/strings.dart';
import '/widgets/registrationHeader.dart';
import '/widgets/myTextField.dart';

//TODO : Improve the Design
// TODO : Solve bottom Overflow bug. Occurance: while trying to give inputs in textFields

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String verify = '';
  static String verificationCode = '';
//TODO: create TextEditingControllers for each fields

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void CheckValues(String? phoneNumber) async {
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
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+977$phoneNumber",
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            print(e.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            RegisterPage.verify = verificationId;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => otpVerification(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString(),
                    name: nameController.text.toString(),
                    number: numberController.text.toString(),
                    address: addressController.text.toString()),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (builder) => newPage(
        //           email: emailController.text.toString(),
        //           password: passwordController.text.toString(),
        //           name: nameController.text.toString(),
        //           number: numberController.text.toString(),
        //           address: addressController.text.toString()),
        //     ));
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
                        onPressed: () {
                          CheckValues(numberController.text.toString());
                        },
                        child: const Text(
                          'Continue',
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
