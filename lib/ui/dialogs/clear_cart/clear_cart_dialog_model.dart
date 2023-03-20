import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/local_db_services_service.dart';

class ClearCartDialogModel extends BaseViewModel {
  final _local_db_Service = locator<LocalDbServicesService>();
  final _navigationService = locator<NavigationService>();

  clearCart() async {
    await _local_db_Service.deleteCart();
    _navigationService.back();
    rebuildUi();
  }
}
