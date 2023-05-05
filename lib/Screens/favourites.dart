import 'package:app_1/models/favModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/ProductDetails.dart';
import '../models/appbar.dart';
import '../models/nav.dart';
import 'itemview.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Future<List<FavModel>>? FavFuture;
  String? user = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    FavFuture = fetchFavs();
  }

  Future<List<FavModel>> fetchFavs() async {
    List<FavModel> favourites = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Favourites')
        .where('UserID', isEqualTo: user)
        .get();
    for (var element in snapshot.docs) {
      favourites.add(FavModel.fromMap(element.data() as Map<String, dynamic>));
    }

    return favourites;
  }

  @override
  Widget build(BuildContext context) {
    Container favTile(
        String? ProductName,
        String? UserID,
        String? Price,
        // String? Status,
        String? SellerName,
        String? ProductID,
        List<FavModel> favourites,
        BuildContext context) {
      return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 223, 232, 224),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ProductName!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Seller:$SellerName',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Price: $Price!',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(width: 10),
                // Text(
                //   'Status: $Status!',
                //   style: const TextStyle(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w300,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 0, 0, 0)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 244, 249, 103)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15)),
                  ),
                  onPressed: () async {
                    Products ProductInfo = await FirebaseFirestore.instance
                        .collection('Products')
                        .where('ProductName', isEqualTo: ProductName)
                        .get()
                        .then((value) {
                      return Products.fromMap(
                          value.docs.first.data() as Map<String, dynamic>);
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ItemView(
                        product: ProductInfo,
                      );
                    }));
                  },
                  child: Row(
                    children: [
                      Text('View Details',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          )),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 255, 255)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 228, 69, 45)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15)),
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('Favourites')
                        .where('ProductID', isEqualTo: ProductID)
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        FirebaseFirestore.instance
                            .collection('Favourites')
                            .doc(element.id)
                            .delete();
                      });
                      favourites.removeWhere((element) =>
                          element.ProductName == ProductName &&
                          element.ProductSellerID == SellerName &&
                          element.ProductPrice == Price &&
                          element.UserID == UserID);
                      setState(() {});
                    });
                  },
                  child: Row(
                    children: [
                      Text('Remove'),
                      Icon(Icons.cancel_outlined),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 249, 244),
      appBar: APPBAR(
        context,
      ),
      bottomNavigationBar: NavBar(),
      body: Column(children: [
        FutureBuilder(
          future: FavFuture,
          builder:
              (BuildContext context, AsyncSnapshot<List<FavModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching data.'),
              );
            } else {
              List<FavModel> favourites = snapshot.data!;

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: favourites.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: favTile(
                              favourites[index].ProductName,
                              favourites[index].UserID,
                              favourites[index].ProductPrice,
                              favourites[index].ProductSellerID,
                              favourites[index].ProductID,
                              favourites,
                              context),
                        ));
                  },
                ),
              );
            }
          },
        ),
      ]),
    );
  }
}
