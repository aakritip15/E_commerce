import 'package:flutter/material.dart';
import '/consts/colors.dart';

// this file is to create a custom textFormField which accepts color, heigt, icons everything.
// will replace all text fields of myTextField.dart

class CustomFormField extends StatefulWidget {
  const CustomFormField({super.key});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 30,
      color: kGrey,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(),
          ),
        ),
      ),
    );
  }
}
