import 'package:app_1/models/top.dart';
import 'package:flutter/material.dart';

AppBar APPBAR() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: TOP(),
    ),
  );
}
