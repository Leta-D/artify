import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/pages/image_view_full_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

Widget homeLocal() {
  // return Container(child: Text("Home Local"));
  return SizedBox(height: 650, child: HomeLocal());
}

class HomeLocal extends StatefulWidget {
  const HomeLocal({super.key});

  @override
  createState() => _HomeLocalState();
}

class _HomeLocalState extends State<HomeLocal> {
  List<AssetEntity> images = [];

  @override
  void initState() {
    super.initState();
    requestPermissionsAndLoadImage();
  }

  Future<void> requestPermissionsAndLoadImage() async {
    final PermissionState result = await PhotoManager.requestPermissionExtend();
    print(result.hasAccess);
    if (!result.isAuth) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: appBlack(0.9),
              title: Text(
                "Permission Required",
                style: TextStyle(
                  color: appWhite(1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                "Please allow permission to access photo from settings.",
                style: TextStyle(color: appWhite(1)),
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
                    // openAppSettings();
                    PhotoManager.openSetting();
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
      return;
    }

    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );
    if (albums.isNotEmpty) {
      int count = await albums[0].assetCountAsync;
      final List<AssetEntity> media = await albums[0].getAssetListPaged(
        page: 0,
        size: count, // increase size to get more images
      );

      setState(() {
        images = media;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: appBlack(1),
      body:
          images.isEmpty
              ? Center(
                child: CircularProgressIndicator(
                  color: appProgressIndicator(1),
                ),
              )
              : Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (_, index) {
                    return FutureBuilder(
                      future: images[index].thumbnailDataWithSize(
                        ThumbnailSize(200, 200),
                      ),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: appProgressIndicator(1),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return Container(
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: appGrey(1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (_) => AlertDialog(
                                        backgroundColor: appBlack(0.9),
                                        title: Icon(
                                          CupertinoIcons.delete_solid,
                                          size: 40,
                                          color: appRed(1),
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 80,
                                          ),
                                          child: Text(
                                            "Delete photo!",
                                            style: TextStyle(
                                              color: appWhite(1),
                                            ),
                                          ),
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceAround,
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              await PhotoManager.editor
                                                  .deleteWithIds([
                                                    images[index].id,
                                                  ]);
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: appRed(1),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                    appRed(1),
                                                  ),
                                            ),
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: appWhite(1),
                                                fontSize: 16,
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
                                    builder:
                                        (_) => ImageViewFullLocal(
                                          snapshot.data!,
                                          images[index],
                                        ),
                                  ),
                                );
                              },
                              child: Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else {
                          return Container(color: appGrey(1));
                        }
                      },
                    );
                  },
                ),
              ),
    );
  }
}
