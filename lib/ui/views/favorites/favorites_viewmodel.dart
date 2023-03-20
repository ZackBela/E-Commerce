import 'package:e_commerce/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../local_Db/favProduct.dart';
import '../../../services/local_db_services_service.dart';
import '../../common/helper_methodes.dart';

class FavoritesViewModel extends ReactiveViewModel {
  final _local_db_Service = locator<LocalDbServicesService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  List<FavProduct> _favProducts = [];
  List<FavProduct> get favProducts => _favProducts;
  listenToFavProducts() {
    _local_db_Service.listenToAllFavProducts().listen((data) {
      _favProducts = data;
      rebuildUi();
    });
  }

  void goToProductDetailsView(Map<String, dynamic> product) {
    _navigationService.navigateToProductDetailsView(product: product);
  }

  deleteFromFavProducts(var id) async {
    await _local_db_Service.deleteFavoriteProduct(code: id);
    rebuildUi();
  }

  addProductTocart(Map<String, dynamic> product) async {
    bool itemExist =
        await _local_db_Service.testIfCartContainsItem(product['title']);
    itemExist == true
        ? productAlreadyInTheCartDialogue()
        : {
            await _local_db_Service.addNewCartItem(
                item: convertMapProductToCartItemObject(product, 1)),

            showSuccesDialog(),
            // rebuildUi(),
          };
  }

  void productAlreadyInTheCartDialogue() {
    _dialogService.showCustomDialog(
      variant: DialogType.productExistInCart,
      title: 'Ding Ding',
      description: 'This product is already in the cart',
    );
  }

  void showSuccesDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.succes,
      title: 'Succes!',
      description: 'Product added to cart succesfuly',
    );
  }

  Map<String, dynamic> convertFavProductObjectToMapProductHelper(
      FavProduct product) {
    return convertFavProductObjectToMapProduct(product);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_local_db_Service];
}
