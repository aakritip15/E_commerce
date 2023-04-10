// ignore_for_file: non_constant_identifier_names

import 'package:app_1/models/ProductDetails.dart';
import 'package:app_1/models/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
      FirebaseFirestore.instance
          .collection('Orders')
          .doc(widget.product.ProductSellerID)
          .set({
        'ProductID': widget.product.ProductID,
        'ProductSellerID': widget.product.ProductSellerID,
        'ProductBuyerID': user,
        'ProductPrice': widget.product.ProductPrice,
        'ProductStatus': Status,
      });
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
      appBar: APPBAR(),
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
