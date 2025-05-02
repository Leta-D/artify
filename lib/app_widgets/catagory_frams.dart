import 'package:artify/app_theme/app_colors.dart';
import 'package:artify/network_control/network_to_api.dart';
import 'package:flutter/material.dart';

Widget catagoryFrames(String text, String imageUrl) {
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: appGrey(1),
      borderRadius: BorderRadius.circular(15),
    ),
    child: InkWell(
      onTap: () {
        // print(featchData("God"));
      },
      child: Stack(
        children: [
          // Container(color: appWhite(1)),
          Center(
            child: Text(
              text,
              style: TextStyle(color: appBlack(1), fontSize: 35),
            ),
          ),
        ],
      ),
    ),
  );
}
