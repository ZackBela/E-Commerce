import 'package:e_commerce/ui/views/home/home_view.dart';
import 'package:e_commerce/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:e_commerce/ui/views/principal/principal_view.dart';
import 'package:e_commerce/ui/views/product_details/product_details_view.dart';
import 'package:e_commerce/ui/views/favorites/favorites_view.dart';
import 'package:e_commerce/ui/views/products_page/products_page_view.dart';
import 'package:e_commerce/services/local_db_services_service.dart';
import 'package:e_commerce/ui/views/cart/cart_view.dart';
import 'package:e_commerce/ui/bottom_sheets/supression_alert/supression_alert_sheet.dart';
import 'package:e_commerce/ui/dialogs/succes/succes_dialog.dart';
import 'package:e_commerce/ui/dialogs/product_exist_in_cart/product_exist_in_cart_dialog.dart';
import 'package:e_commerce/ui/dialogs/clear_cart/clear_cart_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: PrincipalView),
    MaterialRoute(page: ProductDetailsView),
    MaterialRoute(page: FavoritesView),
    MaterialRoute(page: ProductsPageView),
    MaterialRoute(page: CartView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),

    LazySingleton(classType: LocalDbServicesService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: SupressionAlertSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: SuccesDialog),
    StackedDialog(classType: ProductExistInCartDialog),
    StackedDialog(classType: ClearCartDialog),
// @stacked-dialog
  ],
)
class App {}
