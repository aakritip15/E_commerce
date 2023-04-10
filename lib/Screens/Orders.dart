// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:app_1/consts/colors.dart';
import 'package:app_1/models/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/Orders.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Future<List<Items>>? OrderFuture;
  String? user = FirebaseAuth.instance.currentUser!.uid;
  void initState() {
    super.initState();
    OrderFuture = fetchProducts();
  }

  Future<List<Items>> fetchProducts() async {
    List<Items> products = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Orders')
        .where('ProductBuyerID', isEqualTo: user)
        .get();
    snapshot.docs.forEach((element) {
      products.add(Items.fromMap(element.data() as Map<String, dynamic>));
    });

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: APPBAR(),
      body: Column(children: [
        FutureBuilder(
          future: OrderFuture,
          builder: (BuildContext context, AsyncSnapshot<List<Items>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching data.'),
              );
            } else {
              List<Items> products = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                spreadRadius: 0.3,
                                offset: Offset(0, 1),
                              ),
                            ]),
                        child: ListTile(
                            onTap: () {
                              print(products[index].ProductName);
                            },
                            title: Text(products[index].ProductName!),
                            subtitle: Text(
                                'Status:${products[index].ProductStatus!}'),
                            trailing: SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2,
                                      spreadRadius: 0.3,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: kRed,
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('Orders')
                                        .where('ProductName',
                                            isEqualTo:
                                                products[index].ProductName)
                                        .get()
                                        .then((value) {
                                      value.docs.forEach((element) {
                                        FirebaseFirestore.instance
                                            .collection('Orders')
                                            .doc(element.id)
                                            .delete();
                                      });
                                      products.removeAt(index);
                                      setState(
                                          () {}); // This line will trigger a rebuild of the widget tree
                                    });
                                  },
                                ),
                              ),
                            )),
                      ));
                },
              );
            }
          },
        ),
      ]),
    );
  }
}
