import 'dart:ui';

import 'package:artify/app_background/app_state_provider.dart';
import 'package:artify/app_theme/app_colors.dart';
import 'package:artify/network_control/network_object.dart';
import 'package:artify/network_control/network_to_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageViewFull extends StatefulWidget {
  String imageUrl;
  ImageViewFull(this.imageUrl);
  @override
  createState() => _ImageViewFullState(imageUrl);
}

class _ImageViewFullState extends State<ImageViewFull> {
  String imageUrl;
  _ImageViewFullState(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: screenSize.height,
          height: screenSize.height,
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: appGrey(0)),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, progress) {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: appWhite(1),
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) => Image.network(imageUrl),
            fadeInDuration: Duration(seconds: 2),
            fadeInCurve: Curves.easeIn,
          ),
        ),
        // InkWell(child: Container()),
      ],
    );
  }
}
