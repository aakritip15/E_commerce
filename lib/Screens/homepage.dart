// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:app_1/Screens/ProductDetails.dart';
import 'package:app_1/consts/consts.dart';
import 'package:app_1/models/ProductDetails.dart';
import 'package:app_1/models/appbar.dart';
import 'package:app_1/models/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Products>>? productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = fetchProducts();
  }

  Future<List<Products>> fetchProducts() async {
    List<Products> products = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Products').get();
    snapshot.docs.forEach((element) {
      products.add(Products.fromMap(element.data() as Map<String, dynamic>));
    });

    return products;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: APPBAR(
        context,
      ),
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
            ),
          ),
          FutureBuilder(
            future: productsFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching data.'),
                );
              } else {
                List<Products> products = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () {
                          print(products[index].ProductName);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                        product: products[index],
                                      )));
                        },
                        title: Text(products[index].ProductName!),
                        subtitle: Text(
                            '\$${products[index].ProductPrice!.toString()}'),
                      ),
                    );
                  },
                );
              }
            },
          ),
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
          child: TextButton(
            onPressed: () {
              print(text);
            },
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
      ),
    );
  }
}
