// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../consts/colors.dart';

myTextField(
    {required String? text,
    required bool obscure,
    required String label,
    required TextEditingController fieldController}) {
  return TextFormField(
    obscureText: obscure,
    controller: fieldController,
    decoration: InputDecoration(
      hintText: text,
      labelText: label,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
    style: const TextStyle(fontSize: 12.0),
  );
}

textFieldSell({
  required String text,
  String hint = '',
  required TextEditingController fieldController,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 3.0,
        ),
        TextField(
          controller: fieldController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            hintText: hint,
          ),
        ),
      ],
    ),
  );
}

textFieldEditInfo({
  required TextEditingController fieldController,
  String text = '',
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: TextFormField(
      controller: fieldController,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.edit_square,
          color: kGrey,
        ),
        hintText: text,
        // contentPadding: EdgeInsets.only(left: 10.0)
        // // contentPadding: EdgeInsets.symmetric(
        // //  // horizontal: 10.0,
      ),
    ),
  );
}
