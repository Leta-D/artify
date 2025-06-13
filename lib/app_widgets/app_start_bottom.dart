import 'package:aaa/app_background/app_state_provider.dart';
import 'package:aaa/app_theme/app_colors.dart';
import 'package:aaa/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget appStartBottom(BuildContext context, List<Map<String, String>> bottoms) {
  final appStateProvider = Provider.of<AppStateProvider>(context);
  Size screenSize = MediaQuery.sizeOf(context);
  return Container(
    width: screenSize.width,
    height: screenSize.height / 4.2,
    decoration: BoxDecoration(
      color: appBlack(1, context),
      border: Border.all(color: appBlack(0.7, context), width: 1),
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    child: Flex(
      direction: Axis.vertical,
      children: [
        Text(
          bottoms[appStateProvider.startBottomIndex]["title"]!,
          style: TextStyle(
            color: appWhite(1, context),
            fontSize: screenSize.height / 30.5,
          ),
        ),
        SizedBox(
          width: screenSize.width - screenSize.height / 30.5,
          child: Text(
            bottoms[appStateProvider.startBottomIndex]["message"]!,
            style: TextStyle(
              fontSize: screenSize.height / 50.83,
              color: appWhite(1, context),
            ),
            softWrap: true,
          ),
        ),
        InkWell(
          onTap: () {
            (appStateProvider.startBottomIndex != bottoms.length - 1)
                ? appStateProvider.incrementStartBottomIndex()
                : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => MainPage()),
                );
          },
          child: Container(
            width: screenSize.width / 2.5,
            margin: EdgeInsets.all(screenSize.height / 45.75),
            padding: EdgeInsets.all(screenSize.height / 91.5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: buttonGradient,
              border: Border.all(color: appBlack(1, context)),
              borderRadius: BorderRadius.circular(screenSize.height / 30.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bottoms[appStateProvider.startBottomIndex]["buttonText"]!,
                  style: TextStyle(
                    color: appWhite(1, context),
                    fontSize: screenSize.height / 36.6,
                  ),
                ),
                Icon(CupertinoIcons.arrow_right, color: appWhite(1, context)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
