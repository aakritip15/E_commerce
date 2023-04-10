// ignore_for_file: prefer_const_constructors

import 'package:app_1/Screens/login.dart';
import 'package:app_1/Screens/registration_page.dart';
import 'package:flutter/material.dart';
import '/consts/consts.dart';
import '/consts/strings.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            // alignment: AlignmentDirectional.bottomStart,
            clipBehavior: Clip.antiAlias,
            children: const [
              Image(image: AssetImage(gettingStarted)),
              Positioned(
                bottom: 0,
                left: 10,
                child: Image(
                  image: AssetImage(appIcon),
                ),
              ),
            ],
          ),

          // const FractionallySizedBox(
          //   heightFactor: 0.01,
          //   child: SizedBox(height: 24.0,),
          // ),
          const Text(
            'Welcome to ReSell-It',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
// Flexible add responsiveness to its child
          const Flexible(
            child: Text(
              textAlign: TextAlign.center,
              landingPageNote,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),

          Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              width: 150.0,
              height: 40.0,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kYellow,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(10.0),
                  elevation: 12.0,
                  shadowColor: kYellow,
                ),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 15.0,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                label: const Text(
                  "Get Started",
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account? '),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    color: kYellow,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
