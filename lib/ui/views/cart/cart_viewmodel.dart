import 'package:e_commerce/local_Db/cartItem.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../services/local_db_services_service.dart';

class CartViewModel extends ReactiveViewModel {
  final _local_db_Service = locator<LocalDbServicesService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  double _total = .0;
  double get total => _total;

  void setTotal(double value) {
    _total = value;
  }

  listenToCartItems() {
    _local_db_Service.listenToAllCartItems().listen((data) {
      _cartItems = data;
      _total = .0;
      _cartItems
          .forEach((element) => _total += element.price! * element.quantite!);
      rebuildUi();
    });
  }

  void updateCartItem(CartItem item, int newQuantite) async {
    await _local_db_Service.updateCartItem(item, newQuantite);
    rebuildUi();
  }

  clearCart() async {
    await _local_db_Service.deleteCart();
    rebuildUi();
  }

  void showdeleteConfirmationSheet(int? id) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.supressionAlert,
      title: 'Delete product',
      description: 'Are you sure you want to delete this product from cart',
      data: id,
    );
  }

  void clearCartConfirmation() {
    _dialogService.showCustomDialog(
      variant: DialogType.clearCart,
      title: 'Confirmation',
      description: 'Are you sure you want to clear this Cart !!!!',
    );
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_local_db_Service];
}
