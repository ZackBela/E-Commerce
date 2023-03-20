import 'package:e_commerce/ui/common/app_colors.dart';
import 'package:e_commerce/ui/common/constant_data.dart';
import 'package:e_commerce/ui/common/helper_methodes.dart';
import 'package:e_commerce/ui/common/ui_helpers.dart';
import 'package:e_commerce/ui/widgets/dumb/ProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../widgets/dumb/CustomText.dart';
import 'favorites_viewmodel.dart';

class FavoritesView extends StackedView<FavoritesViewModel> {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FavoritesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Favorites',
                weight: FontWeight.w600,
                size: pSh(context: context, percentage: .02),
              ),
            ],
          ),
          verticalSpaceMedium,
          viewModel.favProducts.isNotEmpty
              ? CustomText(
                  text:
                      'Favorites products ( ${viewModel.favProducts.length} )',
                  weight: FontWeight.w500,
                  size: pSh(context: context, percentage: .018),
                  color: kcPrimaryColorDark,
                )
              : Container(),
          verticalSpaceMedium,
          viewModel.favProducts.isNotEmpty
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    childAspectRatio: .65,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemCount: viewModel.favProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductWidget(
                      product:
                          viewModel.convertFavProductObjectToMapProductHelper(
                              viewModel.favProducts[index]),
                      onAddTap: () async {
                        await viewModel.addProductTocart(
                            convertFavProductObjectToMapProduct(
                                viewModel.favProducts[index]));
                      },
                      onFavTap: () async => viewModel.deleteFromFavProducts(
                          viewModel.favProducts[index].code),
                      isLiked: true,
                    ).gestures(onTap: () {
                      viewModel.goToProductDetailsView(productsList[index]);
                    });
                  },
                ).width(pSw(context: context)).expanded()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(child: Image.asset('assets/images/emptyList.png'))
                        .height(pSh(context: context, percentage: .3)),
                    verticalSpaceTiny,
                    CustomText(
                      text: 'No Favorite Products',
                      weight: FontWeight.w500,
                      size: pSh(context: context, percentage: .018),
                    ),
                  ],
                ).center().expanded(),
        ],
      ).safeArea().padding(all: pSh(context: context, percentage: .025)),
    );
  }

  @override
  FavoritesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FavoritesViewModel();
  @override
  void onViewModelReady(FavoritesViewModel viewModel) {
    viewModel.listenToFavProducts();
    super.onViewModelReady(viewModel);
  }
}
