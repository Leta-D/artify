import 'package:aaa/app_widgets/catagory_frams.dart';
import 'package:flutter/material.dart';

/*
- assets/images/collections/abstract.jpg
    - assets/images/collections/animals.jpg
    - assets/images/collections/archetecture.jpg
    - assets/images/collections/blackAndWhite.jpg
    - assets/images/collections/cars.jpg
    - assets/images/collections/city.jpg
    - assets/images/collections/fantacy.jpg
    - assets/images/collections/forest.jpg
    - assets/images/collections/nature.jpg
    - assets/images/collections/technology.jpg
    - assets/images/collections/underWater.jpg
*/

final collectionElements = [
  {
    "text": "Nature",
    "imgUrl": "assets/images/collections/nature.jpg",
    'query': "nature",
  },
  {
    "text": "Architecture",
    "imgUrl": "assets/images/collections/archetecture.jpg",
    'query': "architecture",
  },
  {
    "text": "Animals",
    "imgUrl": "assets/images/collections/animals.jpg",
    'query': "animal",
  },
  {
    "text": "Technology",
    "imgUrl": "assets/images/collections/technology.jpg",
    'query': "technology",
  },
  {
    "text": "Abstract",
    "imgUrl": "assets/images/collections/abstract.jpg",
    'query': "abstract",
  },
  {
    "text": "Cars",
    "imgUrl": "assets/images/collections/cars.jpg",
    'query': "car",
  },
  {
    "text": "Fantasy",
    "imgUrl": "assets/images/collections/fantacy.jpg",
    'query': "fantasy",
  },
  {
    "text": "Black and White",
    "imgUrl": "assets/images/collections/blackAndWhite.jpg",
    'query': "black and white",
  },
  {
    "text": "Underwater",
    "imgUrl": "assets/images/collections/underWater.jpg",
    'query': "Underwater",
  },
  {
    "text": "Forest",
    "imgUrl": "assets/images/collections/forest.jpg",
    'query': "forest",
  },
  {
    "text": "City",
    "imgUrl": "assets/images/collections/city.jpg",
    'query': "city",
  },
];

Widget categoryCollections(BuildContext context) {
  return ListView(
    children: [
      SizedBox(height: 100),

      for (var item in collectionElements)
        SizedBox(
          height: 250,
          child: catagoryFrames(
            item["text"]!,
            item["imgUrl"]!,
            item['query']!,
            context,
          ),
        ),
      SizedBox(height: 75),
    ],
  );
}
