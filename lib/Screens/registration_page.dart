import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/Screens/login.dart';
import '/authentication/authentication.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
                  fontStyle: FontStyle.italic,
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
                        ),
                        myTextField(
                            text: 'Email',
                            label: 'Email',
                            fieldController: emailController),
                        myTextField(
                            text: 'Phone Number',
                            label: 'Phone Number',
                            fieldController: numberController),
                        myTextField(
                            text: 'Address',
                            label: 'Address',
                            fieldController: addressController),
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
                          backgroundColor: kBlue,
                        ),
                        onPressed: () {
                          //TODO : Add Functionalities
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
                  const SizedBox(
                    height: 20.0,
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
                          //TODO : Add Functionalities
                          final result = await AuthService().CreateAccount(
                              name: nameController.text,
                              emailText: emailController.text,
                              numberText: numberController.text,
                              addressText: addressController.text,
                              passwordText: passwordController.text);
                          if (result!.contains('success')) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => Login()),
                              ),
                            );
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
                  Align(
                    alignment: Alignment.bottomCenter,
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
