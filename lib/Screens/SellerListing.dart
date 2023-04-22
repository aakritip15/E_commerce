import 'package:app_1/Screens/account_setting.dart';
import 'package:app_1/consts/consts.dart';
import 'package:app_1/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/nav.dart';
import 'homepage.dart';

class SellerProfile extends StatelessWidget {
  UserModel user;

  SellerProfile({Key? key, required this.user}) : super(key: key);
  // late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    String letter = user.fullname!;
    String l = letter[0];
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: NavBar(),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Seller',
            style: TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountSetting(user: user)));
              },
              color: kBrown,
              icon: Icon(Icons.settings))
        ],
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Text(
                    l,
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 60,
                        color: Colors.white),
                  ),
                  //child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
                ),
                SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    //Name
                    Text(
                      user.fullname!,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Email:${user.email!}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Address:${user.address!}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    //Address
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              "Items",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 22,
                color: kBrown,
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('ProductSellerId', isEqualTo: user.uid!)
                  .snapshots(),
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
                height: 160,
                width: 200,
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
