import 'package:navigation_example/navigation/routes.dart';
import 'package:navigation_example/redux/navigation_actions.dart';

abstract class NavActions {
  static NavigateAction pop() {
    return NavigatePushAction(
      Routes.loginPage,
    );
  }

  static NavigateAction toLoginPage() {
    return NavigatePushAction(
      Routes.loginPage,
    );
  }

  static NavigateAction toHomePage() {
    return NavigateToHostAction(
      hostName: RouteHosts.mainHost,
      startPageName: Routes.homePage,
    );
  }

  static NavigateAction toSubHomePage() {
    return NavigatePushAction(Routes.subHomePage, hostName: RouteHosts.mainHost);
  }

  static NavigateAction toHistoryPage() {
    return NavigatePushAction(
      Routes.historyPage,
    );
  }

  static NavigateAction toService1Page() {
    return NavigatePushAction(
      Routes.service1Page,
    );
  }

  static NavigateAction toService2Page() {
    return NavigatePushAction(
      Routes.service2Page,
    );
  }

  static NavigateAction toDetails() {
    return NavigatePushAction(
      Routes.detailsPage,
      hostName: RouteHosts.rootHost,
    );
  }
}
