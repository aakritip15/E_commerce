import 'package:flutter/material.dart';

import '../models/categories.dart';
import '../models/list_of_things.dart';
import '../models/search.dart';

Widget BODY() {
  final TextEditingController SEARCHED_ITEM = TextEditingController();
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          SEARCH(SEARCHED_ITEM),
          CATEGORIES(),
          LIST_OF_THINGS(), //Currently Hard coded name of categories as number of categories is limited can use list is more categories are to be included.
        ],
      ),
    ),
  );
}
