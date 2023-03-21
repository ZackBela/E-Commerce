import 'package:e_commerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarButton extends StatelessWidget {
  BottomNavBarButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.tabColor,
    required this.ontap,
  }) : super(key: key);
  String? icon;
  String? title;
  Color? tabColor;
  Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * .08,
      width: screenWidth(context) * .33,
      child: MaterialButton(
        // minWidth: 40,
        onPressed: ontap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              height: screenWidth(context) * .06,
              width: screenWidth(context) * .06,
              icon!,
              color: tabColor,
              fit: BoxFit.cover,
            ),
            verticalSpaceTiny,
            Text(
              title!,
              style: TextStyle(
                fontSize: 12,
                color: tabColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
