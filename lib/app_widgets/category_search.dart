import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/app_widgets/future_images_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final Map<String, String> unsplashTopics = {
  "Animals": "Animals",
  "Athletics": "Athletics",
  "Architecture": "Architecture",
  "Arts & Culture": "Arts & Culture",
  "Business & Work": "Business & Work",
  "Current Events": "Current Events",
  "Experimental": "Experimental",
  "Fashion": "Fashion",
  "Film": "Film",
  "Food & Drink": "Food & Drink",
  "Health & Wellness": "Health & Wellness",
  "History": "History",
  "Interiors": "Interiors",
  "Nature": "Nature",
  "People": "People",
  "Spirituality": "Spirituality",
  "Technology": "Technology",
  "Textures & Patterns": "Textures & Patterns",
  "Travel": "Travel",
  "Wallpapers": "Wallpapers",
};

class CategorySearch extends StatelessWidget {
  const CategorySearch({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    final appProvider = Provider.of<AppStateProvider>(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: screenSize.height / 7.4),
          padding: EdgeInsets.symmetric(horizontal: screenSize.width / 36),
          child: SearchBar(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: screenSize.width / 36),
            ),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: screenSize.width / 14.4,
                fontWeight: FontWeight.w500,
                foreground:
                    Paint()
                      ..shader = buttonGradient.createShader(
                        Rect.fromLTWH(0, 0.0, 140.0, 50),
                      ),
              ),
            ),
            leading: Icon(
              CupertinoIcons.search,
              color: const Color.fromARGB(255, 216, 6, 6),
              size: screenSize.width / 12,
            ),
            hintText: appProvider.searchText,
            hintStyle: WidgetStateProperty.all(
              TextStyle(color: appWhite(0.6), fontSize: 25),
            ),

            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            surfaceTintColor: WidgetStateProperty.all(appGrey(0.5)),
            backgroundColor: WidgetStateProperty.all(appWhite(0.4)),
            overlayColor: WidgetStateProperty.all(appBlack(0.7)),
            shadowColor: WidgetStateProperty.all(appBlack(1)),

            onSubmitted: (value) {
              appProvider.changeSearchText(value);
              print(value);
            },
          ),
        ),
        Container(
          height: screenSize.height / 1.48,
          color: appGrey(1),
          margin: EdgeInsets.symmetric(vertical: screenSize.height / 74),
          // child: FutureImagesList(
          //   appProvider.searchText,
          //   false,
          // ), // create future biulder that willreturn list view
          child: FutureImagesList(
            (appProvider.searchText == "Search...")
                ? "black"
                : appProvider.searchText,
            false,
          ),
        ),
      ],
    );
  }
}
