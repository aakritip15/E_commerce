// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/categoryName.dart';

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
