// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:app_1/consts/consts.dart';
import 'package:app_1/models/ProductDetails.dart';
import 'package:app_1/models/appbar.dart';
import 'package:app_1/models/userModel.dart';
import 'package:app_1/widgets/tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/nav.dart';

Future<List<Products>>? filteredProducts;
String? uid = FirebaseAuth.instance.currentUser!.uid;

class MyHomePage extends StatefulWidget {
  final UserModel user;
  MyHomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Products>>? productsFuture;
  Future<List<Products>>? SearchedProducts;

  @override
  void initState() {
    super.initState();
    productsFuture = getProducts();
  }

  Future<List<Products>> getProducts() async {
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    List<Products> products = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('ProductSellerID', isNotEqualTo: uid)
        .get();
    for (var element in snapshot.docs) {
      products.add(Products.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  Future<List<Products>> searchProducts(String? search) async {
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    List<Products> products = [];
    List<Products> filteredProducts = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('ProductSellerID', isNotEqualTo: uid)
        .get();
    for (var element in snapshot.docs) {
      products.add(Products.fromMap(element.data() as Map<String, dynamic>));
    }
    filteredProducts = products
        .where((element) => element.ProductName!
            .toLowerCase()
            .startsWith(search!.toLowerCase()))
        .toList();
    return filteredProducts;
  }

  Future<List<Products>> searchProductsUsingCategories(String? search) async {
    List<Products> products = [];
    List<Products> filteredProducts = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('ProductSellerID', isNotEqualTo: uid)
        .get();
    for (var element in snapshot.docs) {
      products.add(Products.fromMap(element.data() as Map<String, dynamic>));
    }
    filteredProducts = products
        .where((element) => element.ProductCategory!
            .toLowerCase()
            .startsWith(search!.toLowerCase()))
        .toList();
    if (filteredProducts.isEmpty) {}
    return filteredProducts;
  }

  List Categories = [
    'Mobile',
    'Stationary',
    'Clothes',
    'Shoes',
    'Electronics',
    'Furniture',
    'Books',
    'Toys',
    'Sports',
    'Other'
  ];
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 320,
                decoration: BoxDecoration(
                  color: kGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: search,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Search',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        productsFuture =
                            searchProducts(search.text.toLowerCase());
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: kGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  onPressed: () {
                    productsFuture = searchProducts(search.text.toLowerCase());
                    setState(() {});
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Catagories(Categories[index].toString(), context);
              },
            ),
          ),
          ListDisplay(productsFuture),
        ],
      ),
    );
  }

  FutureBuilder<List<Products>> ListDisplay(total) {
    return FutureBuilder(
      future: total,
      builder: (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
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

  Padding Catagories(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade400,
        ),
        width: 150,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: TextButton(
            onPressed: () async {
              QuerySnapshot snapshot = await FirebaseFirestore.instance
                  .collection('Products')
                  .where('ProductCategory', isEqualTo: text)
                  .get();
              if (snapshot.docs.isEmpty) {
                productsFuture = getProducts();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("No Products were Found for $text"),
                  ),
                );
              } else {
                productsFuture =
                    searchProductsUsingCategories(text.toLowerCase());
              }
              setState(() {});
            },
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//Homepage
