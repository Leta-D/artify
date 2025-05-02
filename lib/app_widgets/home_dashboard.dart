import 'dart:async';

import 'package:artify/app_background/app_state_provider.dart';
import 'package:artify/app_theme/app_colors.dart';
import 'package:artify/app_widgets/catagory_frams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// takes map that gone contain key=describing and value=imageUrl
Widget homeDashboard(
  BuildContext context,
  Map<String, String> dashboardEvents,
) {
  Size screenSize = MediaQuery.sizeOf(context);

  int _currentDashboardIndex = 0;
  final _pageControler = PageController(initialPage: _currentDashboardIndex);
  Timer.periodic(Duration(seconds: dashboardEvents.keys.length + 1), (timer) {
    if (_currentDashboardIndex < dashboardEvents.keys.length - 1) {
      _currentDashboardIndex++;
    } else {
      _currentDashboardIndex = 0;
    }
    _pageControler.animateToPage(
      _currentDashboardIndex,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  });
  return Container(
    margin: EdgeInsets.only(top: 15),
    padding: EdgeInsets.all(20),
    width: screenSize.width - 30,
    height: screenSize.height / 3.6,
    decoration: BoxDecoration(
      color: appWhite(1),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: PageView(
      controller: _pageControler,
      children: [
        for (var key in dashboardEvents.keys)
          catagoryFrames(key, dashboardEvents[key]!),
      ],
    ),
  );
}
