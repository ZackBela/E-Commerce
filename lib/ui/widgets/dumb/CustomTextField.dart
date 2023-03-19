import 'package:e_commerce/ui/common/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:styled_widget/styled_widget.dart';

import '../../common/ui_helpers.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    this.texteditingController,
    this.validator,
    this.onchanged,
    this.prefix,
    // this.suffix,
    required this.hintText,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);
  final TextEditingController? texteditingController;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onchanged;
  final Widget? prefix;
  final TextInputAction? textInputAction;

  final TextInputType? keyboardType;

  final IconData? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: texteditingController,
      cursorColor: kcPrimaryColor,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: pSw(context: context, percentage: .04),
          vertical: pSh(context: context, percentage: .02),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: kcTextColor.withOpacity(.3),
            fontSize: pSh(context: context, percentage: .015),
            fontWeight: FontWeight.w500),

        filled: true,
        fillColor: kcTextColor.withOpacity(.02),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            pSh(context: context, percentage: .5),
          ),
          borderSide: const BorderSide(color: Colors.transparent, width: .6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            pSh(context: context, percentage: .5),
          ),
          borderSide: const BorderSide(color: Colors.transparent, width: .3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            pSh(context: context, percentage: .5),
          ),
          borderSide: const BorderSide(color: Colors.transparent, width: .6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            pSh(context: context, percentage: .5),
          ),
          borderSide: BorderSide(color: Colors.red.withOpacity(.7), width: .4),
        ),
        // ignore: prefer_if_null_operators
        prefixIcon: prefix != null
            ? prefix
            : prefixIcon == null
                ? null
                : Icon(
                    prefixIcon,
                    color: kcTextColor.withOpacity(.5),
                    size: pSh(context: context, percentage: .03),
                  ),
      ),
      validator: validator,
      onChanged: onchanged,
    );
  }
}
