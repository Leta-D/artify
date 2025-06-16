import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/network_control/network_to_api.dart';
import 'package:aaa/pages/category_listed_image_page.dart';
import 'package:flutter/material.dart';

Widget catagoryFrames(
  String text,
  String imageUrl,
  String query,
  BuildContext context,
) {
  // List<String> idList = [];
  Future<dynamic> fetchDataAndNavigate(String text) async {
    final idList = await fetchImageCollectionId(text);
    // print("Data: $idList");
    return idList;

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => CategoryListedImagePage(text, idList)),
    // );
  }

  Size screenSize = MediaQuery.sizeOf(context);
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: appWhite(0.2, context),
      borderRadius: BorderRadius.circular(15),
    ),
    child: InkWell(
      onTap: () {
        // fetchDataAndNavigate(text);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => FutureBuilder(
                  future: fetchDataAndNavigate(text),
                  builder: (_, snapshoot) {
                    if (snapshoot.connectionState == ConnectionState.waiting) {
                      return Container(
                        color: appBlack(1, context),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 200,
                          height: 5,
                          child: LinearProgressIndicator(
                            color: appProgressIndicator(1),
                          ),
                        ),
                      );
                    } else {
                      return CategoryListedImagePage(text, snapshoot.data);
                    }
                  },
                ),
          ),
        );

        // print(text);
      },
      child: Stack(
        children: [
          Image.asset(
            imageUrl,
            height: 300,
            width: screenSize.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(
                // color: appBlack(1),
                fontSize: 35,
                fontWeight: FontWeight.bold,
                foreground:
                    Paint()
                      ..shader = buttonGradient.createShader(
                        Rect.fromLTWH(0, 0.0, 300.0, 50),
                      ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
