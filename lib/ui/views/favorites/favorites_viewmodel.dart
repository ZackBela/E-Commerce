import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../local_Db/favProduct.dart';
import '../../../services/local_db_services_service.dart';
import '../../common/helper_methodes.dart';

class FavoritesViewModel extends ReactiveViewModel {
  final _local_db_Service = locator<LocalDbServicesService>();
  List<FavProduct> _favProducts = [];
  List<FavProduct> get favProducts => _favProducts;
  listenToFavProducts() {
    _local_db_Service.listenToAllFavProducts().listen((data) {
      _favProducts = data;
      rebuildUi();
    });
  }

  deleteFromFavProducts(var id) async {
    await _local_db_Service.deleteFavoriteProduct(code: id);
    rebuildUi();
  }

  Map<String, dynamic> convertFavProductObjectToMapProductHelper(
      FavProduct product) {
    return convertFavProductObjectToMapProduct(product);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_local_db_Service];
}
