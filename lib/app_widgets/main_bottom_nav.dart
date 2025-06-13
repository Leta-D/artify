import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_theme/app_colors.dart';
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
      color: appBlack(1, context),
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
                            ? appWhite(1, context)
                            : appGrey(1),
                    size: screenSize.height / 30.5,
                  ),
                  Text(
                    element["label"],
                    style: TextStyle(
                      color:
                          (appStateProvider.mainBottomNavIndex ==
                                  elements.indexOf(element))
                              ? appWhite(1, context)
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



// best way to create button with label and icon in horizontal orentation
// ElevatedButton.icon(
//               style: ButtonStyle(
//                 backgroundColor: WidgetStateProperty.all(appBlack(1)),
//                 foregroundColor: WidgetStateProperty.all(appWhite(1)),
//                 alignment: Alignment.center,
//                 iconAlignment: IconAlignment.end,
//               ),
//               onPressed: () {},
//               icon: Icon("element["icon"]"),
//               label: Text("element["label"]"),
//               iconAlignment: IconAlignment.start,
//             );