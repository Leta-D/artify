import 'package:artify/app_background/app_state_provider.dart';
import 'package:artify/app_theme/app_colors.dart';
import 'package:artify/app_widgets/future_images_list.dart';
import 'package:artify/app_widgets/home_dashboard.dart';
import 'package:artify/app_widgets/image_frames.dart';
import 'package:artify/app_widgets/main_middel_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final middelNavElemnts = [
    {"icon": CupertinoIcons.move, "label": "Random"},
    {"icon": CupertinoIcons.layers_alt, "label": "New"},
    {"icon": CupertinoIcons.money_dollar, "label": "Local"},
  ];
  final Map<String, String> dashboardEvents = {
    "beach": "Beach",
    "road": "Road",
    "city": "City",
  };
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    // final appProvider = Provider.of<AppStateProvider>(context);
    return SingleChildScrollView(
      child: SizedBox(
        height: screenSize.height * 1.31,
        child: Column(
          children: [
            homeDashboard(context, dashboardEvents),
            mainMiddelNav(context, middelNavElemnts),
            SizedBox(
              height: screenSize.height / 1.275,
              child: futureImagesList(context),
            ),
          ],
        ),
      ),
    );
  }
}
