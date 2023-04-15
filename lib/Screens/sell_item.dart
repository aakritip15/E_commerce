import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../models/productModel.dart';

class SellItem extends StatefulWidget {
  final User? firebaseUser;
  // final String? uid;

  const SellItem({Key? key, required this.firebaseUser});

  @override
  State<SellItem> createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController itemName = TextEditingController();
  String? condition = 'used';
  bool clickNew = false;
  bool clickUsed = true;

  List<String> _categoryList = <String>[
    "Mobile",
    "Stationary",
    "Grocery",
    "Vehicle"
  ];
  String _category = 'Mobile';

  List<String> _location = <String>["Kathmandu", "Lalitpur", "Bhaktapur"];
  String _choosedLocation = 'Kathmandu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Item Details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 152,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 90,
                              width: 95,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(width: 10),
                            Container(
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.add)),
                              height: 95,
                              width: 95,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                        SizedBox(height: 9),
                        Text('Tap on images to add or delete them'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Item name*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: itemName,
                      decoration:
                          InputDecoration.collapsed(hintText: 'Item name'),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Category*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          value: _category,
                          items: _categoryList
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _category = val.toString();
                            });
                          }),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Description',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Container(
                  height: 95,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: description,
                      decoration:
                          InputDecoration.collapsed(hintText: 'Description'),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Condition*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: (clickNew == false)
                              ? MaterialStateProperty.all(Colors.grey[300])
                              : MaterialStateProperty.all(Colors.green[200]),
                        ),
                        onPressed: () {
                          setState(() {
                            condition = 'New';
                            clickNew = !clickNew;
                            clickUsed = !clickUsed;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'New',
                            style: TextStyle(
                              color: (clickNew == true)
                                  ? Colors.black
                                  : Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: (clickUsed == false)
                              ? MaterialStateProperty.all(Colors.grey[300])
                              : MaterialStateProperty.all(Colors.green[200]),
                        ),
                        onPressed: () {
                          setState(() {
                            clickUsed = !clickUsed;
                            clickNew = !clickNew;
                            condition = 'Used';
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Used',
                            style: TextStyle(
                              color: (clickUsed == false)
                                  ? Colors.grey
                                  : Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 16),
                Text('Price*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: price,
                      decoration: InputDecoration.collapsed(hintText: 'Price'),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Location*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          value: _choosedLocation,
                          items: _location
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _choosedLocation = val.toString();
                            });
                          }),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () async {
                        String? pid = '1234';
                        String? uid = widget.firebaseUser?.uid;
                        ProductModel productModel = ProductModel(
                          imageurl: {},
                          itemName: itemName.text.toString(),
                          category: _category,
                          description: description.text.toString(),
                          condition: condition,
                          price: price.text.toString(),
                          location: _choosedLocation,
                          sellerId: widget.firebaseUser?.uid,
                          productId: pid,
                          listedDate: DateTime.now(),
                        );

                        await FirebaseFirestore.instance
                            .collection('products')
                            // .doc(uid)
                            //.collection('Items')
                            .doc(pid)
                            .set(productModel.toMap())
                            .then((value) => 'Product added successfully');
                        print('Item added successfully');
                      },
                      child: Center(
                          child: Text('Post Now',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              )))),
                )
              ],
            ),
          ),
        ));
  }
}
