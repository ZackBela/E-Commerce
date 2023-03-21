import 'package:e_commerce/ui/common/app_colors.dart';
import 'package:e_commerce/ui/common/ui_helpers.dart';
import 'package:e_commerce/ui/widgets/dumb/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';

import 'product_details_viewmodel.dart';

class ProductDetailsView extends StackedView<ProductDetailsViewModel> {
  ProductDetailsView({Key? key, required this.product});
  final Map<String, dynamic> product;

  @override
  Widget builder(
    BuildContext context,
    ProductDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                text: 'Product details',
                weight: FontWeight.w600,
                size: pSh(context: context, percentage: .02),
              ),
              Container(
                padding:
                    EdgeInsets.all(pSh(context: context, percentage: .012)),
              ),
            ],
          ).padding(horizontal: pSh(context: context, percentage: .025)),
          verticalSpaceMedium,
          Container(
            child: Image.asset(product['thumbnail'])
                .padding(all: pSh(context: context, percentage: .04)),
          )
              .height(pSh(context: context, percentage: .3))
              .width(pSw(context: context))
              .decorated(color: kcAccentColor),
          verticalSpaceMedium,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: product['title'],
                    weight: FontWeight.w600,
                    size: pSh(context: context, percentage: .025),
                    color: kcTextColor,
                  ),
                  Image.asset(
                    'assets/icons/icons8-favorite-50.png',
                    color: viewModel.favProductsIds.contains(1)
                        ? Colors.red
                        : kcMediumGrey.withOpacity(.5),
                    height: pSh(context: context, percentage: .03),
                  )
                      .padding(
                    all: pSh(context: context, percentage: .009),
                    // right: pSh(context: context, percentage: .009),
                  )
                      .gestures(onTap: () async {
                    viewModel.favProductsIds.contains(product['id'])
                        ? await viewModel.deleteFromFavProducts(product['id'])
                        : await viewModel.addToFavProducts(product);
                  })
                ],
              ),
              verticalSpaceSmall,
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  horizontalSpaceTiny,
                  CustomText(
                    text: product['rating'].toString(),
                    weight: FontWeight.w600,
                    size: pSh(context: context, percentage: .015),
                    color: kcTextColor.withOpacity(.25),
                  ),
                  horizontalSpaceMedium,
                  CustomText(
                    text: '193 reviews',
                    weight: FontWeight.w500,
                    size: pSh(context: context, percentage: .015),
                    color: kcPrimaryColor,
                  ),
                ],
              ),
              verticalSpaceMedium,
              CustomText(
                text: product['description'],
                weight: FontWeight.w500,
                size: pSh(context: context, percentage: .015),
                color: kcMediumGrey.withOpacity(.4),
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: '£${product['price']}',
                    weight: FontWeight.w600,
                    size: pSh(context: context, percentage: .025),
                    color: kcTextColor,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.remove_rounded,
                        color: kcPrimaryColor,
                        size: pSh(context: context, percentage: .023),
                      )
                          .padding(all: pSh(context: context, percentage: .005))
                          .decorated(
                              border: Border.all(color: kcPrimaryColor),
                              shape: BoxShape.circle)
                          .gestures(onTap: () {
                        viewModel.decrementCounter();
                      }),
                      horizontalSpaceSmall,
                      horizontalSpaceTiny,
                      CustomText(
                        text: viewModel.counter.toString(),
                        weight: FontWeight.w600,
                        size: pSh(context: context, percentage: .017),
                        color: kcTextColor,
                      ).center().width(pSw(context: context, percentage: .03)),
                      horizontalSpaceSmall,
                      horizontalSpaceTiny,
                      Icon(
                        Icons.add_rounded,
                        color: kcPrimaryColor,
                        size: pSh(context: context, percentage: .023),
                      )
                          .padding(all: pSh(context: context, percentage: .005))
                          .decorated(
                              border: Border.all(color: kcPrimaryColor),
                              shape: BoxShape.circle)
                          .gestures(onTap: () {
                        viewModel.incrementCounter();
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ).padding(horizontal: pSh(context: context, percentage: .025)),
          verticalSpaceSmall,
          Divider(),
          verticalSpaceSmall,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomText(
              text: 'enter promo code',
              size: pSh(context: context, percentage: .016),
              weight: FontWeight.w500,
              color: kcTextColor.withOpacity(.3),
            ),
            CustomText(
              text: 'Apply code',
              size: pSh(context: context, percentage: .016),
              weight: FontWeight.w500,
              color: kcPrimaryColor,
            ),
          ])
              .padding(horizontal: pSh(context: context, percentage: .015))
              .width(pSw(context: context))
              .height(pSh(context: context, percentage: .065))
              .decorated(
                  borderRadius: BorderRadius.circular(
                    pSh(context: context, percentage: .014),
                  ),
                  border: Border.all(color: kcTextColor.withOpacity(.1)))
              .padding(horizontal: pSh(context: context, percentage: .015)),
          verticalSpaceSmall,
          Divider(),
          verticalSpaceSmall,
          Spacer(),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SvgPicture.asset(
              'assets/icons/shopping-cart.svg',
              height: pSh(context: context, percentage: .022),
              color: kcBackgroundColor,
            ),
            horizontalSpaceSmall,
            CustomText(
              text: 'Add item to bag',
              weight: FontWeight.w600,
              size: pSh(context: context, percentage: .015),
              color: kcBackgroundColor,
            ),
            horizontalSpaceMedium,
            Spacer(),
            CustomText(
              text: '£${product['price'] * viewModel.counter}',
              weight: FontWeight.w600,
              size: pSh(context: context, percentage: .016),
              color: kcBackgroundColor,
            ),
          ])
              .padding(horizontal: pSh(context: context, percentage: .03))
              .width(pSw(context: context))
              .height(pSh(context: context, percentage: .07))
              .decorated(
                  color: kcPrimaryColor,
                  borderRadius: BorderRadius.circular(
                      pSh(context: context, percentage: .04)))
              .padding(horizontal: pSh(context: context, percentage: .025))
              .gestures(onTap: () {
            viewModel.addProductTocart(product);
          }),
        ],
      ).padding(vertical: pSh(context: context, percentage: .025)).safeArea(),
    );
  }

  @override
  ProductDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductDetailsViewModel();
  @override
  void onViewModelReady(ProductDetailsViewModel viewModel) {
    viewModel.listenToFavProducts();
    super.onViewModelReady(viewModel);
  }
}
