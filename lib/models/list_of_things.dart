// ignore_for_file: camel_case_types, non_constant_identifier_names

import '/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../Screens/availiable_items.dart';
import 'firebaseHelper.dart';

class ITEM_DETAILS {
  String Item_Name;
  String Item_Description;
  String Item_Price;
  String url1;
  String url2;
  String url3;
  ITEM_DETAILS({
    required this.Item_Name,
    required this.Item_Description,
    required this.Item_Price,
    required this.url1,
    required this.url2,
    required this.url3,
  });
}

LIST_OF_THINGS() {
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  return Expanded(
      child: StreamBuilder(
    stream: FirebaseFirestore.instance.collection('Products').snapshots(),
    builder: (context, snapshot) {
      QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
      return ListView.builder(
        itemCount: querySnapshot.docs.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
              future: (FirebaseHelper.getUserModelById('zamlt7yXatEjhNn9fk9q')),
              builder: (BuildContext context, userData) {
                if (userData.data == null) {
                  return CircularProgressIndicator();
                } else {
                  return ListTile(
                    title: Text(querySnapshot.docs[index]['Item_Name']),
                    subtitle: Text(querySnapshot.docs[index]['Item_Description']),
                    trailing: Text(querySnapshot.docs[index]['Item_Price']),
                    leading: Image.network(
                      querySnapshot.docs[index]['url1'],
                      fit: BoxFit.cover,
                    ),
                  );
                }
              });
          // return AVAILIABLE_ITEMS(info);
        },
      );
    },
  )
      // child: ListView(
      //   scrollDirection: Axis.vertical,
      //   //LOOPS AFTER CONNECT WITH DATABASE.
      //   children: [
      //     AVAILIABLE_ITEMS(info),
      //     AVAILIABLE_ITEMS(info),
      //     AVAILIABLE_ITEMS(info),
      //     AVAILIABLE_ITEMS(info),
      //     AVAILIABLE_ITEMS(info),
      //     AVAILIABLE_ITEMS(info),
      //   ],
      // ),
      );
}
