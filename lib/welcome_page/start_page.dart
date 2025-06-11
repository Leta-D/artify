import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_widgets/app_start_bottom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    final appStateProvider = Provider.of<AppStateProvider>(context);
    final startPageBottoms = [
      {
        "title": "Artify-Wallpaper",
        "message":
            "On this app you can find awsome wallpapers with many varities to choose from",
        "buttonText": " Next  ",
      },
      {
        "title": "All in one Artify-Wallpaper",
        "message":
            "On this app you can find awsome wallpapers with many varities to choose from",
        "buttonText": " Start  ",
      },
    ];
    final backgroundImages = [
      "assets/images/background2.jpg",
      "assets/images/background3.jpg",
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 10.0 * appStateProvider.startBottomIndex,
            ),
            child: Image.asset(
              backgroundImages[appStateProvider.startBottomIndex],
              height:
                  (appStateProvider.startBottomIndex != 1)
                      ? screenSize.height - screenSize.height / 6.9
                      : null,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: appStartBottom(context, startPageBottoms),
          ),
        ],
      ),
    );
  }
}
