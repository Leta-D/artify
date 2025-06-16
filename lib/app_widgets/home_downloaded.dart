import 'dart:io';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/pages/image_view_full_downloads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeDownloaded extends StatefulWidget {
  const HomeDownloaded({super.key});

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

  void refrashImages() async {
    setState(() {
      _images = loadDownloadedImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return SizedBox(
      height: 650,
      child: FutureBuilder<List<FileSystemEntity>>(
        future: _images,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(color: appProgressIndicator(1));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No image Downloaded",
                style: TextStyle(
                  fontSize: screenSize.width / 20,
                  foreground:
                      Paint()
                        ..shader = buttonGradient.createShader(
                          Rect.fromLTWH(0, 0.0, 130.0, 50),
                        ),
                ),
              ),
            );
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
                final file = files[index];
                return InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            backgroundColor: appBlack(0.9, context),
                            title: Icon(
                              CupertinoIcons.delete_solid,
                              size: screenSize.width / 10.275,
                              color: appRed(1),
                            ),
                            content: Padding(
                              padding: EdgeInsets.only(
                                left: screenSize.width / 5.137,
                              ),
                              child: Text(
                                "Delete photo!",
                                style: TextStyle(color: appWhite(1, context)),
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await file.delete();
                                  Navigator.pop(context);

                                  refrashImages();
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: appRed(1),
                                    fontSize: screenSize.width / 22.83,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    appRed(1),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: appWhite(1, context),
                                    fontSize: screenSize.width / 25.68,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
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
      ),
    );
  }
}
