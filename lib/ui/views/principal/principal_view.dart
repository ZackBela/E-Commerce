import 'package:e_commerce/ui/common/app_colors.dart';
import 'package:e_commerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../widgets/dumb/BottomNavBarButton.dart';
import 'principal_viewmodel.dart';

class PrincipalView extends StackedView<PrincipalViewModel> {
  const PrincipalView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PrincipalViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: viewModel.getViewForIndex(),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavBarButton(
              title: "Home",
              icon: 'assets/icons/icons8-accueil-24.png',
              tabColor: viewModel.currentTab == 0 ? Colors.blue : kcLightGrey,
              ontap: () {
                viewModel.changeScreen(0);
              },
            ),
            BottomNavBarButton(
              title: "Favorites",
              icon: 'assets/icons/icons8-coeurs-24.png',
              tabColor: viewModel.currentTab == 1 ? Colors.blue : kcLightGrey,
              ontap: () {
                viewModel.changeScreen(1);
              },
            ),
            BottomNavBarButton(
              title: "Cart",
              icon: 'assets/icons/icons8-caddie-32.png',
              tabColor: viewModel.currentTab == 2 ? Colors.blue : kcLightGrey,
              ontap: () {
                viewModel.changeScreen(2);
              },
            ),
          ],
        ).height(screenHeight(context) * .09).width(screenWidth(context)),
      ),
    );
  }

  @override
  PrincipalViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PrincipalViewModel();
}
