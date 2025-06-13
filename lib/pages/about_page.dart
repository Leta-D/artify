import 'package:aaa/app_theme/app_colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBlack(1, context),
        foregroundColor: appWhite(1, context),
        centerTitle: true,
        title: Text(
          "About App",
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
      ),
      backgroundColor: appBlack(1, context),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              "This is a wallpaper app devloped by Leta Dejene!",
              style: TextStyle(color: appWhite(1, context)),
            ),
          ],
        ),
      ),
    );
  }
}
