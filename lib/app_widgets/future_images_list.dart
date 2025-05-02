import 'package:artify/app_widgets/image_frames.dart';
import 'package:artify/network_control/network_to_api.dart';
import 'package:flutter/material.dart';

Widget futureImagesList(BuildContext context) {
  final _scrollController = ScrollController();
  _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent)
      print("End");
  });

  return FutureBuilder(
    future: fetchData("query", 1),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(),
        );
      } else {
        if (snapshot.hasData) {
          return ListView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              Wrap(
                spacing: 10,
                direction: Axis.horizontal,
                children: [
                  for (var item in snapshot.data) imageFrames(context, item),
                ],
              ),
            ],
          );
        } else {
          return Center(
            child: Text("Error occoured!", style: TextStyle(fontSize: 20)),
          );
        }
      }
    },
  );
}
