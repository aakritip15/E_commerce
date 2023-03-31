// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '/Screens/account_setting.dart';
import '/Screens/homepage.dart';
import '/authentication/authentication.dart';
import '/consts/consts.dart';
import '/widgets/myTextField.dart';
import '/main.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
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
                        label: ''),

                    myTextField(
                        text: 'Password',
                        fieldController: passwordController,
                        label: ''),
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
                onPressed: () async {
                  // final result = await AuthService().SignIn(
                  //     emailText: emailController.text,
                  //     passwordText: passwordController.text);
                  // if (result!.contains('success')) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            // builder: ((context) => AccountSetting(email: emailController.text,))));
                            builder: ((context) => AccountSetting())));
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
