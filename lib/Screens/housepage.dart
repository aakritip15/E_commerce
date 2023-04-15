// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:app_1/Screens/ProductDetails.dart';
import 'package:app_1/Screens/itemview.dart';
import 'package:app_1/consts/consts.dart';
import 'package:app_1/models/ProductDetails.dart';
import 'package:app_1/models/appbar.dart';
import 'package:app_1/models/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/nav.dart';

class MyHousePage extends StatefulWidget {
  MyHousePage({Key? key}) : super(key: key);

  @override
  State<MyHousePage> createState() => _MyHousePageState();
}

class _MyHousePageState extends State<MyHousePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: NavBar(),
      ),
      appBar: APPBAR(
        context,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SEARCH(search),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Categories:-',
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Catagories('Stationary'),
                Catagories('Groceries'),
                Catagories('Electronics'),
                Catagories('Furnitures'),
                Catagories('Vehicles'),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: kPink,
            child: Column(
              children: [ProductWidget(), ProductWidget(), ProductWidget()],
            ),
          ),
        ]),
      ),
    );
  }

  Widget Catagories(String text) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[350],
      ),
      //width: 150,
      child: TextButton(
        onPressed: () {
          // TODO: sort accordig to categories
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Row(
            children: [
              Container(
                height: 180,
                child: Image(
                  image: AssetImage('images/images/Login.png'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    width: 150,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 15,
                    width: 70,
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4)),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
