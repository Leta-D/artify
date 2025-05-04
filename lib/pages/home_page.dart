import 'package:artify/app_background/app_state_provider.dart';
import 'package:artify/app_theme/app_colors.dart';
import 'package:artify/app_widgets/future_images_list.dart';
import 'package:artify/app_widgets/home_dashboard.dart';
import 'package:artify/app_widgets/home_favorite.dart';
import 'package:artify/app_widgets/home_local.dart';
import 'package:artify/app_widgets/image_frames.dart';
import 'package:artify/app_widgets/main_middel_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Map<String, String> dashboardEvents = {
    "Beaches": "Beach",
    "Bridges": "NaN",
    "Colorful": "City",
    "Fashion": "City",
  };

  final middelNavElemnts = [
    {"icon": CupertinoIcons.layers_alt_fill, "label": "New"},
    {"icon": CupertinoIcons.heart_fill, "label": "Favorites"},
    {"icon": CupertinoIcons.money_dollar, "label": "Local"},
  ];

  @override
  Widget build(BuildContext context) {
    final homeNavElements = [
      futureImagesList(context),
      homeFavorite(),
      homeLocal(),
    ];
    final screenSize = MediaQuery.sizeOf(context);
    final appProvider = Provider.of<AppStateProvider>(context);
    return SingleChildScrollView(
      child: SizedBox(
        height: screenSize.height * 1.31,
        child: Column(
          children: [
            homeDashboard(context, dashboardEvents),
            mainMiddelNav(context, middelNavElemnts, true),
            SizedBox(
              height: screenSize.height / 1.275,
              child: homeNavElements[appProvider.mainMiddelNavIndex],
            ),
          ],
        ),
      ),
    );
  }
}
