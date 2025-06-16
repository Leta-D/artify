import 'dart:io';

import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/pages/image_view_full_downloads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeDownloaded extends StatefulWidget {
  @override
  _HomeDownloadedState createState() => _HomeDownloadedState();
}

class _HomeDownloadedState extends State<HomeDownloaded> {
  late Future<List<FileSystemEntity>> _images;

  Future<Directory> getDownloadDirectory() async {
    Directory? extDir = Directory('/storage/emulated/0/Download/ArtifyImages');
    if (!await extDir.exists()) {
      await extDir.create(recursive: true);
    }
    return extDir;
  }

  Future<List<FileSystemEntity>> loadDownloadedImages() async {
    final dir = await getDownloadDirectory();
    final files =
        dir
            .listSync()
            .where(
              (file) =>
                  file is File && (file.path.endsWith(".jpg")) ||
                  file.path.endsWith(".png"),
            )
            .toList();
    return files;
  }

  @override
  void initState() {
    super.initState();
    _images = loadDownloadedImages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FileSystemEntity>>(
      future: _images,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: appProgressIndicator(1));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No image Downloaded"));
        }

        final files = snapshot.data;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: files!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (_, index) {
              final file = files![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImageViewFullDownloads(file.path),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: appGrey(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.file(File(file.path), fit: BoxFit.cover),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
