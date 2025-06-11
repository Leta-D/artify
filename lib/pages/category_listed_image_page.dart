import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/app_widgets/image_frames.dart';
import 'package:aaa/network_control/network_to_api.dart';
import 'package:flutter/material.dart';

class CategoryListedImagePage extends StatefulWidget {
  final String title;
  final List<String>? allRelatedCollectionId;
  const CategoryListedImagePage(
    this.title,
    this.allRelatedCollectionId, {
    super.key,
  });
  @override
  createState() => _CategoryListedImagePageState(title, allRelatedCollectionId);
}

class _CategoryListedImagePageState extends State<CategoryListedImagePage> {
  final String title;
  final List<String>? allRelatedCollectionId;
  _CategoryListedImagePageState(this.title, this.allRelatedCollectionId);

  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  int counter = 0;
  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      setState(() {
        counter =
            (counter + 1 == currentCollectionIds.length) ? 0 : counter + 1;
      });
      print("End");
      // return fetchImageByCollectionId(allRelatedCollectionId![counter]);
    }
    return;
  }

  List allImages = [];
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        titleSpacing: 10,
        titleTextStyle: TextStyle(
          fontSize: screenSize.width / 12,
          fontWeight: FontWeight.bold,
          foreground:
              Paint()
                ..shader = buttonGradient.createShader(
                  Rect.fromLTWH(0, 0.0, 220.0, 50),
                ),
        ),
        backgroundColor: appBlack(0.9),
        foregroundColor: appWhite(1),
      ),
      backgroundColor: appBlack(1),
      body:
          allRelatedCollectionId == null
              ? Center(
                child: Text(
                  "Content can't be loaded please\n  CHECK YOUR NETWORK !",
                  style: TextStyle(
                    fontSize: screenSize.width / 20,
                    foreground:
                        Paint()
                          ..shader = buttonGradient.createShader(
                            Rect.fromLTWH(0, 0.0, 130.0, 50),
                          ),
                  ),
                ),
              )
              : FutureBuilder(
                future: fetchImageByCollectionId(
                  allRelatedCollectionId![counter],
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          color: appProgressIndicator(1),
                        ),
                      ),
                    );
                  } else {
                    if (snapshot.hasData) {
                      allImages += snapshot.data;
                      return Container(
                        color: appBlack(1),
                        child: ListView(
                          controller: _scrollController,
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                for (var item in allImages)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 7,
                                    ),
                                    child: imageFrames(context, item),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Content can't be loaded please\n  CHECK YOUR NETWORK !",
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
                  }
                },
              ),
    );
  }
}
