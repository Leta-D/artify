import 'package:artify2/app_background/app_state_provider.dart';
import 'package:artify2/app_theme/app_colors.dart';
import 'package:artify2/app_widgets/catagory_frams.dart';
import 'package:artify2/app_widgets/category_collections.dart';
import 'package:artify2/app_widgets/category_search.dart';
import 'package:artify2/app_widgets/main_middel_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CatagoryPage extends StatelessWidget {
  CatagoryPage({super.key});

  final middelNavElemnts = [
    {"icon": CupertinoIcons.collections_solid, "label": "Collections"},
    {"icon": CupertinoIcons.search_circle_fill, "label": "Search"},
  ];

  @override
  Widget build(BuildContext context) {
    final categoryNavs = [categoryCollections(context), CategorySearch()];

    // Size screenSize = MediaQuery.sizeOf(context);
    final appProvider = Provider.of<AppStateProvider>(context);
    return Stack(
      children: [
        categoryNavs[appProvider.categoryNavIndex],
        mainMiddelNav(context, middelNavElemnts, false),
      ],
    );
  }
}
