import 'package:e_commerce/ui/widgets/dumb/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({
    Key? key,
    required this.product,
    required this.onFavTap,
    required this.onAddTap,
    required this.isLiked,
  }) : super(key: key);
  Map<String, dynamic>? product;
  final Function()? onFavTap;
  final Function()? onAddTap;
  bool? isLiked;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Image.asset(
              product!["thumbnail"],
              fit: BoxFit.cover,
            ).padding(all: pSh(context: context, percentage: .029)).center(),
            Container(
              child: Image.asset(
                'assets/icons/icons8-favorite-50.png',
                color: isLiked! ? Colors.red : kcMediumGrey.withOpacity(.5),
                height: pSh(context: context, percentage: .03),
              ).padding(
                all: pSh(context: context, percentage: .009),
                // right: pSh(context: context, percentage: .009),
              ),
            )
                // .ripple()
                .decorated(
                    borderRadius: BorderRadius.circular(
                        pSh(context: context, percentage: .009)))
                .gestures(onTap: onFavTap),
          ],
        )
            .height(pSh(context: context, percentage: .18))
            .width(pSw(context: context, percentage: .43))
            .decorated(
                color: Color(0xFFF7FAFB),
                borderRadius: BorderRadius.circular(
                    pSh(context: context, percentage: .009))),
        verticalSpaceSmall,
        CustomText(
          text: product!["title"],
          size: pSh(context: context, percentage: .016),
          weight: FontWeight.w600,
        ),
        verticalSpaceTiny,
        CustomText(
          text: product!["brand"],
          size: pSh(context: context, percentage: .013),
          weight: FontWeight.w500,
          color: kcMediumGrey.withOpacity(.7),
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
              text: "£" + product!["price"].toString(),
              size: pSh(context: context, percentage: .015),
              weight: FontWeight.w600,
              color: kcTextColor,
            ),
            Icon(
              Icons.add,
              color: Colors.white,
              size: pSh(context: context, percentage: .025),
            )
                .padding(all: pSh(context: context, percentage: .008))
                .ripple()
                .clipRRect(all: 100)
                .decorated(color: kcPrimaryColor, shape: BoxShape.circle)
                .gestures(onTap: onAddTap),
          ],
        )
      ],
    )
        .padding(all: pSh(context: context, percentage: .009))
        .width(pSw(context: context, percentage: .43))
        .height(pSh(context: context, percentage: .3))
        .decorated(
            color: Colors.white,
            border: Border.all(color: kcTextColor.withOpacity(.09)),
            borderRadius:
                BorderRadius.circular(pSh(context: context, percentage: .009)))
        .padding(right: pSh(context: context, percentage: .015));
  }
}
