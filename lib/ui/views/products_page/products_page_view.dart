import 'package:e_commerce/ui/views/products_page/products_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../common/app_colors.dart';
import '../../common/constant_data.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/dumb/CustomText.dart';
import '../../widgets/dumb/CustomTextField.dart';
import '../../widgets/dumb/ProductWidget.dart';
import '../../widgets/dumb/categoryChip.dart';

class ProductsPageView extends StackedView<ProductsPageViewModel> {
  ProductsPageView({Key? key}) : super(key: key);
  TextEditingController? textEditingController;

  @override
  Widget builder(
    BuildContext context,
    ProductsPageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.arrow_back_outlined,
                color: kcTextColor,
              )
                  .padding(all: pSh(context: context, percentage: .012))
                  .decorated(
                    border: Border.all(
                      color: kcTextColor.withOpacity(.18),
                    ),
                    shape: BoxShape.circle,
                  )
                  .gestures(
                onTap: () {
                  viewModel.goBack();
                },
              ),
              CustomText(
                text: 'Product page',
                weight: FontWeight.w600,
                size: pSh(context: context, percentage: .02),
              ),
              Container(
                padding:
                    EdgeInsets.all(pSh(context: context, percentage: .012)),
              ),
            ],
          ),
          verticalSpaceMedium,
          CustomTextField(
            texteditingController: textEditingController,
            hintText: 'Search products',
            textInputAction: TextInputAction.done,
            prefix: SvgPicture.asset(
              'assets/icons/searchIcon.svg',
              color: kcTextColor.withOpacity(.5),
            ).padding(
              all: pSh(context: context, percentage: .018),
            ),
            onchanged: (e) => viewModel.onSearchKeyWordChanged(e),
          ),
          verticalSpaceMedium,
          ListView.builder(
            itemCount: categoriesList.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CategoryChip(
                category: categoriesList[index],
                isSelected: viewModel.categorySelected ==
                    categoriesList[index]['label'],
              ).gestures(
                onTap: () => viewModel
                    .changeSelectedCategory(categoriesList[index]['label']!),
              );
            },
          ).width(pSw(context: context)).height(
                pSh(context: context, percentage: .06),
              ),
          verticalSpaceMedium,
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              childAspectRatio: .65,
            ),
            physics: BouncingScrollPhysics(),
            itemCount: viewModel.categorySelected != 'All'
                ? productsList
                    .where((element) =>
                        element['category'] == viewModel.categorySelected &&
                        element['title']
                            .toString()
                            .toUpperCase()
                            .contains(viewModel.searchKeyWord.toUpperCase()))
                    .length
                : productsList
                    .where((element) => element['title']
                        .toString()
                        .toUpperCase()
                        .contains(viewModel.searchKeyWord.toUpperCase()))
                    .length,
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(
                product: viewModel.returnFilteredProduct(index),
                onAddTap: () async {
                  await viewModel
                      .addProductTocart(viewModel.returnFilteredProduct(index));
                },
                onFavTap: () async {
                  viewModel.favProductsIds.contains(
                          viewModel.returnFilteredProduct(index)["id"])
                      ? await viewModel.deleteFromFavProducts(
                          viewModel.returnFilteredProduct(index)["id"])
                      : await viewModel.addToFavProducts(
                          viewModel.returnFilteredProduct(index));
                },
                isLiked: viewModel.favProductsIds
                    .contains(viewModel.returnFilteredProduct(index)["id"]),
              ).gestures(onTap: () {
                viewModel.goToProductDetailsView(
                    viewModel.returnFilteredProduct(index));
              });
            },
          ).width(pSw(context: context)).expanded(),
        ],
      ).safeArea().padding(all: pSh(context: context, percentage: .025)),
    );
  }

  @override
  ProductsPageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductsPageViewModel();
  @override
  void onViewModelReady(ProductsPageViewModel viewModel) {
    textEditingController =
        TextEditingController(text: viewModel.searchKeyWord);
    viewModel.listenToFavProducts();
    super.onViewModelReady(viewModel);
  }
}
