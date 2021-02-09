import 'package:navigation_example/navigation/nav_node.dart';
import 'package:navigation_example/redux/navigation_actions.dart';
import 'package:redux/redux.dart';

final navigationStackReducer = combineReducers<NavNodeHost>([
  TypedReducer<NavNodeHost, NavigatePushAction>(_navigatePushReducer),
  TypedReducer<NavNodeHost, NavigatePopAction>(_navigatePopReducer),
  TypedReducer<NavNodeHost, NavigateToHostAction>(_navigateToHostReducer),
]);

NavNodeHost _navigatePushReducer(NavNodeHost navNodeHost, NavigatePushAction action) {
  return navNodeHost.copyPushToHost(
    NavNodePage(name: action.pageName, arg: action.arguments),
    hostName: action.hostName,
  );
}

NavNodeHost _navigatePopReducer(NavNodeHost navNodeHost, NavigatePopAction action) {
  return navNodeHost.deepPop();
}

NavNodeHost _navigatePopUntilReducer(NavNodeHost navNodeHost, NavigatePopUntilAction action) {
  return navNodeHost.deepPop();
}

NavNodeHost _navigateToHostReducer(NavNodeHost navNodeHost, NavigateToHostAction action) {
  return navNodeHost.copyPush(NavNodeHost.start(
    name: action.hostName,
    pageName: action.startPageName,
    arg: action.startPageArg,
  ));
}
