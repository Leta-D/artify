import 'dart:io';
import 'package:artify/app_theme/app_colors.dart';
import 'package:artify/network_control/network_to_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadImageWidget extends StatelessWidget {
  final String unsplashImageUrl; // The actual image URL (after redirect)

  DownloadImageWidget({required this.unsplashImageUrl});

  Future<void> downloadImage(BuildContext context) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Storage permission denied')));
      return;
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final savePath = '${tempDir.path}/downloaded_image.jpg';

      final dio = Dio();
      await dio.download(unsplashImageUrl, savePath);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Downloaded to $savePath')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: appBlack(1),
      foregroundColor: appWhite(1),
      onPressed: () {
        print("Download: $unsplashImageUrl");
        // fetchDownloadLocation(unsplashImageUrl);
        downloadUnsplashImage(unsplashImageUrl);
      },
      child: Icon(CupertinoIcons.down_arrow),
    );
    // return ElevatedButton.icon(
    //   icon: Icon(Icons.download),
    //   label: Text('Download Image'),
    //   onPressed: () => downloadImage(context),
    // );
  }
}
