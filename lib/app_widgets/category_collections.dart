import 'package:artify/app_widgets/catagory_frams.dart';
import 'package:flutter/material.dart';

final collectionElements = [
  {"text": "Nature", "imgUrl": ""},
  {"text": "Architecture", "imgUrl": ""},
  {"text": "Animals", "imgUrl": ""},
  {"text": "Technology", "imgUrl": ""},
  {"text": "Abstract", "imgUrl": ""},
  {"text": "Cars", "imgUrl": ""},
  {"text": "Fantasy", "imgUrl": ""},
  {"text": "Black and White", "imgUrl": ""},
  {"text": "Underwater", "imgUrl": ""},
];

Widget categoryCollections() {
  return ListView(
    children: [
      SizedBox(height: 100),

      for (var item in collectionElements)
        SizedBox(
          height: 250,
          child: catagoryFrames(item["text"]!, item["imgUrl"]!),
        ),
      SizedBox(height: 75),
    ],
  );
}
