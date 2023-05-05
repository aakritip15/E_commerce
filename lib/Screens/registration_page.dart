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
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

//TODO : Improve the Design
// TODO : Solve bottom Overflow bug. Occurance: while trying to give inputs in textFields

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String verify = '';
  static String verificationCode = '';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

bool obscure = true;
TextEditingController addressController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
//TODO: create TextEditingControllers for each fields
  @override
  Widget build(BuildContext context) {
    String latitude = '';
    String longitude = '';
    String address = '';
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController numberController = TextEditingController();

    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are denied forever');
      }
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });
      try {
        List<Placemark> placemark = await placemarkFromCoordinates(
            double.parse(latitude), double.parse(longitude));
        Placemark placeMarkFirstResult = placemark.first;
       
        setState(() { 
          addressController = TextEditingController(
              text: placeMarkFirstResult.street.toString());
        });
      } catch (e) {
        print(e.toString());
      }

      return position;
    }

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
        try {
          print("+977$phoneNumber");
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: "+977$phoneNumber",
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException e) {},
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
                          address: addressController.text.toString())));
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        } catch (e) {
          print('error');
        }
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
                        
                        TextField(
                          decoration: InputDecoration(
                            suffixIcon: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey),
                              ),
                              onPressed: () {
                                _determinePosition();
                              },
                              child: Text('Get current address'),
                            ),
                            hintText: 'Address',
                            labelText: 'Address',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          obscureText: false,
                          controller: addressController,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        
                        TextField(
                          decoration: InputDecoration(
                            suffixIcon: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                icon: Icon((obscure == true)
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            hintText: 'Password',
                            labelText: 'Password',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 10.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          obscureText: obscure,
                          controller: passwordController,
                          style: const TextStyle(fontSize: 12.0),
                        )
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
