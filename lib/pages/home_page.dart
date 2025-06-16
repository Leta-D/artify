import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/app_widgets/future_images_list.dart';
import 'package:aaa/app_widgets/home_dashboard.dart';
import 'package:aaa/app_widgets/home_downloaded.dart';
import 'package:aaa/app_widgets/home_local.dart';
import 'package:aaa/app_widgets/main_middel_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final Map<String, String> dashboardEvents = {
    "Beaches": "assets/images/collections/beatch.jpg",
    "Bridges": "assets/images/collections/bridge.jpg",
    "motivational": "assets/images/collections/motivational.jpg",
    "colorful": "assets/images/collections/colorful.jpg",
    "wallpaper space": "assets/images/collections/space.jpg",
  };

  final middelNavElemnts = [
    {"icon": CupertinoIcons.layers_alt_fill, "label": "New"},
    {"icon": CupertinoIcons.download_circle_fill, "label": "Downloads"},
    {"icon": CupertinoIcons.photo_fill_on_rectangle_fill, "label": "Gallery"},
  ];

  @override
  Widget build(BuildContext context) {
    final homeNavElements = [
      FutureImagesList("query", true),
      HomeDownloaded(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      CupertinoIcons.circle_fill,
                      color: (i == 1) ? appWhite(1, context) : appGrey(0.6),
                      size: 8,
                    ),
                  ),
              ],
            ),
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
