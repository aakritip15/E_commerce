// ignore_for_file: non_constant_identifier_names, file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FavModel {
  String? ProductID;
  /* 'ProductID': widget.product
                                .ProductID, // only product id is added since if further info is required, it can be fetched from the product database
                            'ProductName': widget.product.ProductName,

                            'ProductPrice': widget.product.ProductPrice,
                            // 'ProductImage': widget.product.ProductImage,
                            'ProductSellerID': widget.product.ProductSellerID,
                            'ProductSellerName':
                                widget.product.ProductSellerName,

                            'UserID': FirebaseAuth.instance.currentUser!.uid,*/

  String? UserID;
  String? ProductName;
  String? ProductPrice;
  // String? ProductImage;
  String? ProductSellerID;
  String? ProductSellerName;

  FavModel(
      {this.ProductID,
      this.UserID,
      this.ProductName,
      this.ProductPrice,
      /*this.ProductImage,*/ this.ProductSellerID,
      this.ProductSellerName});

  FavModel.fromMap(Map<String, dynamic> map) {
    ProductID = map["ProductID"];
    UserID = map["UserID"];
    ProductName = map["ProductName"];
    ProductPrice = map["ProductPrice"];
    // ProductImage = map["ProductImage"];
    ProductSellerID = map["ProductSellerID"];
    ProductSellerName = map["ProductSellerName"];
  }

  Map<String, dynamic> toMap() {
    return {
      "ProductID": ProductID,
      "UserID": UserID,
      "ProductName": ProductName,
      "ProductPrice": ProductPrice,
      // "ProductImage": ProductImage,
      "ProductSellerID": ProductSellerID,
      "ProductSellerName": ProductSellerName,
    };
  }

  factory FavModel.fromSnapshot(DocumentSnapshot snapshot) {
    return FavModel(
      ProductID: snapshot.id,
      UserID: snapshot.get('UserID'),
      ProductName: snapshot.get('ProductName'),
      ProductPrice: snapshot.get('ProductPrice'),
      // ProductImage: snapshot.get('ProductImage'),
      ProductSellerID: snapshot.get('ProductSellerID'),
      ProductSellerName: snapshot.get('ProductSellerName'),
    );
  }
}
