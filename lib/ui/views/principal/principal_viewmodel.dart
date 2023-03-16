import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PrincipalViewModel extends BaseViewModel {
  int _currentTab = 0;
  int get currentTab => _currentTab;

  void changeScreen(int index) {
    _currentTab = index;
    print('_currentTab $_currentTab');
    rebuildUi();
  }

  Widget getViewForIndex() {
    switch (_currentTab) {
      case 0:
        return Container(
          color: Colors.black,
        );
      case 1:
        return Container(
          color: Colors.green,
        );
      case 2:
        return Container(
          color: Colors.red,
        );
      default:
        return Container(
          color: Colors.white,
        );
    }
  }
}
