import 'dart:io';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadImageWidget extends StatefulWidget {
  final String unsplashImageFullUrl;
  final String unsplashImageSmallUrl;
  const DownloadImageWidget({
    super.key,
    required this.unsplashImageFullUrl,
    required this.unsplashImageSmallUrl,
  });

  @override
  _DownloadImageWidgetState createState() => _DownloadImageWidgetState(
    unsplashImageFullUrl: unsplashImageFullUrl,
    unsplashImageSmallUrl: unsplashImageSmallUrl,
  );
}

class _DownloadImageWidgetState extends State<DownloadImageWidget> {
  final String unsplashImageSmallUrl;
  final String unsplashImageFullUrl;

  _DownloadImageWidgetState({
    required this.unsplashImageFullUrl,
    required this.unsplashImageSmallUrl,
  });

  Future<Directory> getDownloadDirectory() async {
    Directory? extDir = Directory('/storage/emulated/0/Download/ArtifyImages');
    if (!await extDir.exists()) {
      await extDir.create(recursive: true);
    }
    return extDir;
  }

  Future<void> downloadImageCustomNot(String imageUrl) async {
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

      await FlutterDownloader.enqueue(
        url: imageUrl,
        savedDir: dir.path,
        fileName: 'artify_${DateTime.now().microsecondsSinceEpoch}.jpg',
        showNotification: true,
        openFileFromNotification: false,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: appBlack(0.9, context),
              title: Text(
                "Download Error",
                style: TextStyle(
                  color: appWhite(1, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                children: [
                  Icon(CupertinoIcons.clear, color: appRed(1), size: 40),
                  Text(
                    "Image downloading error, try again!",
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
    return FloatingActionButton(
      backgroundColor: appBlack(1, context),
      foregroundColor: appWhite(1, context),
      onPressed: () async {
        await showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                backgroundColor: appBlack(0.9, context),
                title: Text(
                  "Select Download Quality",
                  style: TextStyle(
                    color: appWhite(1, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  "Please choose image quality to download",
                  style: TextStyle(color: appWhite(1, context)),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      downloadImageCustomNot(unsplashImageSmallUrl);
                    },
                    child: Text(
                      "Low",
                      style: TextStyle(color: appRed(1), fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      downloadImageCustomNot(unsplashImageFullUrl);
                    },
                    child: Text(
                      "High",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 7, 114, 255),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
        );
      },
      child: Icon(CupertinoIcons.down_arrow),
    );
  }
}
