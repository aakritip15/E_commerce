import 'dart:async';

import 'package:app_1/Screens/ProductDetails.dart';
import 'package:app_1/Screens/itemview.dart';
import 'package:app_1/Screens/landing_page.dart';
import 'package:app_1/consts/consts.dart';
import 'package:app_1/models/ProductDetails.dart';
import 'package:app_1/models/appbar.dart';
import 'package:app_1/models/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/nav.dart';
import '../models/productModel.dart';

class MyHousePage extends StatelessWidget {
  final _reference = FirebaseFirestore.instance.collection('products');

  //_reference.get()  ---> returns Future<QuerySnapshot>
  //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
  late Stream<QuerySnapshot> _stream;

  MyHousePage({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }
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
      body: SingleChildScrollView(
        child: Column(children: [
          SEARCH(search),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Categories:-',
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Catagories('Stationary'),
                Catagories('Groceries'),
                Catagories('Electronics'),
                Catagories('Furnitures'),
                Catagories('Vehicles'),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //Check error
              if (snapshot.hasError) {
                return Center(
                    child: Text('Some error occurred ${snapshot.error}'));
              }

              //Check if data arrived
              if (snapshot.hasData) {
                //get the data
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                //Convert the documents to Maps
                List<Map> products = documents
                    .map((e) => {
                          'ProductUrl': e['ProductImage'],
                          'ProductSellerId': e.id,
                          'ProductPrice': e['ProductPrice'],
                          'ProductName': e['ProductName'],
                          'Seller': e['SellerName'],
                          'condition': e['ProductCondition'],
                          'ProductPrice': e['ProductPrice'],
                        })
                    .toList();

                //Display the list
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      //Get the item at this index
                      Map thisProduct = products[index];
                      //REturn the widget for the list items

                      return ProductWidget(
                        image: thisProduct['ProductUrl'],
                        title: thisProduct['ProductName'],
                        sellername: thisProduct['Seller'],
                        condition: thisProduct['condition'],
                        price: thisProduct['ProductPrice'],
                      );
                    });
              }

              //Show loader
              return Center(child: CircularProgressIndicator());
            },
          ),
        ]),
      ),
    );
  }

  Widget Catagories(String text) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[350],
      ),
      //width: 150,
      child: TextButton(
        onPressed: () {
          // TODO: sort accordig to categories
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  String image;
  String title;
  String condition;
  String price;
  String sellername;
  ProductWidget({
    required this.condition,
    required this.image,
    required this.title,
    required this.sellername,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Row(
            children: [
              Container(
                height: 180,
                width: 230,
                child: Image.network(image),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    width: 130,
                    color: Colors.grey[100],
                    child: Text(title),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 15,
                    width: 90,
                    color: Colors.grey[200],
                    child: Text('Price : $price'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12)),
                    child: Text('Condition: $condition'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 15,
                    width: 120,
                    color: Colors.grey[200],
                    child: Text('Seller: $sellername'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
