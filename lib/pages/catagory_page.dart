import 'package:artify/app_theme/app_colors.dart';
import 'package:artify/app_widgets/catagory_frams.dart';
import 'package:flutter/material.dart';

class CatagoryPage extends StatelessWidget {
  const CatagoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return SizedBox(
      height: screenSize.height,
      child: ListView(
        children: [
          // for (int i = 0; i < 10; i++)
          SizedBox(
            width: 340,
            height: 200,
            child: catagoryFrames("Leta", "ImageUrl"),
          ),
          SizedBox(
            width: 340,
            height: 200,
            child: catagoryFrames("me", "ImageUrl"),
          ),
        ],
      ),
    );
  }
}
