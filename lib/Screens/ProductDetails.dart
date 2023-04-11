// ignore_for_file: non_constant_identifier_names

import 'package:app_1/models/ProductDetails.dart';
import 'package:app_1/models/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/Orders.dart';

class ProductDetails extends StatefulWidget {
  final Products product;
  ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? user = FirebaseAuth.instance.currentUser!.uid;
  String Status = 'Pending';
  void PlaceOrder() {
    try {
      final order = Items(
        ProductName: widget.product.ProductName,
        ProductID: widget.product.ProductID,
        ProductSellerID: widget.product.ProductSellerID,
        ProductBuyerID: user,
        ProductPrice: widget.product.ProductPrice,
        ProductStatus: Status,
      );

      FirebaseFirestore.instance.collection('Orders').add(order.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Order Placed"),
        ),
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Order Failed code:$e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APPBAR(
        context,
      ),
      body: Column(
        children: [
          Center(
            child: Text(
                'Urls: ${widget.product.ProductImage}'), //In an array of urls can be used to iterate and display multiple images
          ),
          Center(
            child: ElevatedButton(
                child: Text('Buy'),
                onPressed: () {
                  PlaceOrder();
                }),
          )
        ],
      ),
    );
  }
}
