// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, must_be_immutable

import 'package:app_1/consts/consts.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

/*
class Item_view extends StatelessWidget {
  Item_view({super.key});

  String Information =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(children: [
              IconButton(onPressed: () {}, icon: Icon(FeatherIcons.arrowLeft))
            ]),
          ),
          Scroll_Image(),
          Info(),
        ],
      ),
    );
  }

  SizedBox Scroll_Image() {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ImageDisplay(Colors.amber), //esle url lincha
            ImageDisplay(Colors.blueAccent),
            ImageDisplay(Colors.greenAccent),
          ],
        ),
      ),
    );
  }

  Container ImageDisplay(Color s) {
    return Container(
      decoration: BoxDecoration(color: s),
      child: SizedBox(
        height: 200,
        width: 400,
      ),
    );
  }

  Info() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              Text(
                'SellerName',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Helvetica',
                ),
              ), //yo variable hune ho
              SizedBox(
                width: 20,
              ),
              Text("4.1/5  Review", style: TextStyle(fontSize: 12)),
            ],
          ),
          Row(
            children: [
              Text(
                'Item Name',
                style: TextStyle(
                    fontFamily: 'TimesNewRoman',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 239, 174, 174),
                    ),
                padding: const EdgeInsets.only(top: 8.0),
                width: 350,
                height: 200,
                child: Text(Information,
                    style: TextStyle(color: Colors.grey[600])),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 350,
                  height: 20,
                  child: Text('Added by the seller on date 2023/Jan/04'),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print('Shopping Bag Clicked');
                    }
                  },
                  icon: Icon(FeatherIcons.shoppingBag),
                ),
                IconButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print('Message Clicked');
                      }
                    },
                    icon: Icon(FeatherIcons.send))
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                if (kDebugMode) {
                  print('Buy Now Clicked');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
*/

class ItemView extends StatefulWidget {
  ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  int _count = 1;
  final _price = 1200.00;

//! Remove later
  final _imageUrl =
      'https://cdn.shopify.com/s/files/1/0533/6393/products/webleedohio-love-football-women-s-raglan-hoodie-small-bone-white-30882159001654_800x.jpg?v=1654843036';

  // String _description =
  //
  final _description =
      'Our premium sweatshirt is made from high-quality cotton blend fabric with a soft fleece lining, providing warmth and comfort. The classic design features ribbed cuffs, hemline, and neckline for a snug fit. Perfect for layering or wearing on its own, it\'s a stylish and versatile addition to any wardrobe.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            //TODO : ADD NAVIGATION TO PREVIOUS PAGE
          },
          icon: Icon(
            FeatherIcons.arrowLeft,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Product Details',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: 'TimesNewRoman',
              letterSpacing: 0.5),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 40,
      ),
      body: Container(
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
                //TODO: child: Image(image: AssetImage(appIcon)),
                child: Image(
                  image: NetworkImage(_imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Text(
                  'Hooded Sweatshirt',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                ),

                Spacer(),
                // SizedBox(
                //     height: 25,
                //     width: 25,
                //     child: IconButton(
                //       onPressed: () {
                //         toggle();
                //         //TODO : Add to My Favourties DataBase
                //       },
                //       tooltip: 'Add to Cart',
                //       // color: Colors.red[600],
                //       style: _buttonStyle,
                //       icon: Icon(
                //         FeatherIcons.shoppingBag,
                //       ),
                //     )),

                LikeButton(
                  onTap: (isLiked) {
                    if (!isLiked == true) {
                      //TODO : Add to My Favourties DataBase
                      print('liked');
                    }

                    return Future.value(!isLiked);
                  },
                ),
              ],
            ),
            Text(
              'By Jarvis Pepperspray',
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'Rs ${((_price) * _count).toStringAsFixed(2)}',
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
                    _description,
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
                    width: 270,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xffef6957),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Buy Now',
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
    );
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
