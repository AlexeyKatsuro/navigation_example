import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:navigation_example/navigation/nav_node.dart';
import 'package:navigation_example/navigation/routes.dart';

@immutable
class AppState {
  const AppState({
    @required this.rootNavHost,
  });

  factory AppState.initial() {
    return AppState(rootNavHost: NavNodeHost.start(name: RouteHosts.rootHost, pageName: Routes.landingPage));
  }

  final NavNodeHost rootNavHost;
}
