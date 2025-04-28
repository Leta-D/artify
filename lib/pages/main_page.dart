import 'package:artify/app_widgets/main_bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final bottomNavElemnts = [
    {"icon": CupertinoIcons.home, "label": "Home"},
    {"icon": CupertinoIcons.rectangle_grid_2x2, "label": "Catagory"},
    {"icon": CupertinoIcons.gear_alt_fill, "label": "Setting"},
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          mainBottomNav(context, bottomNavElemnts),
          Container(alignment: Alignment.center, width: screenSize.width - 30),
        ],
      ),
    );
  }
}
