import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget mainMiddelNav(
  BuildContext context,
  List<Map<String, dynamic>> elements,
  bool isHomePage,
) {
  Size screenSize = MediaQuery.sizeOf(context);
  final appStateProvider = Provider.of<AppStateProvider>(context);
  int currentIndex =
      isHomePage
          ? appStateProvider.mainMiddelNavIndex
          : appStateProvider.categoryNavIndex;
  return Container(
    margin: EdgeInsets.all(screenSize.width / 20.6),
    height: screenSize.height / 10.7,
    decoration: BoxDecoration(
      color: appBlack(1, context),
      borderRadius: BorderRadius.circular(screenSize.width / 13.7),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (var element in elements)
          InkWell(
            onTap: () {
              isHomePage
                  ? appStateProvider.changeMainMiddelNavIndex(
                    elements.indexOf(element),
                  )
                  : appStateProvider.changeCategoryNavIndex(
                    elements.indexOf(element),
                  );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.width / 41.5),
              width:
                  (currentIndex == elements.indexOf(element))
                      ? screenSize.width / 3
                      : null,
              decoration: BoxDecoration(
                gradient:
                    (currentIndex == elements.indexOf(element))
                        ? buttonGradient
                        : null,
                borderRadius: BorderRadius.circular(screenSize.width / 13.7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    element["icon"],
                    size: screenSize.width / 13.7,
                    color:
                        (currentIndex == elements.indexOf(element))
                            ? appWhite(1, context)
                            : appGrey(1),
                  ),
                  Text(
                    element["label"],
                    style: TextStyle(
                      fontSize: screenSize.width / 20.6,
                      fontWeight: FontWeight.bold,
                      color:
                          (currentIndex == elements.indexOf(element))
                              ? appWhite(1, context)
                              : appGrey(1),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}
