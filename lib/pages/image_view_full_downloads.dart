import 'dart:io';
import 'dart:ui';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class ImageViewFullDownloads extends StatefulWidget {
  final String imagePath;
  const ImageViewFullDownloads(this.imagePath, {super.key});
  @override
  createState() => _ImageViewFullDownloadState(imagePath);
}

class _ImageViewFullDownloadState extends State<ImageViewFullDownloads> {
  final String imagePath;
  _ImageViewFullDownloadState(this.imagePath);

  Future<void> setImageAsWallpaper(int location) async {
    try {
      final imageFile = File(imagePath);

      if (!imageFile.existsSync()) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Icon(
                  CupertinoIcons.clear_circled,
                  color: appRed(1),
                  size: 40,
                ),
                content: Text(
                  "Can't get the image, try agin!",
                  style: TextStyle(color: appRed(1)),
                ),
              ),
        );
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              bool confirm = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: appBlack(0.9, context),
                    title: Text(
                      "Are you sure?",
                      style: TextStyle(
                        color: appRed(1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      "Do you want to close this dialog?",
                      style: TextStyle(color: appWhite(1, context)),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: appRed(1), fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          return;
                        },
                      ),
                      TextButton(
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 7, 114, 255),
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  );
                },
              );
              return confirm;
            },
            child: AlertDialog(
              backgroundColor: appBlack(0.9, context),
              title: Text(
                "Processing ...",
                style: TextStyle(
                  color: appWhite(1, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                height: 30,
                child: Column(
                  children: [
                    Text(
                      "Please wait...",
                      style: TextStyle(color: appWhite(1, context)),
                    ),
                    SizedBox(
                      width: 100,
                      height: 3,
                      child: LinearProgressIndicator(color: appRed(1)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

      final result = await WallpaperManagerFlutter().setWallpaper(
        imageFile,
        location,
      );

      Navigator.pop(context);
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: appBlack(0.8, context),
              title: Icon(
                result
                    ? CupertinoIcons.check_mark_circled
                    : CupertinoIcons.clear_circled,
                color:
                    result ? const Color.fromARGB(255, 57, 255, 7) : appRed(1),
                size: 40,
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  result
                      ? "Wallpaper successfully set!"
                      : " Wallpaper failure!",
                  style: TextStyle(color: appWhite(1, context), fontSize: 16),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(appRed(1)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: appWhite(1, context)),
                  ),
                ),
              ],
            ),
      );
    } catch (e) {
      // print(e);
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text(
                "Processing Error",
                style: TextStyle(
                  color: appWhite(1, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                "Internal error occoured try agin!",
                style: TextStyle(color: appRed(1), fontSize: 18),
              ),
            ),
      );
    }
  }

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
            child: Image.file(File(imagePath), fit: BoxFit.cover),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: appGrey(0)),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.file(
              File(imagePath),
              scale: 2,
              height: screenSize.height - screenSize.height / 7,
              fit: BoxFit.cover,
              semanticLabel: "ARTify",
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(appWhite(0.1, context)),
              ),
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                size: 30.0,
                color: appBlack(1, context),
              ),
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
                              onPressed: () {
                                setImageAsWallpaper(
                                  WallpaperManagerFlutter.lockScreen,
                                );
                              },
                              child: Text(
                                "Lock Screen",
                                style: TextStyle(
                                  color: appWhite(1, context),
                                  fontSize: screenSize.height / 45,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setImageAsWallpaper(
                                  WallpaperManagerFlutter.homeScreen,
                                );
                              },
                              child: Text(
                                "Home Screen",
                                style: TextStyle(
                                  color: appWhite(1, context),
                                  fontSize: screenSize.height / 45,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setImageAsWallpaper(
                                  WallpaperManagerFlutter.bothScreens,
                                );
                              },
                              child: Text(
                                "Both",
                                style: TextStyle(
                                  color: appWhite(1, context),
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
                              color: appWhite(1, context),
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
