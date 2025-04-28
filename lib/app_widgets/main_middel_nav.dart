import 'package:artify/app_background/app_state_provider.dart';
import 'package:artify/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget mainMiddelNav(
  BuildContext context,
  List<Map<String, dynamic>> elements,
) {
  Size screenSize = MediaQuery.sizeOf(context);
  final appStateProvider = Provider.of<AppStateProvider>(context);
  return Container(
    margin: EdgeInsets.all(20),
    height: screenSize.height / 7,
    decoration: BoxDecoration(
      color: appBlack(1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Flex(
      direction: Axis.horizontal,
      children: [
        for (var element in elements)
          InkWell(
            onTap: () {
              appStateProvider.changeMainMiddelNavIndex(
                elements.indexOf(element),
              );
            },
            child: Container(
              decoration: BoxDecoration(gradient: buttonGradient),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    element["icon"],
                    size: 30,
                    color:
                        (appStateProvider.mainMiddelNavIndex ==
                                elements.indexOf(element))
                            ? appWhite(1)
                            : appGrey(1),
                  ),
                  Text(
                    element["label"],
                    style: TextStyle(
                      fontSize: 20,
                      color:
                          (appStateProvider.mainMiddelNavIndex ==
                                  elements.indexOf(element))
                              ? appWhite(1)
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
