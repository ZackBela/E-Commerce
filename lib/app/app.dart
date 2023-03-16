import 'package:e_commerce/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:e_commerce/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:e_commerce/ui/views/home/home_view.dart';
import 'package:e_commerce/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:e_commerce/services/authentication_service.dart';
import 'package:e_commerce/services/api_service.dart';
import 'package:e_commerce/ui/views/principal/principal_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: PrincipalView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: ApiService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
