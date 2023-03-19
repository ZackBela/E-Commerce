import 'package:e_commerce/local_Db/cartItem.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/local_db_services_service.dart';

class CartViewModel extends ReactiveViewModel {
  final _local_db_Service = locator<LocalDbServicesService>();

  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  listenToCartItems() {
    _local_db_Service.listenToAllCartItems().listen((data) {
      _cartItems = data;
      rebuildUi();
    });
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_local_db_Service];
}
