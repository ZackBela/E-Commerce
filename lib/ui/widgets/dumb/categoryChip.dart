import 'package:e_commerce/ui/widgets/dumb/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../common/app_colors.dart';
import '../../common/constant_data.dart';
import '../../common/ui_helpers.dart';

class CategoryChip extends StatelessWidget {
  CategoryChip({
    Key? key,
    required this.category,
  }) : super(key: key);
  Map<String, String>? category;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          category!["icon"]!,
          color: kcTextColor,
          height: screenHeight(context) * .025,
        ),
        horizontalSpaceSmall,
        CustomText(
          text: category!["label"],
          size: 13,
          weight: FontWeight.w500,
        )
      ],
    )
        .padding(
          horizontal: screenHeight(context) * .02,
        )
        .decorated(
            border: Border.all(color: kcTextColor.withOpacity(.1)),
            borderRadius: BorderRadius.circular(screenHeight(context) * .028))
        .padding(right: screenHeight(context) * .01);
  }
}
