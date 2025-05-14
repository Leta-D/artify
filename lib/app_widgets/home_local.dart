import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

Widget homeLocal() {
  return Container(child: Text("Home Local"));
}

class HomeLocal extends StatefulWidget {
  const HomeLocal({super.key});

  @override
  createState() => _HomeLocalState();
}

class _HomeLocalState extends State<HomeLocal> {
  List<AssetEntity> images = [];

  Future<void> requestPermissionsAndLoadImage() async {
    if (Platform.isAndroid) {
      var photosPermission = await Permission.photos.status;
      var storagePermission = await Permission.storage.status;

      if (photosPermission.isDenied || storagePermission.isDenied) {
        await Permission.photos.request();
        await Permission.storage.request();
      }
    }
    final PermissionState result = await PhotoManager.requestPermissionExtend();
    if (!result.isAuth) {
      PhotoManager.openSetting();
      return;
    }

    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: false,
    );

    List<AssetEntity> media = await albums[0].getAssetListPaged(
      page: 0,
      size: 24,
    );

    setState(() {
      images = media;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          images.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (_, index) {
                  return FutureBuilder(
                    future: images[index].thumbnailData,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return ListView(
                          children: [
                            // for(var item in snapshot.data!)
                            Image.memory(snapshot.data!),
                          ],
                        );
                      }
                    },
                  );
                },
              ),
    );
  }
}
