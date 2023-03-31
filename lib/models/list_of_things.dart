// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'availiable_items.dart';

class ITEM_DETAILS {
  String Item_Name;
  String Item_Description;
  String Item_Price;
  String url;
  ITEM_DETAILS(
      {required this.Item_Name,
      required this.Item_Description,
      required this.Item_Price,
      required this.url});
}

LIST_OF_THINGS() {
  //object of the class named ITEM_DETAILS
  //duita info farak ho euta argument arko parameter ho
  var info = ITEM_DETAILS(
      Item_Name: 'Name',
      Item_Description:
          'in my implementation I put this inside a row and surrounded it with sized boxes on each side so that I have some space between my elements, why using expanded you may ask, well its used to take as much space as possible so the text would look good in portrait or landscape mode.',
      Item_Price: '1000',
      url: 'https://picsum.photos/150?image=8');
  return Expanded(
    child: ListView(
      scrollDirection: Axis.vertical,
      //LOOPS AFTER CONNECT WITH DATABASE.
      children: [
        AVAILIABLE_ITEMS(info),
        AVAILIABLE_ITEMS(info),
        AVAILIABLE_ITEMS(info),
        AVAILIABLE_ITEMS(info),
        AVAILIABLE_ITEMS(info),
        AVAILIABLE_ITEMS(info),
      ],
    ),
  );
}
