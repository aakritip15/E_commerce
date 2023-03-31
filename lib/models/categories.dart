import 'package:flutter/material.dart';
import 'categoryName.dart';

Widget CATEGORIES() {
  return SizedBox(
    height: 50,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryName('Educational'),
          categoryName('Drawing'),
          categoryName('Sports'),
          categoryName('Electronics'),
          categoryName('Lab Equipments'),
          categoryName('Others'),
        ],
      ),
    ),
  );
}
