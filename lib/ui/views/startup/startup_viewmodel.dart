import 'package:stacked/stacked.dart';
import 'package:e_commerce/app/app.locator.dart';
import 'package:e_commerce/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/local_db_services_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _localDbService = locator<LocalDbServicesService>();

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    _navigationService.replaceWithPrincipalView();
  }
}
