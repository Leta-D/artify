// import 'dart:typed_data';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadImageWidget extends StatelessWidget {
  final String unsplashImageUrl; // The actual image URL (after redirect)

  const DownloadImageWidget({super.key, required this.unsplashImageUrl});

  Future<void> downloadImage(BuildContext context) async {
    print("Hello");
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Storage permission denied')));
      return;
    }

    // final dio = Dio();

    try {
      final response = await Dio().get(
        unsplashImageUrl,
        options: Options(
          headers: {
            'Authorization':
                'Client-ID DrnfEhU__6t1Tm_cP7jvKg2cph858pOWYDELjLCWBno',
          },
          responseType: ResponseType.bytes,
          followRedirects: false,
          // validateStatus: (status) => status == 302,
        ),
      );
      if (response.statusCode == 200) {
        // Uint8List imageBytes = response.data;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Downloaded to ')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: appBlack(1, context),
      foregroundColor: appWhite(1, context),
      onPressed: () {
        // print("Download: $unsplashImageUrl");
        downloadImage(context);
        // fetchDownloadLocation(unsplashImageUrl);
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
