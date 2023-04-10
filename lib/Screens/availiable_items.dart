// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../screens/itemview.dart';
import '../models/list_of_things.dart';

AVAILIABLE_ITEMS(ITEM_DETAILS info) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 150,
          child: TextButton(
            onPressed: () {
              Item_view();
              if (kDebugMode) {
                print(
                    'Open new Window containing details view of the product.');
              }
            },
            child: Row(
              children: [
                ClipRRect(
                  child: Image.network(info.url1),
                  borderRadius: BorderRadius.circular(15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  info.Item_Name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  info.Item_Description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // ignore: prefer_interpolation_to_compose_strings
                                  Text(
                                    'PRICE:' + info.Item_Price,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  if (kDebugMode) {
                                    print('Call [Number of The Seller]');
                                  }
                                },
                                child: Icon(FeatherIcons.phone),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (kDebugMode) {
                                    print('Open Message Box directly.');
                                  }
                                },
                                child: Icon(FeatherIcons.messageCircle),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
