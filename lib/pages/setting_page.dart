import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/pages/about_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> _launchURL(BuildContext context, String urlLink) async {
    final Uri url = Uri.parse(urlLink);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: appBlack(0.9, context),
              title: Text(
                "Link Error",
                style: TextStyle(
                  color: appWhite(1, context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                "Error, Can't redirect to link now!",
                style: TextStyle(color: appWhite(1, context)),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(color: appWhite(1, context)),
                  ),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppStateProvider>(context);
    Size screenSize = MediaQuery.sizeOf(context);
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
            fontSize: screenSize.width / 13.7,
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
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width / 41.1,
          vertical: screenSize.height / 45.85,
        ),
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
                        margin: EdgeInsets.only(top: screenSize.height / 45.85),
                        padding: EdgeInsets.only(
                          left: screenSize.width / 10.275,
                          top: screenSize.height / 22.93,
                        ),
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
                          width:
                              !appProvider.appearanceMode
                                  ? screenSize.width / 3.425
                                  : screenSize.width / 4.56,
                          height:
                              !appProvider.appearanceMode
                                  ? screenSize.height / 13.1
                                  : screenSize.height / 18.34,
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
                        fontSize: screenSize.width / 22.83,
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
                        margin: EdgeInsets.only(top: screenSize.height / 45.85),
                        padding: EdgeInsets.only(
                          left: screenSize.width / 10.275,
                          top: screenSize.height / 22.93,
                        ),
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
                          width:
                              appProvider.appearanceMode
                                  ? screenSize.width / 3.425
                                  : screenSize.width / 4.56,
                          height:
                              appProvider.appearanceMode
                                  ? screenSize.height / 13.1
                                  : screenSize.height / 18.34,
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
                        fontSize: screenSize.width / 22.83,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height / 18.34),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ENABLE VIBRATION",
                        style: TextStyle(
                          color: appWhite(0.8, context),
                          fontSize: screenSize.width / 22.83,
                          letterSpacing: 2,
                        ),
                      ),
                      Switch(
                        value: appProvider.appVibration,
                        onChanged: (value) {
                          appProvider.changeAppVibration(
                            !appProvider.appVibration,
                          );
                        },
                        activeColor: appBlack(1, context),
                        inactiveThumbColor: appProgressIndicator(1),
                        activeTrackColor: appProgressIndicator(0.7),
                        inactiveTrackColor: const Color.fromARGB(
                          255,
                          165,
                          160,
                          158,
                        ),
                        trackOutlineColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 1, color: appGrey(0.5)),
                ],
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutPage()),
                  ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height / 18.34,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ABOUT",
                          style: TextStyle(
                            color: appWhite(0.8, context),
                            fontSize: screenSize.width / 22.83,
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
              padding: EdgeInsets.only(
                top: screenSize.height / 91.7,
                bottom: screenSize.height / 18.34,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed:
                        () => _launchURL(context, "https://github.com/Leta-D"),
                    child: Text(
                      "GitHub",
                      style: TextStyle(
                        fontSize: screenSize.width / 25.68,
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
                    onPressed:
                        () => _launchURL(context, "https://github.com/Leta-D"),
                    child: Text(
                      "Linkiden",
                      style: TextStyle(
                        fontSize: screenSize.width / 25.68,
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
                    onPressed:
                        () => _launchURL(
                          context,
                          "https://instagram.com/leta_a2z",
                        ),
                    child: Text(
                      "Instagram",
                      style: TextStyle(
                        fontSize: screenSize.width / 25.68,
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
                    onPressed:
                        () => _launchURL(context, "https://t.me/Leta_d1"),
                    child: Text(
                      "telegram",
                      style: TextStyle(
                        fontSize: screenSize.width / 25.68,
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
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: screenSize.height / 9.17),
                child: Text(
                  '\u00A9 2025 devloped by LETA DEJENE',
                  style: TextStyle(color: appGrey(1), fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
