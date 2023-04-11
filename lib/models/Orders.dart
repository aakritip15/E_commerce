// ignore_for_file: non_constant_identifier_names, file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  String? ProductName;
  String? ProductID;
  String? ProductSellerID;
  String? ProductBuyerID;
  String? ProductPrice;
  String? ProductStatus;

  Items(
      {this.ProductName,
      this.ProductID,
      this.ProductSellerID,
      this.ProductBuyerID,
      this.ProductPrice,
      this.ProductStatus});

  Items.fromMap(Map<String, dynamic> map) {
    ProductName = map["ProductName"];
    ProductID = map["ProductID"];
    ProductSellerID = map["ProductSellerID"];
    ProductBuyerID = map["ProductBuyerID"];
    ProductPrice = map["ProductPrice"];
    ProductStatus = map["ProductStatus"];
  }

  Map<String, dynamic> toMap() {
    return {
      "ProductName": ProductName,
      "ProductID": ProductID,
      "ProductSellerID": ProductSellerID,
      "ProductBuyerID": ProductBuyerID,
      "ProductPrice": ProductPrice,
      "ProductStatus": ProductStatus,
    };
  }

  factory Items.fromSnapshot(DocumentSnapshot snapshot) {
    return Items(
      ProductID: snapshot.id,
      ProductName: snapshot.get('ProductName'),
      ProductBuyerID: snapshot.get('ProductBuyerID'),
      ProductSellerID: snapshot.get('ProductSellerID'),
      ProductPrice: snapshot.get('ProductPrice'),
      ProductStatus: snapshot.get('ProductStatus'),
    );
  }
}
