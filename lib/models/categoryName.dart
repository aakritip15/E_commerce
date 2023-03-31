import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

categoryName(String s) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.0),
    child: TextButton(
        onPressed: () {
          if (kDebugMode) {
            print(s);
          }
        },
        child: Text(
          s,
          style: TextStyle(color: Colors.black),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        )),
  );
}
