import 'package:e_commerce/local_Db/favProduct.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/local_db_services_service.dart';
import '../../common/helper_methodes.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
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

  deleteFromFavProducts(var id) async {
    await _local_db_Service.deleteFavoriteProduct(code: id);

    _favProductsIds.remove(id);
    print('_favProductsIds ${_favProductsIds}');
    rebuildUi();
  }
}
