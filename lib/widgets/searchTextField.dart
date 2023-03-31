import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final String? text;
  final TextEditingController searchController;
  

  const SearchTextField(
      {super.key,
      this.text,
      required this.searchController,
      });

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {});
              },
            ),
            hintText: widget.text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
       
      ],
    );
  }
}
