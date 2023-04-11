// ignore_for_file: prefer_const_constructors
import 'package:app_1/Screens/MyOrders.dart';
import 'package:app_1/Screens/account_setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/Screens/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import '/widgets/customTextFormField.dart';
import 'Screens/sell_item.dart';
import 'screens/login.dart';
import 'models/appbar.dart';
import 'screens/body.dart';
import 'package:uuid/uuid.dart';
import 'firebase_options.dart';
import 'models/firebaseHelper.dart';
import 'models/userModel.dart';

var uuid = Uuid();
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
>>>>>>> f1b81ee59923c1cb8b61b9e5437e391fb7bf4a2c
}

class MyAppafterLogin extends StatelessWidget {
  final UserModel userModel;
  const MyAppafterLogin({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Orders(),
      home: AccountSetting(
        user: userModel,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),


      home: LandingPage(),

      //home: AnimatedSplashScreen(splash: Icons.home, nextScreen: MyHomePage(), duration: 2500, backgroundColor: Color(0xFFFFB930), splashTransition: SplashTransition.fadeTransition),
      debugShowCheckedModeBanner: false,
    );
  }
}
