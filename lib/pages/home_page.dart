import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_widgets/future_images_list.dart';
import 'package:aaa/app_widgets/home_dashboard.dart';
import 'package:aaa/app_widgets/home_favorite.dart';
import 'package:aaa/app_widgets/home_local.dart';
import 'package:aaa/app_widgets/main_middel_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  /*
- assets/images/collections/beatch.jpg
    - assets/images/collections/bridge.jpg
    - assets/images/collections/colorful.jpg
    - assets/images/collections/motivational.jpg
    - assets/images/collections/space.jpg
*/
  final Map<String, String> dashboardEvents = {
    "Beaches": "assets/images/collections/beatch.jpg",
    "Bridges": "assets/images/collections/bridge.jpg",
    "motivational": "assets/images/collections/motivational.jpg",
    "colorful": "assets/images/collections/colorful.jpg",
    "wallpaper space": "assets/images/collections/space.jpg",
  };

  final middelNavElemnts = [
    {"icon": CupertinoIcons.layers_alt_fill, "label": "New"},
    {"icon": CupertinoIcons.heart_fill, "label": "Favorites"},
    {"icon": CupertinoIcons.money_dollar, "label": "Local"},
  ];

  @override
  Widget build(BuildContext context) {
    final homeNavElements = [
      FutureImagesList("query", true),
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
