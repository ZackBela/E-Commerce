import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../services/local_db_services_service.dart';
import '../../common/helper_methodes.dart';

class ProductDetailsViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _local_db_Service = locator<LocalDbServicesService>();
  final _dialogService = locator<DialogService>();

  int _counter = 1;
  int get counter => _counter;
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

  deleteFromFavProducts(var id) async {
    await _local_db_Service.deleteFavoriteProduct(code: id);

    _favProductsIds.clear();
    print('_favProductsIds ${_favProductsIds}');
    rebuildUi();
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
                item: convertMapProductToCartItemObject(product, _counter)),
            _navigationService.back(),
            rebuildUi(),
          };
  }

  void goBack() {
    _navigationService.back();
  }

  void productAlreadyInTheCartDialogue() {
    _dialogService.showCustomDialog(
      variant: DialogType.productExistInCart,
      title: 'Ding Ding',
      description: 'This product is already in the cart',
    );
  }

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void decrementCounter() {
    _counter != 1 ? _counter-- : null;
    rebuildUi();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_local_db_Service];
}
