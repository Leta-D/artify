
import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  // for welcoming page
  int _startBottomIndex = 0;
  int get startBottomIndex => _startBottomIndex;
  void incrementStartBottomIndex() {
    _startBottomIndex++;
    notifyListeners();
  }

  // for main page
  int _mainBottomNavIndex = 1;
  int get mainBottomNavIndex => _mainBottomNavIndex;
  void changeMainBottomNavIndex(int index) {
    _mainBottomNavIndex = index;
    notifyListeners();
  }

  int _mainMiddelNavIndex = 0;
  int get mainMiddelNavIndex => _mainMiddelNavIndex;
  void changeMainMiddelNavIndex(int value) {
    _mainMiddelNavIndex = value;
    notifyListeners();
  }

  // for category page
  int _categoryNavIndex = 0;
  int get categoryNavIndex => _categoryNavIndex;
  void changeCategoryNavIndex(int value) {
    _categoryNavIndex = value;
    notifyListeners();
  }

  // --------------------------
  String _searchText = "Search...";
  get searchText => _searchText;
  void changeSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }
}
