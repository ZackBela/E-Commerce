// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/clear_cart/clear_cart_dialog.dart';
import '../ui/dialogs/product_exist_in_cart/product_exist_in_cart_dialog.dart';
import '../ui/dialogs/succes/succes_dialog.dart';

enum DialogType {
  infoAlert,
  succes,
  productExistInCart,
  clearCart,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.succes: (context, request, completer) =>
        SuccesDialog(request: request, completer: completer),
    DialogType.productExistInCart: (context, request, completer) =>
        ProductExistInCartDialog(request: request, completer: completer),
    DialogType.clearCart: (context, request, completer) =>
        ClearCartDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
