import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

Row TOP() {
  String NAME = 'Shashinoor';
  String INFORMATION = 'Active';
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Logo',
        style: TextStyle(color: Colors.black),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //TODO Replace with IconButton
            IconButton(
              color: Colors.brown,
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NAME,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  Text(
                    INFORMATION,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              ),
            ),

            //TODO Replace with IconButton
            Icon(
              FeatherIcons.user,
              color: Colors.brown,
            )
          ],
        ),
      )
    ],
  );
}
