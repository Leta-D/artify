import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

Widget homeLocal() {
  return Container(child: Text("Home Local"));
}

class HomeLocal extends StatefulWidget {
  @override
  createState() => _HomeLocalState();
}

class _HomeLocalState extends State<HomeLocal> {
  @override
  Widget build(BuildContext context) {
    List images = [];

    Future<void> requestPermissionsAndLoadImage() async {
      if (Platform.isAndroid) {
        var photosPermission = await Permission.photos.status;
        var storagePermission = await Permission.storage.status;

        if (photosPermission.isDenied || storagePermission.isDenied) {
          await Permission.photos.request();
          await Permission.storage.request();
        }
      }
      // final PermissionStatus result = await PhotoM
    }

    return Container();
  }
}
