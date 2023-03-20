import 'package:e_commerce/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../services/local_db_services_service.dart';
import '../../common/constant_data.dart';
import '../../common/helper_methodes.dart';

class ProductsPageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  String _categorySelected = 'All';
  String get categorySelected => _categorySelected;
  String searchKeyWord = '';
  final _local_db_Service = locator<LocalDbServicesService>();
  List<int> _favProductsIds = [];
  List<int> get favProductsIds => _favProductsIds;
  void onSearchKeyWordChanged(String? value) {
    searchKeyWord = value!;
    rebuildUi();
  }

  void goBack() {
    _navigationService.back();
  }

  void changeSelectedCategory(String newValue) {
    _categorySelected = newValue;
    rebuildUi();
  }

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

  Map<String, dynamic> returnFilteredProduct(int index) {
    return categorySelected != 'All'
        ? productsList
            .where((element) =>
                element['category'] == categorySelected &&
                element['title']
                    .toString()
                    .toUpperCase()
                    .contains(searchKeyWord.toUpperCase()))
            .toList()[index]
        : productsList
            .where((element) => element['title']
                .toString()
                .toUpperCase()
                .contains(searchKeyWord.toUpperCase()))
            .toList()[index];
  }

  void showSuccesDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.succes,
      title: 'Succes!',
      description: 'Product added to cart succesfuly',
    );
  }
}
