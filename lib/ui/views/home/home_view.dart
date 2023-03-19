import 'package:e_commerce/ui/widgets/dumb/CustomText.dart';
import 'package:e_commerce/ui/widgets/dumb/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:e_commerce/ui/common/app_colors.dart';
import 'package:e_commerce/ui/common/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../common/constant_data.dart';
import '../../widgets/dumb/ProductWidget.dart';
import '../../widgets/dumb/categoryChip.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Hello Emmanuel',
                    size: pSh(context: context, percentage: .022),
                    weight: FontWeight.w600,
                  ),
                  verticalSpaceTiny,
                  CustomText(
                    text: 'What are you buying today?',
                    size: pSh(context: context, percentage: .018),
                    weight: FontWeight.w500,
                    color: kcTextColor.withOpacity(.5),
                  ),
                ],
              ),
              Container(
                child: const Icon(
                  Icons.person,
                  color: kcPrimaryColor,
                ).padding(
                  all: pSh(context: context, percentage: .015),
                ),
              ).decorated(
                  border: Border.all(color: kcPrimaryColor.withOpacity(.22)),
                  shape: BoxShape.circle)
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
              ).gestures(onTap: () {
                viewModel.goToProductPageView();
              });
            },
          ).width(pSw(context: context)).height(
                pSh(context: context, percentage: .06),
              ),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Trending sales',
                size: pSh(context: context, percentage: .020),
                weight: FontWeight.w600,
              ),
              CustomText(
                text: 'See all',
                size: pSh(context: context, percentage: .016),
                weight: FontWeight.w500,
                color: kcPrimaryColor,
              ),
            ],
          ).gestures(onTap: () {
            viewModel.goToProductPageView();
          }),
          verticalSpaceMedium,
          ListView.builder(
            itemCount: productsList.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(
                product: productsList[index],
                onAddTap: () {},
                onFavTap: () async {
                  viewModel.favProductsIds.contains(productsList[index]["id"])
                      ? await viewModel
                          .deleteFromFavProducts(productsList[index]["id"])
                      : await viewModel.addToFavProducts(productsList[index]);
                },
                isLiked: viewModel.favProductsIds
                    .contains(productsList[index]["id"]),
              ).gestures(onTap: () {
                viewModel.goToProductDetailsView(productsList[index]);
              });
            },
          ).width(pSw(context: context)).height(
                pSh(context: context, percentage: .32),
              ),
          verticalSpaceMedium,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomText(
              text: 'All products',
              size: pSh(context: context, percentage: .016),
              weight: FontWeight.w600,
              color: kcTextColor,
            ),
            CustomText(
              text: 'see all',
              size: pSh(context: context, percentage: .016),
              weight: FontWeight.w500,
              color: Colors.white,
            )
                .padding(
                  vertical: pSh(context: context, percentage: .014),
                  horizontal: pSh(context: context, percentage: .02),
                )
                .decorated(
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.circular(
                      pSh(context: context, percentage: .014),
                    )),
          ])
              .padding(horizontal: pSh(context: context, percentage: .015))
              .width(pSw(context: context))
              .height(pSh(context: context, percentage: .065))
              .decorated(
                  borderRadius: BorderRadius.circular(
                    pSh(context: context, percentage: .014),
                  ),
                  border: Border.all(color: kcTextColor.withOpacity(.1)))
              .gestures(onTap: () {
            viewModel.goToProductPageView();
          }),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Recently viewed',
                size: pSh(context: context, percentage: .020),
                weight: FontWeight.w600,
              ),
              CustomText(
                text: 'See all',
                size: pSh(context: context, percentage: .016),
                weight: FontWeight.w500,
                color: kcPrimaryColor,
              ),
            ],
          ).gestures(onTap: () {
            viewModel.goToProductPageView();
          }),
          verticalSpaceMedium,
          ListView.builder(
            itemCount: productsList.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(
                product: productsList[index],
                onAddTap: () {},
                onFavTap: () async =>
                    await viewModel.addToFavProducts(productsList[index]),
                isLiked: viewModel.favProductsIds
                    .contains(productsList[index]["id"]),
              );
            },
          ).width(pSw(context: context)).height(
                pSh(context: context, percentage: .32),
              ),
        ],
      )
          .padding(
            all: pSh(context: context, percentage: .028),
          )
          .scrollable(physics: BouncingScrollPhysics())
          .height(screenHeight(context))
          .safeArea(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
  @override
  void onViewModelReady(HomeViewModel viewModel) {
    print('_favProductsIds ${viewModel.favProductsIds}');
    viewModel.listenToFavProducts();
    super.onViewModelReady(viewModel);
  }
}
