// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:app_1/consts/consts.dart';
import 'package:app_1/models/appbar.dart';
import 'package:app_1/models/search.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: APPBAR(),
      body: Column(
        children: [
          SEARCH(search),
          Container(
              decoration: BoxDecoration(color: kGreen),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Catagories('Item1'),
                  Catagories('Item2'),
                  Catagories('Item3'),
                  Catagories('Item4'),
                  Catagories('Item5'),
                ],
              )),
        ],
      ),
    );
  }

  Padding Catagories(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        width: 150,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
