import 'package:app_1/models/ProductDetails.dart';
import 'package:app_1/models/appbar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APPBAR(),
      body: Center(
        child: Text(
            'Urls: ${widget.product.ProductImage}'), //In an array of urls can be used to iterate and display multiple images
      ),
    );
  }
}
