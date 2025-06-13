import 'dart:async';

import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/app_widgets/catagory_frams.dart';
import 'package:flutter/material.dart';

// takes map that gone contain key=describing and value=imageUrl
Widget homeDashboard(
  BuildContext context,
  Map<String, String> dashboardEvents,
) {
  Size screenSize = MediaQuery.sizeOf(context);

  int currentDashboardIndex = 0;
  final pageControler = PageController(initialPage: currentDashboardIndex);
  Timer.periodic(Duration(seconds: dashboardEvents.keys.length + 1), (timer) {
    if (currentDashboardIndex < dashboardEvents.keys.length - 1) {
      currentDashboardIndex++;
    } else {
      currentDashboardIndex = 0;
    }
    pageControler.animateToPage(
      currentDashboardIndex,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  });
  return Container(
    margin: EdgeInsets.only(top: 15),
    padding: EdgeInsets.all(2),
    width: screenSize.width - 10,
    height: screenSize.height / 3.6,
    decoration: BoxDecoration(
      color: appBlack(1, context),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: PageView(
      controller: pageControler,
      children: [
        for (var key in dashboardEvents.keys)
          catagoryFrames(
            key,
            dashboardEvents[key]!,
            dashboardEvents[key]!,
            context,
          ),
      ],
    ),
  );
}
