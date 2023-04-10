import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class messageTextField extends StatefulWidget {
  final String? text;
  final TextEditingController messageController;

  const messageTextField({
    super.key,
    this.text,
    required this.messageController,
  });

  @override
  State<messageTextField> createState() => _messageTextFieldState();
}

class _messageTextFieldState extends State<messageTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 32, 18, 18),
      child: TextField(
          controller: widget.messageController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            suffixIcon: IconButton(
              onPressed: () {},
              icon: IconButton(
                onPressed: () {
                  print('Message sent');
                },
                icon: Icon(Icons.send),
                color: Colors.amber,
              ),
            ),
            hintText: widget.text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          )),
    );
  }
}
