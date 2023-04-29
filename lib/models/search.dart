import 'package:flutter/material.dart';

Padding SEARCH(TextEditingController searchedItem) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: searchedItem,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    ),
  );
}
