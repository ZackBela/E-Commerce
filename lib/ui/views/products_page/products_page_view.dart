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
import 'products_page_viewmodel.dart';

class ProductsPageView extends StackedView<ProductsPageViewModel> {
  const ProductsPageView({Key? key}) : super(key: key);

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
            hintText: 'Search products',
            textInputAction: TextInputAction.done,
            prefix: SvgPicture.asset(
              'assets/icons/searchIcon.svg',
              color: kcTextColor.withOpacity(.5),
            ).padding(
              all: pSh(context: context, percentage: .018),
            ),
            // prefixIcon: Icons.search,
          ),
          verticalSpaceMedium,
          ListView.builder(
            itemCount: categoriesList.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CategoryChip(
                category: categoriesList[index],
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
            itemCount: productsList.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(
                product: productsList[index],
                onAddTap: () {},
                onFavTap: () {},
                isLiked: true,
              );
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
}
