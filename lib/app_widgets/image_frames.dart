import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/network_control/network_object.dart';
import 'package:aaa/pages/image_view_full.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget imageFrames(BuildContext context, NetworkObject networkObject) {
  Size screenSize = MediaQuery.sizeOf(context);
  // final appProvide = Provider.of<AppStateProvider>(context);
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(4.0),
        height: screenSize.height / 5.38,
        width: screenSize.width / 3.43,
        decoration: BoxDecoration(
          color: appGrey(1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => ImageViewFull(
                      networkObject.rawUrlFull,
                      networkObject.id,
                    ),
              ),
            );
          },
          child: CachedNetworkImage(
            imageUrl: networkObject.rawUrl,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, progress) {
              return Center(
                child: SizedBox(
                  height: screenSize.width / 6,
                  width: screenSize.width / 6,
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: appProgressIndicator(1),
                  ),
                ),
              );
            },
            errorWidget:
                (context, url, error) => Image.network(networkObject.rawUrl),
            fadeInDuration: Duration(seconds: 2),
            fadeInCurve: Curves.easeIn,
          ),
        ),
      ),
      SizedBox(height: 15),
    ],
  );
}
