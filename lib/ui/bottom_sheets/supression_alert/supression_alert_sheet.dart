import 'package:e_commerce/ui/widgets/dumb/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/ui/common/app_colors.dart';
import 'package:e_commerce/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styled_widget/styled_widget.dart';

import 'supression_alert_sheet_model.dart';

class SupressionAlertSheet extends StackedView<SupressionAlertSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  SupressionAlertSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SupressionAlertSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: request.title ?? 'Hello Stacked Sheet!!',
            size: pSh(context: context, percentage: .022),
            color: kcTextColor,
            weight: FontWeight.w900,
          ),
          if (request.description != null) ...[
            verticalSpaceSmall,
            CustomText(
              text: request.description!,
              size: pSh(context: context, percentage: .018),
              color: kcMediumGrey,
              weight: FontWeight.w500,
            ),
          ],
          verticalSpaceMedium,
          Container(
            child: CustomText(
              text: 'Confirm',
              size: pSh(context: context, percentage: .019),
              color: kcBackgroundColor,
            ).center(),
          )
              .width(pSw(context: context))
              .height(pSh(context: context, percentage: .07))
              .ripple()
              .clipRRect(all: pSh(context: context, percentage: .01))
              .decorated(
                  color: kcPrimaryColor,
                  borderRadius: BorderRadius.circular(
                      pSh(context: context, percentage: .01)))
              .gestures(onTap: () async {
            viewModel.deleteCartItem(request.data!);
          }),
          verticalSpaceLarge,
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  @override
  SupressionAlertSheetModel viewModelBuilder(BuildContext context) =>
      SupressionAlertSheetModel();
  @override
  void onViewModelReady(SupressionAlertSheetModel viewModel) {
    print('jdshfsdhjf ${request.data}');
    super.onViewModelReady(viewModel);
  }
}
