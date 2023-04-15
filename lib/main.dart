// ignore_for_file: prefer_const_constructors
import 'package:app_1/Screens/MyOrders.dart';
import 'package:app_1/Screens/account_setting.dart';
import 'package:app_1/Screens/homepage.dart';
import 'package:app_1/Screens/itemview.dart';
import 'package:app_1/Screens/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/Screens/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import '/widgets/customTextFormField.dart';
import 'Screens/sell_item.dart';
import 'screens/login.dart';
import 'models/appbar.dart';
//import '/Screens/body.dart';
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
      currentuser: currentUser,
    ));
  } else {
    runApp(MyApp());
  }
}

class MyAppafterLogin extends StatelessWidget {
  final UserModel userModel;
  final User? currentuser;
  const MyAppafterLogin(
      {super.key, required this.userModel, required this.currentuser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Orders(),
      //home: Item_view(),
      // home: SellItem(firebaseUser: currentuser),
      /* home: AccountSetting(
        user: userModel,
      ),*/
      //home: MyHomePage(),
      home: RegisterPage(),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  User? firebaseUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: LandingPage(),
      // home: SellItem(firebaseUser: firebaseUser),
      //home: AnimatedSplashScreen(splash: Icons.home, nextScreen: MyHomePage(), duration: 2500, backgroundColor: Color(0xFFFFB930), splashTransition: SplashTransition.fadeTransition),
      debugShowCheckedModeBanner: false,
    );
  }
}
