// ignore_for_file: prefer_const_constructors
import 'package:app_1/Screens/account_setting.dart';
import 'package:app_1/Screens/availiable_items.dart';
import 'package:app_1/Screens/body.dart';
import 'package:app_1/Screens/edit_information.dart';
import 'package:app_1/Screens/splashscreen.dart';
import 'package:app_1/models/list_of_things.dart';
import 'package:app_1/screens/itemview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/Screens/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/appbar.dart';
import 'models/firebaseHelper.dart';
import 'models/userModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    UserModel? thisUser =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    runApp(MyAppafterLogin(
      userModel: thisUser!,
    ));
  } else {
    runApp(MyApp());
  }
}

class MyAppafterLogin extends StatelessWidget {
  final UserModel userModel;
  const MyAppafterLogin(
      {super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: LandingPage(),
      home: AccountSetting(
        user: userModel,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: LandingPage(),
      home: LandingPage(),

      //home: AnimatedSplashScreen(splash: Icons.home, nextScreen: MyHomePage(), duration: 2500, backgroundColor: Color(0xFFFFB930), splashTransition: SplashTransition.fadeTransition),
      debugShowCheckedModeBanner: false,
    );
  }
}
