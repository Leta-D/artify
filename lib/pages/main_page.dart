import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/app_widgets/main_bottom_nav.dart';
import 'package:aaa/pages/catagory_page.dart';
import 'package:aaa/pages/home_page.dart';
import 'package:aaa/pages/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final pages = [HomePage(), CatagoryPage(), SettingPage()];
  final bottomNavElemnts = [
    {"icon": CupertinoIcons.home, "label": "Home"},
    {"icon": CupertinoIcons.rectangle_grid_2x2, "label": "Catagory"},
    {"icon": CupertinoIcons.gear_alt_fill, "label": "Setting"},
  ];

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppStateProvider>(context);
    return Scaffold(
      backgroundColor: appBlack(1, context),
      body: SafeArea(
        child: Stack(
          children: [
            pages[appProvider.mainBottomNavIndex],
            mainBottomNav(context, bottomNavElemnts),
          ],
        ),
      ),
    );
  }
}
