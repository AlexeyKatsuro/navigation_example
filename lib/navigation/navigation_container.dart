import 'package:flutter/material.dart';
import 'package:navigation_example/details_page.dart';
import 'package:navigation_example/history_page.dart';
import 'package:navigation_example/home_page.dart';
import 'package:navigation_example/landing_page.dart';
import 'package:navigation_example/login_page.dart';
import 'package:navigation_example/main_host.dart';
import 'package:navigation_example/navigation/nav_node.dart';
import 'package:navigation_example/navigation/routes.dart';
import 'package:navigation_example/not_found_page.dart';
import 'package:navigation_example/service_page_1.dart';
import 'package:navigation_example/service_page_2.dart';
import 'package:navigation_example/sub_home_page.dart';

typedef NavigatorBuilder = Widget Function(BuildContext context, Widget navigator);

class NavNodeHostNavigator extends StatefulWidget {
  NavNodeHostNavigator({
    Key key,
    @required this.onPopPage,
    @required this.mainNavNodeHost,
    @required this.nodePageGraph,
    this.layoutBuilder = _defaultLayout,
  })  : assert(onPopPage != null),
        assert(mainNavNodeHost != null),
        assert(nodePageGraph != null),
        super(key: key);

  static Widget _defaultLayout(BuildContext context, Widget navigator) => navigator;

  final VoidCallback onPopPage;
  final NavNodeHost mainNavNodeHost;

  final NavigatorBuilder layoutBuilder;
  final NodePageGraph nodePageGraph;

  @override
  _NavNodeHostNavigatorState createState() => _NavNodeHostNavigatorState();
}

class _NavNodeHostNavigatorState extends State<NavNodeHostNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final navigator = WillPopScope(
      onWillPop: () async {
        return !await _navigatorKey.currentState.maybePop();
      },
      child: Navigator(
        key: _navigatorKey,
        pages: _buildNodeHost(widget.mainNavNodeHost),
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          widget.onPopPage();
          return true;
        },
      ),
    );
    return widget.layoutBuilder(context, navigator);
  }

  List<Page> _buildNodeHost(NavNodeHost nodeHost) {
    assert(nodeHost.nodes.isNotEmpty);
    return [
      for (final node in nodeHost.nodes) _buildNode(node),
    ];
  }

  Page _buildNode(NavNode node) {
    return widget.nodePageGraph.buildNode(node);
  }
}

abstract class NodePageGraph {
  Page buildNode(NavNode node);
}

mixin AppNodePageGraph implements NodePageGraph {
  @override
  Page buildNode(NavNode node) {
    if (node is NavNodePage) {
      return buildNodePage(node);
    } else if (node is NavNodeHost) {
      return buildNodeHost(node);
    } else {
      throw UnimplementedError('Unhandled  node type ${node.runtimeType}');
    }
  }

  Page buildNodePage(NavNodePage nodePage) {
    switch (nodePage.name) {
      case Routes.landingPage:
        return MaterialPage(
          key: Key(nodePage.name),
          name: nodePage.name,
          arguments: nodePage.arg,
          child: LandingPage(),
        );
      case Routes.loginPage:
        return MaterialPage(
          key: Key(nodePage.name),
          name: nodePage.name,
          arguments: nodePage.arg,
          child: LoginPage(),
        );
      case Routes.homePage:
        return MaterialPage(
          key: Key(nodePage.name),
          name: nodePage.name,
          arguments: nodePage.arg,
          child: HomePage(),
        );
      case Routes.service1Page:
        return MaterialPage(
          key: Key(nodePage.name),
          name: nodePage.name,
          arguments: nodePage.arg,
          child: ServicePage1(),
        );
      case Routes.service2Page:
        return MaterialPage(
          key: Key(nodePage.name),
          name: nodePage.name,
          arguments: nodePage.arg,
          child: ServicePage2(),
        );
      case Routes.subHomePage:
        return MaterialPage(
          fullscreenDialog: true,
          key: Key(nodePage.name),
          name: nodePage.name,
          arguments: nodePage.arg,
          child: SubHomePage(),
        );
      case Routes.historyPage:
        return MaterialPage(
          key: Key(nodePage.name),
          name: nodePage.name,
          arguments: nodePage.arg,
          child: HistoryPage(),
        );
      case Routes.detailsPage:
        return MaterialPage(
          key: Key(nodePage.name),
          name: nodePage.name,
          arguments: nodePage.arg,
          child: DetailsPage(),
        );
      default:
        return MaterialPage(
          key: Key(nodePage.name),
          name: nodePage.name,
          arguments: nodePage.arg,
          child: NotFoundPage(),
        );
    }
  }

  Page buildNodeHost(NavNodeHost nodeHost) {
    switch (nodeHost.name) {
      case RouteHosts.mainHost:
        return MaterialPage(
          child: MainHost(nodeHost: nodeHost),
        );
      default:
        return MaterialPage(child: NotFoundPage());
    }
  }
}
