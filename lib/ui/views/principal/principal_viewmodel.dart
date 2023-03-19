import 'package:e_commerce/ui/views/cart/cart_view.dart';
import 'package:e_commerce/ui/views/favorites/favorites_view.dart';
import 'package:e_commerce/ui/views/home/home_view.dart';
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
        return HomeView();
      case 1:
        return FavoritesView();
      case 2:
        return CartView();
      default:
        return Container(
          color: Colors.white,
        );
    }
  }
}
