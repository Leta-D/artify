import 'dart:convert';
import 'dart:ui';

import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/app_widgets/download_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageViewFullLocal extends StatefulWidget {
  Uint8List imageLoc;
  AssetEntity imageFile;
  ImageViewFullLocal(this.imageLoc, this.imageFile, {super.key});
  @override
  createState() => _ImageViewFullLocalState(imageLoc, imageFile);
}

class _ImageViewFullLocalState extends State<ImageViewFullLocal> {
  Uint8List imageLoc;
  AssetEntity imageFile;
  _ImageViewFullLocalState(this.imageLoc, this.imageFile);

  bool isVisible = false;
  double posX = 0;
  double posY = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    if (posX == 0 && posY == 0 ||
        posX < 0 ||
        posY < 0 ||
        posX > screenSize.width - 30 ||
        posY > screenSize.height - 30) {
      posX = screenSize.width / 1.23;
      posY = screenSize.height / 1.35;
    }
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: screenSize.height,
            height: screenSize.height,
            child: Image.memory(imageLoc, fit: BoxFit.cover),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: appGrey(0)),
          ),
          FutureBuilder(
            future: imageFile.file,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: appProgressIndicator(1),
                  ),
                );
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.file(
                    snapshot.data!,
                    scale: 2,
                    height: screenSize.height - screenSize.height / 7,
                    fit: BoxFit.cover,
                    semanticLabel: "ARTify",
                  ),
                );
              } else {
                return Container(color: appGrey(1));
              }
            },
          ),

          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(appWhite(0.1)),
              ),
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(CupertinoIcons.back, size: 30.0, color: appBlack(1)),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedOpacity(
                opacity: isVisible ? 1 : 0,
                duration: Duration(milliseconds: 900),
                child: AnimatedSlide(
                  offset: isVisible ? Offset.zero : Offset(0, 1),
                  duration: Duration(milliseconds: 100),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.4,
                        child: Container(
                          height: screenSize.height / 5,
                          width: screenSize.width / 2.7,
                          decoration: BoxDecoration(
                            gradient: buttonGradient,
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              top: BorderSide(
                                color: appProgressIndicator(1),
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Lock Screen",
                                style: TextStyle(
                                  color: appWhite(1),
                                  fontSize: screenSize.height / 45,
                                ),
                              ),
                            ),
                            // Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Home Screen",
                                style: TextStyle(
                                  color: appWhite(1),
                                  fontSize: screenSize.height / 45,
                                ),
                              ),
                            ),
                            // Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Both",
                                style: TextStyle(
                                  color: appWhite(1),
                                  fontSize: screenSize.height / 45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: screenSize.width / 2.7,
                  height: screenSize.height / 18.3,
                  child: Material(
                    type: MaterialType.canvas,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      onTap: () {
                        print("Set wallpeper");
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: buttonGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            !isVisible ? "Set as" : "Cancel",
                            style: TextStyle(
                              fontSize: screenSize.height / 36.6,
                              color: appWhite(1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
