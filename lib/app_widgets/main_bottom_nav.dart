import 'package:artify/app_background/app_state_provider.dart';
import 'package:artify/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget mainBottomNav(
  BuildContext context,
  List<Map<String, dynamic>> elements,
) {
  Size screenSize = MediaQuery.sizeOf(context);
  final appStateProvider = Provider.of<AppStateProvider>(context);
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height: screenSize.height / 11,
      color: appBlack(1),
      padding: EdgeInsets.symmetric(vertical: screenSize.height / 91),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var element in elements)
            InkWell(
              onTap: () {
                appStateProvider.changeMainBottomNavIndex(
                  elements.indexOf(element),
                );
              },
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Icon(
                    element["icon"],
                    color:
                        (appStateProvider.mainBottomNavIndex ==
                                elements.indexOf(element))
                            ? appWhite(1)
                            : appGrey(1),
                    size: screenSize.height / 30.5,
                  ),
                  Text(
                    element["label"],
                    style: TextStyle(
                      color:
                          (appStateProvider.mainBottomNavIndex ==
                                  elements.indexOf(element))
                              ? appWhite(1)
                              : appGrey(1),
                      fontSize: screenSize.height / 57,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
