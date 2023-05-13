// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_build_context_synchronously, unnecessary_cast

import 'dart:async';

import 'package:app_1/Screens/itemview.dart';
import 'package:app_1/models/appbar.dart';
import 'package:app_1/models/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/Orders.dart';
import '../models/ProductDetails.dart';

class Sellings extends StatefulWidget {
  Sellings({super.key});

  @override
  State<Sellings> createState() => _SellingsState();
}

class _SellingsState extends State<Sellings> {
  Future<List<Items>>? OrderFuture;
  String? user = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    OrderFuture = fetchProducts();
  }

  Future<List<Items>> fetchProducts() async {
    List<Items> products = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Orders')
        .where('ProductSellerID', isEqualTo: user)
        .get();
    for (var element in snapshot.docs) {
      products.add(Items.fromMap(element.data() as Map<String, dynamic>));
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    Container orderTile(String? ProductName, String? SellerName, String? Price,
        String? Status,String?ProductID, List<Items> products, BuildContext context) {
      // String? ProductName = "Samsung Phone";
      // String? SellerName = "Shashinoor Ghimire";
      // String? Price = "1000";
      // String? Status = "Pending";
      return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 223, 232, 224),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ProductName!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Seller:$SellerName',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Price: $Price!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Status: $Status',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 0, 0, 0)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 244, 249, 103)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                  ),
                  onPressed: () async {
                    Products ProductInfo = await FirebaseFirestore.instance
                        .collection('Products')
                        .where('ProductName', isEqualTo: ProductName)
                        .get()
                        .then((value) {
                      return Products.fromMap(
                          value.docs.first.data() as Map<String, dynamic>);
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ItemView(
                        product: ProductInfo,
                      );
                    }));
                  },
                  child: Row(
                    children: [
                      Text('View Details',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          )),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 255, 255, 255)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 228, 69, 45)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('Orders')
                        .where('ProductName', isEqualTo: ProductName)
                        .get()
                        .then((value) {
                      for (var element in value.docs) {
                        FirebaseFirestore.instance
                            .collection('Orders')
                            .doc(element.id)
                            .delete();
                      }
                      products.removeWhere((element) =>
                          element.ProductName == ProductName &&
                          element.ProductSellerID == SellerName &&
                          element.ProductPrice == Price &&
                          element.ProductStatus == Status);
                      setState(() {});
                    });
                  },
                  child: Row(

                    children: [
                      Text('Cancel Order'),
                      Icon(Icons.cancel_outlined),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            TextButton(
               style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 64, 193, 142)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                  ),onPressed: (){
                      FirebaseFirestore.instance.collection('Products').doc(ProductID).delete();
                     ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                     content: Text("Product Deleted"),
                     ),
                     );
                    FirebaseFirestore.instance
                        .collection('Orders')
                        .where('ProductName', isEqualTo: ProductName)
                        .get()
                        .then((value) {
                      for (var element in value.docs) {
                        FirebaseFirestore.instance
                            .collection('Orders')
                            .doc(element.id)
                            .delete();
                      }
                      products.removeWhere((element) =>
                          element.ProductName == ProductName &&
                          element.ProductSellerID == SellerName &&
                          element.ProductPrice == Price &&
                          element.ProductStatus == Status);
                      setState(() {});
                    });                     
                  }, 
                  child:Text('Update Status to Sold',style: TextStyle(
                        color: Colors.white
                      ),),
                  ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 249, 244),
           appBar: AppBar(
        title: const Text('My Sellings',
            style: TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
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

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: orderTile(
                            products[index].ProductName,
                            products[index].ProductSellerID,
                            products[index].ProductPrice,
                            products[index].ProductStatus,
                            products[index].ProductID,
                            products,
                            context,
                          ),
                        ));
                  },
                ),
              );
            }
          },
        ),
      ]),
    );
  }
}
