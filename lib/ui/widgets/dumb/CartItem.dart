import 'package:e_commerce/local_Db/cartItem.dart';
import 'package:e_commerce/ui/common/app_colors.dart';
import 'package:e_commerce/ui/widgets/dumb/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../common/ui_helpers.dart';

class cartItem extends StatelessWidget {
  cartItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  CartItem? product;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Image.asset(product!.thumbnail!),
        )
            .width(pSw(context: context, percentage: .14))
            .height(pSh(context: context, percentage: .08))
            .padding(all: pSh(context: context, percentage: .02))
            .decorated(
                color: Color(0xFFF7FAFB),
                borderRadius: BorderRadius.circular(
                    pSh(context: context, percentage: .012)),
                border: Border.all(color: kcTextColor.withOpacity(.2))),
        horizontalSpaceMedium,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: product!.title,
              size: pSh(context: context, percentage: .017),
              weight: FontWeight.w600,
            ),
            verticalSpaceTiny,
            CustomText(
              text: product!.description,
              size: pSh(context: context, percentage: .014),
              weight: FontWeight.w500,
              color: kcMediumGrey.withOpacity(.6),
            ).width(pSw(context: context, percentage: .35)),
            verticalSpaceTiny,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: '£${product!.price}',
                  size: pSh(context: context, percentage: .018),
                  weight: FontWeight.w600,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.remove_rounded,
                      color: kcPrimaryColor,
                      size: pSh(context: context, percentage: .02),
                    )
                        .padding(all: pSh(context: context, percentage: .005))
                        .decorated(
                            border: Border.all(color: kcPrimaryColor),
                            shape: BoxShape.circle)
                        .gestures(onTap: () {
                      // viewModel.decrementCounter();
                    }),
                    horizontalSpaceSmall,
                    horizontalSpaceTiny,
                    CustomText(
                      text: '${product!.quantite}',
                      weight: FontWeight.w600,
                      size: pSh(context: context, percentage: .017),
                      color: kcTextColor,
                    ).center().width(pSw(context: context, percentage: .03)),
                    horizontalSpaceSmall,
                    horizontalSpaceTiny,
                    Icon(
                      Icons.add_rounded,
                      color: kcPrimaryColor,
                      size: pSh(context: context, percentage: .02),
                    )
                        .padding(all: pSh(context: context, percentage: .005))
                        .decorated(
                            border: Border.all(color: kcPrimaryColor),
                            shape: BoxShape.circle)
                        .gestures(onTap: () {
                      // viewModel.incrementCounter();
                    }),
                  ],
                ),
              ],
            ),
          ],
        ).padding(vertical: pSh(context: context, percentage: .02)).expanded(),
      ],
    )
        .width(pSw(context: context))
        .height(pSh(context: context, percentage: .15))
        .decorated();
  }
}
