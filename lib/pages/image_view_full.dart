import 'dart:io';
import 'dart:ui';

import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/app_widgets/download_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class ImageViewFull extends StatefulWidget {
  final String imageFullUrl;
  final String imageSmallUrl;
  const ImageViewFull(this.imageFullUrl, this.imageSmallUrl, {super.key});
  @override
  createState() => _ImageViewFullState(imageFullUrl, imageSmallUrl);
}

class _ImageViewFullState extends State<ImageViewFull> {
  String imageFullUrl;
  String imageSmallUrl; // instad use full to download no id needed
  _ImageViewFullState(this.imageFullUrl, this.imageSmallUrl);

  bool isVisible = false;
  double posX = 0;
  double posY = 0;

  Future<Directory> getDownloadDirectory() async {
    Directory? extDir = Directory('/storage/emulated/0/Download/ArtifyImages');
    if (!await extDir.exists()) {
      await extDir.create(recursive: true);
    }
    return extDir;
  }

  Future<void> downloadImageAndSetWallpaper(
    String imageUrl,
    int location,
  ) async {
    try {
      final status = await Permission.manageExternalStorage.request();

      if (status.isDenied) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                backgroundColor: appBlack(0.9, context),
                title: Text(
                  "Permission Required",
                  style: TextStyle(
                    color: appWhite(1, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  "Please allow permission to access storage in settings.",
                  style: TextStyle(color: appWhite(1, context)),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: appRed(1), fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                    child: Text(
                      "Open Settings",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 7, 114, 255),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
        );
      }

      Directory dir = await getDownloadDirectory();

      String filename = "artify_${DateTime.now().microsecondsSinceEpoch}";

      String filePath = '${dir.path}/$filename.jpg';

      showDialog(
        context: context,
        barrierDismissible: true, // allow tapping outside
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
                          Navigator.of(context).pop(true); // Close it
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
                          Navigator.of(context).pop(false); // Don't close
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

      Dio dio = Dio();
      await dio.download(imageUrl, filePath);
      Navigator.pop(context);

      final File file = File(filePath);

      if (!file.existsSync()) {
        throw Exception("Image file not found at $filePath");
      }

      final bool result = await WallpaperManagerFlutter().setWallpaper(
        file,
        location,
      );

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
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: appBlack(0.9, context),
              title: Text(
                "Operation Failed",
                style: TextStyle(color: appRed(1), fontWeight: FontWeight.bold),
              ),
              content: Column(
                children: [
                  Icon(CupertinoIcons.clear, color: appRed(1), size: 40),
                  Text(
                    "Wallpaper set operation error, try again!",
                    style: TextStyle(color: appWhite(1, context)),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: appRed(1), fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        downloadImageAndSetWallpaper(imageUrl, location);
                      },
                      child: Text(
                        "Retry",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 7, 114, 255),
                          fontSize: 18,
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
            child: Image.network(imageSmallUrl, fit: BoxFit.cover),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: appGrey(0)),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CachedNetworkImage(
              imageUrl: imageFullUrl,
              scale: 2,
              height: screenSize.height - screenSize.height / 7,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      color: appWhite(1, context),
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) => Image.network(imageFullUrl),
              fadeInDuration: Duration(seconds: 2),
              fadeInCurve: Curves.easeIn,
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
          Positioned(
            left: posX,
            top: posY,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  posX += details.delta.dx;
                  posY += details.delta.dy;
                });
              },
              child: DownloadImageWidget(
                unsplashImageFullUrl: imageFullUrl,
                unsplashImageSmallUrl: imageSmallUrl,
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
                                downloadImageAndSetWallpaper(
                                  imageFullUrl,
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
                            // Spacer(),
                            TextButton(
                              onPressed: () {
                                downloadImageAndSetWallpaper(
                                  imageFullUrl,
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
                            // Spacer(),
                            TextButton(
                              onPressed: () {
                                downloadImageAndSetWallpaper(
                                  imageFullUrl,
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
