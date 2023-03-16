import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:e_commerce/ui/common/app_colors.dart';
import 'package:e_commerce/ui/common/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (BuildContext context, HomeViewModel model, Widget? child) =>
            Scaffold(
              body: getViewForIndex(model.currentIndex),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                currentIndex: model.currentIndex,
                onTap: model.setIndex,
                items: [
                  BottomNavigationBarItem(
                    label: 'Posts',
                    icon: Icon(Icons.home_rounded),
                  ),
                  BottomNavigationBarItem(
                    label: 'Todos',
                    icon: Icon(Icons.favorite),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return Container(
          color: Colors.black,
        );
      case 1:
        return Container(
          color: Colors.green,
        );
      default:
        return Container(
          color: Colors.black,
        );
    }
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
