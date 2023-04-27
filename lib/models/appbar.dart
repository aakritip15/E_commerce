// ignore_for_file: non_constant_identifier_names

import 'package:app_1/models/top.dart';
import 'package:flutter/material.dart';

AppBar APPBAR(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: TOP(
        context,
      ),
    ),
  );
}
