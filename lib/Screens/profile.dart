// ignore_for_file: must_be_immutable

import 'package:app_1/Screens/account_setting.dart';
import 'package:app_1/consts/consts.dart';
import 'package:app_1/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/ProductDetails.dart';
import '../models/nav.dart';
import '../widgets/tile.dart';
import 'homepage.dart';

class Profile extends StatefulWidget {
  UserModel user;

  Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<List<Products>>? productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = getProducts();
  }

  Future<List<Products>> getProducts() async {
    // String? uid = FirebaseAuth.instance.currentUser!.uid;
    List<Products> products = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('ProductSellerID', isEqualTo: widget.user.uid)
        .get();
    for (var element in snapshot.docs) {
      products.add(Products.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    String letter = widget.user.fullname!;
    String l = letter[0];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AccountSetting(user: widget.user)));
              },
              color: kBrown,
              icon: const Icon(Icons.settings))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          user: widget.user,
                        )));
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Text(
                  l,
                  style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: Colors.white),
                ),
                //child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
              ),
              const SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  //Name
                  Text(
                    widget.user.fullname!,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.user.email!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.user.address!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  //Address
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "My Items",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 22,
              color: kBrown,
            ),
          ),
          ListDisplay(productsFuture),
        ]),
      ),
    );
  }

  FutureBuilder<List<Products>> ListDisplay(total) {
    return FutureBuilder(
      future: total,
      builder: (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          List<Products> products = snapshot.data!;
          return Expanded(
            child: SizedBox(
              width: 350,
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Tile(context,
                      product: products[index], user: widget.user);
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            ),
          );
        }
      },
    );
  }
}
