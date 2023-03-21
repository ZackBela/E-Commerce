import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/dumb/CartItem.dart';
import '../../widgets/dumb/CustomText.dart';
import 'cart_viewmodel.dart';

class CartView extends StackedView<CartViewModel> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CartViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: CustomText(
          text: 'My Cart',
          weight: FontWeight.w600,
          size: pSh(context: context, percentage: .02),
        ),
        actions: [
          viewModel.cartItems.isNotEmpty
              ? Icon(
                  Icons.delete,
                  color: Colors.red,
                )
                  .padding(right: pSh(context: context, percentage: .03))
                  .gestures(onTap: () {
                  viewModel.clearCartConfirmation();
                })
              : Container(),
        ],
      ),
      body: viewModel.cartItems.isNotEmpty
          ? Column(
              children: [
                ListView.builder(
                  itemCount: viewModel.cartItems.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return cartItem(
                      product: viewModel.cartItems[index],
                      onminusTap: () async {
                        viewModel.cartItems[index].quantite == 1
                            ? viewModel.showdeleteConfirmationSheet(
                                viewModel.cartItems[index].id)
                            : {
                                viewModel.setTotal(0),
                                viewModel.updateCartItem(
                                    viewModel.cartItems[index],
                                    viewModel.cartItems[index].quantite! - 1)
                              };
                      },
                      onplusTap: () async {
                        viewModel.setTotal(0);
                        viewModel.updateCartItem(viewModel.cartItems[index],
                            viewModel.cartItems[index].quantite! + 1);
                      },
                    );
                  },
                ).width(pSw(context: context)).expanded(),
                verticalSpaceMedium,
                Divider(
                  color: kcTextColor.withOpacity(.4),
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Subtotal:',
                      weight: FontWeight.w600,
                      size: pSh(context: context, percentage: .016),
                      color: kcTextColor.withOpacity(.4),
                    ),
                    CustomText(
                      text: '£${viewModel.total}',
                      weight: FontWeight.w600,
                      size: pSh(context: context, percentage: .017),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Discount:',
                      weight: FontWeight.w600,
                      size: pSh(context: context, percentage: .016),
                      color: kcTextColor.withOpacity(.4),
                    ),
                    CustomText(
                      text: '30%',
                      weight: FontWeight.w600,
                      size: pSh(context: context, percentage: .017),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                Divider(
                  color: kcTextColor.withOpacity(.4),
                ),
                verticalSpaceSmall,
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Purchase',
                      weight: FontWeight.w600,
                      size: pSh(context: context, percentage: .017),
                      color: kcBackgroundColor,
                    ),
                    CustomText(
                      text: '£${viewModel.total - viewModel.total * .3}',
                      weight: FontWeight.w600,
                      size: pSh(context: context, percentage: .017),
                      color: kcBackgroundColor,
                    ),
                  ],
                )
                    .width(pSw(context: context))
                    .padding(
                      all: pSh(context: context, percentage: .02),
                    )
                    .decorated(
                      color: kcPrimaryColor,
                      borderRadius: BorderRadius.circular(
                          pSh(context: context, percentage: .012)),
                    ),
              ],
            ).safeArea().padding(all: pSh(context: context, percentage: .025))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(child: Image.asset('assets/images/emptyCart.png'))
                    .height(pSh(context: context, percentage: .3))
                    .width(pSw(context: context)),
                verticalSpaceTiny,
                CustomText(
                  text: 'No Cart Items',
                  weight: FontWeight.w500,
                  size: pSh(context: context, percentage: .018),
                ),
              ],
            ),
    );
  }

  @override
  CartViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CartViewModel();
  @override
  void onViewModelReady(CartViewModel viewModel) {
    viewModel.listenToCartItems();
    super.onViewModelReady(viewModel);
  }
}
