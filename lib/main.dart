// ignore_for_file: prefer_const_constructors

import 'package:app_1/Screens/chatHome.dart';
import 'package:app_1/models/availiable_items.dart';
import 'package:app_1/models/list_of_things.dart';
import 'package:app_1/screens/chatRoom.dart';
import 'package:app_1/screens/itemview.dart';
import 'package:flutter/material.dart';
import '/Screens/edit_information.dart';
import '/Screens/homepage.dart';
import '/Screens/landing_page.dart';
import '/Screens/registration_page.dart';
import '/Screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/widgets/customTextFormField.dart';
import 'Screens/sell_item.dart';
import 'screens/login.dart';
import 'models/appbar.dart';
import 'screens/body.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: ChatPage(),
      //home: BODY(),
      home: SellItem(),
      //home: AnimatedSplashScreen(splash: Icons.home, nextScreen: MyHomePage(), duration: 2500, backgroundColor: Color(0xFFFFB930), splashTransition: SplashTransition.fadeTransition),
      debugShowCheckedModeBanner: false,
    );
  }

  // Scaffold App() {
  //   return Scaffold(
  //     appBar: APPBAR(),
  //     body: Item_view(),
  //   );
  // }
}
