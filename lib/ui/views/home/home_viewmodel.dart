import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/local_db_services_service.dart';
import '../../common/helper_methodes.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _local_db_Service = locator<LocalDbServicesService>();
  List<int> _favProductsIds = [];
  List<int> get favProductsIds => _favProductsIds;

  listenToFavProducts() {
    _local_db_Service.listenToAllFavProducts().listen((data) {
      data.forEach((e) {
        _favProductsIds.add(e.code!);
      });
      print('_favProductsIds ${_favProductsIds}');
      rebuildUi();
    });
  }

  void goToProductDetailsView(Map<String, dynamic> product) {
    _navigationService.navigateToProductDetailsView(product: product);
  }

  void goToProductPageView() {
    _navigationService.navigateToProductsPageView();
  }

  addToFavProducts(Map<String, dynamic> product) async {
    await _local_db_Service.addNewFavoriteProduct(
        product: convertMapProductToFavProductObject(product));
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
            // _navigationService.back(),
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

  deleteFromFavProducts(var id) async {
    await _local_db_Service.deleteFavoriteProduct(code: id);

    _favProductsIds.clear();
    print('_favProductsIds ${_favProductsIds}');
    rebuildUi();
  }

  void showSuccesDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.succes,
      title: 'Succes!',
      description: 'Product added to cart succesfuly',
    );
  }
}
