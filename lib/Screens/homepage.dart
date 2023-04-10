// ignore_for_file: prefer_const_constructors

import 'package:app_1/models/appbar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APPBAR(),
      body: Column(
        children: [
          Container(
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
          ),
        ),
      ),
    );
  }
}
