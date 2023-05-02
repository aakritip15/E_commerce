// ignore_for_file: prefer_const_constructors
import 'package:app_1/Screens/homepage.dart';
import 'package:app_1/Screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
      title: 'Resell It',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(
        user: userModel,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? firebaseUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resell It',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
