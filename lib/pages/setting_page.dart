import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/pages/about_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppStateProvider>(context);
    Widget textWithUnderline(String text) {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                color: appWhite(0.8, context),
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
          ),
          Container(height: 1, color: appGrey(0.5)),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        // shape: Border(bottom: BorderSide(color: appWhite(0.3))),
        centerTitle: true,
        title: Text(
          "App Settings",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            foreground:
                Paint()
                  ..shader = buttonGradient.createShader(
                    Rect.fromLTWH(0, 0.0, 360.0, 40),
                  ),
          ),
        ),
        backgroundColor: appBlack(1, context),
      ),
      backgroundColor: appBlack(1, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            textWithUnderline("APPEARANCE"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        appProvider.changeAppearanceMode(false);
                        setApearaceMode(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(left: 40, top: 40),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 167, 165, 165),
                          border:
                              !appProvider.appearanceMode
                                  ? Border.all(
                                    color: appWhite(1, context),
                                    width: 2,
                                  )
                                  : Border(),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          width: !appProvider.appearanceMode ? 120 : 90,
                          height: !appProvider.appearanceMode ? 70 : 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                            ),
                          ),
                          child: Icon(CupertinoIcons.sun_max_fill),
                        ),
                      ),
                    ),
                    Text(
                      "Light",
                      style: TextStyle(
                        color: appWhite(1, context),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        appProvider.changeAppearanceMode(true);
                        setApearaceMode(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(left: 40, top: 40),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 44, 44, 44),
                          border:
                              appProvider.appearanceMode
                                  ? Border.all(
                                    color: appWhite(1, context),
                                    width: 2,
                                  )
                                  : Border(),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          width: appProvider.appearanceMode ? 120 : 90,
                          height: appProvider.appearanceMode ? 70 : 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 17, 16, 16),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                            ),
                          ),
                          child: Icon(
                            CupertinoIcons.moon_fill,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Dark",
                      style: TextStyle(
                        color: appWhite(1, context),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutPage()),
                  ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ABOUT",
                          style: TextStyle(
                            color: appWhite(0.8, context),
                            fontSize: 18,
                            letterSpacing: 2,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.forward,
                          color: appWhite(1, context),
                        ),
                      ],
                    ),
                    Container(height: 1, color: appGrey(0.5)),
                  ],
                ),
              ),
            ),
            textWithUnderline("CONTACT DEVELOPER"),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "GitHub",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        foreground:
                            Paint()
                              ..shader = buttonGradient.createShader(
                                Rect.fromLTWH(0, 0.0, 360.0, 40),
                              ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Linkiden",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        foreground:
                            Paint()
                              ..shader = buttonGradient.createShader(
                                Rect.fromLTWH(0, 0.0, 360.0, 40),
                              ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Instagram",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        foreground:
                            Paint()
                              ..shader = buttonGradient.createShader(
                                Rect.fromLTWH(0, 0.0, 360.0, 40),
                              ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "telegram",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        foreground:
                            Paint()
                              ..shader = buttonGradient.createShader(
                                Rect.fromLTWH(0, 0.0, 360.0, 40),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            textWithUnderline("SUGGESTIONS"),
            TextField(
              decoration: InputDecoration(
                hintText: "Any suggestion on the app?",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
