import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/local_db_services_service.dart';

class SupressionAlertSheetModel extends BaseViewModel {
  final _local_db_Service = locator<LocalDbServicesService>();
  final _navigationService = locator<NavigationService>();

  void deleteCartItem(int id) async {
    await _local_db_Service.deleteCartItem(id);
    _navigationService.back();
    rebuildUi();
  }
}
