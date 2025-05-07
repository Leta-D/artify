import 'package:artify/app_theme/app_colors.dart';
import 'package:artify/network_control/network_to_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget catagoryFrames(
  String text,
  String imageUrl,
  String query,
  BuildContext context,
) {
  Size screenSize = MediaQuery.sizeOf(context);
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: appWhite(0.2),
      borderRadius: BorderRadius.circular(15),
    ),
    child: InkWell(
      onTap: () {
        fetchImageCollectionId(query);
        print(text);
      },
      child: Stack(
        children: [
          Image.asset(
            imageUrl,
            height: 300,
            width: screenSize.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(
                // color: appBlack(1),
                fontSize: 35,
                fontWeight: FontWeight.bold,
                foreground:
                    Paint()
                      ..shader = buttonGradient.createShader(
                        Rect.fromLTWH(0, 0.0, 300.0, 50),
                      ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
