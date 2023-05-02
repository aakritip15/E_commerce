// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, must_be_immutable, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'package:app_1/Screens/SellerListing.dart';
import 'package:app_1/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import '../models/Orders.dart';
import '../models/ProductDetails.dart';
import '../models/firebaseHelper.dart';
import '../models/userModel.dart';
import 'profile.dart' as profile;

class ItemView extends StatefulWidget {
  final Products product;

  const ItemView({super.key, required this.product});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
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
        SnackBar(
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

  int _count = 1;
  String DisplayText = 'Place Order';
  String? Display() {
    String text = 'Place Order';
    String uid = FirebaseAuth.instance.currentUser!.uid;
    if (uid == widget.product.ProductSellerID) {
      text = 'Delete Product';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product View',
            style: TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: double.infinity,
                    height: 230,
                    // color: Colors.yellow,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Image(
                      image:
                          NetworkImage(widget.product.ProductImage.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Text(
                      widget.product.ProductName.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    ),
                    Spacer(),
                    LikeButton(
                      onTap: (isLiked) {
                        if (!isLiked == true) {
                          //TODO : Add to My Favourties DataBase

                          // add to favourites database on firebase
                          var myFav = {
                            'ProductID': widget.product
                                .ProductID, // only product id is added since if further info is required, it can be fetched from the product database
                            'UserID': FirebaseAuth.instance.currentUser!.uid,
                          };
                          try {
                            FirebaseFirestore.instance
                                .collection('Favourites')
                                .add(myFav);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Task Failed :$e"),
                              ),
                            );
                          }

                          // print('liked');
                        }

                        return Future.value(!isLiked);
                      },
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    String uid = widget.product.ProductSellerID!;
                    UserModel? SellerModel =
                        await FirebaseHelper.getUserModelById(uid);

                    if (SellerModel != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SellerProfile(user: SellerModel)));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'By ${widget.product.ProductSellerName}',
                    style: TextStyle(fontSize: 22, color: Colors.grey[800]),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Rs: ${widget.product.ProductPrice}',
                  style: TextStyle(
                    color: kRed,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.grey[50],

                  //make this text scroallable

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.product.ProductDescription.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: GoogleFonts.lato().fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0), // margin: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CounterButton(
                        child: Icon(
                          FeatherIcons.minus,
                          size: 15,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_count > 1) {
                              _count--;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _count.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      CounterButton(
                        child: Icon(
                          FeatherIcons.plus,
                          size: 15,
                        ),
                        onPressed: () {
                          setState(() {
                            _count++;
                          });
                        },
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 250,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffef6957),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          onPressed: () {
                            String check = Display()!;
                            if (check == 'Place Order') {
                              PlaceOrder();
                            } else if (check == 'Delete Product') {
                              DeleteOrder();
                            }
                          },
                          child: Text(
                            Display()!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void DeleteOrder() async {
    FirebaseFirestore.instance
        .collection('Products')
        .doc(widget.product.ProductID)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Product Deleted"),
      ),
    );
    UserModel? CurrentUser = await FirebaseHelper.getUserModelById(
        FirebaseAuth.instance.currentUser!.uid);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => profile.Profile(user: CurrentUser!)));
    setState(() {});
  }
}

class CounterButton extends StatelessWidget {
  CounterButton({super.key, this.child, this.onPressed});

  final child;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
        ),
        child: child,
      ),
    );
  }
}
