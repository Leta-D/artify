import 'package:artify2/app_theme/app_colors.dart';
import 'package:artify2/app_widgets/image_frames.dart';
import 'package:artify2/network_control/network_to_api.dart';
import 'package:flutter/material.dart';

class SearchImageList extends StatefulWidget {
  final String title;
  final bool isHome;
  const SearchImageList(this.title, this.isHome, {super.key});
  @override
  createState() => _SearchImageListState(title, isHome);
}

class _SearchImageListState extends State<SearchImageList> {
  final String title;
  bool isHome;
  _SearchImageListState(this.title, this.isHome);

  final ScrollController _scrollController = ScrollController();
  // bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  int counter = 1;
  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      setState(() {
        counter = (counter == 10) ? 0 : counter + 1;
      });
      print("End");
      // return fetchImageByCollectionId(allRelatedCollectionId![counter]);
    }
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
      backgroundColor: appBlack(1),
      body: FutureBuilder(
        future: SearchData(title, counter, false),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(color: appWhite(1)),
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
                            padding: EdgeInsets.symmetric(horizontal: 7),
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
