import 'package:e_commerce/ui/common/app_colors.dart';
import 'package:e_commerce/ui/widgets/dumb/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:e_commerce/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/shopping-bag (1).png',
              height: pSh(context: context, percentage: .18),
            ),
            verticalSpaceMedium,
            CustomText(
              text: 'E-Commerce',
              size: pSh(context: context, percentage: .028),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Loading ...',
                  size: pSh(
                    context: context,
                    percentage: .018,
                  ),
                  color: kcPrimaryColor,
                ),
                horizontalSpaceSmall,
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: kcPrimaryColor,
                    strokeWidth: 2,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
