import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:navigation_example/history_page.dart';
import 'package:navigation_example/home_page.dart';
import 'package:navigation_example/landing_page.dart';
import 'package:navigation_example/login_page.dart';
import 'package:navigation_example/navigation/bottom_sheet_rout.dart';
import 'package:navigation_example/navigation/dialog_route.dart';
import 'package:navigation_example/navigation/navigation_stack.dart';
import 'package:navigation_example/navigation/routes.dart';
import 'package:navigation_example/not_found_page.dart';
import 'package:navigation_example/redux/app_state.dart';
import 'package:navigation_example/redux/navigation_actions.dart';
import 'package:navigation_example/service_page_1.dart';
import 'package:navigation_example/service_page_2.dart';
import 'package:navigation_example/sub_home_page.dart';
import 'package:redux/redux.dart';

typedef WidgetArgBuild<T> = Widget Function(T args);

class MainNavigationContainer extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final Map<String, _PageBuilder> routes = {
    Routes.landingPage: _PageBuilder(
      widgetBuilder: (_) => LandingPage(),
      builder: _buildBasePage,
    ),
    Routes.loginPage: _PageBuilder(
      widgetBuilder: (_) => LoginPage(),
      builder: _buildBasePage,
    ),
    Routes.homePage: _PageBuilder(
      widgetBuilder: (_) => HomePage(),
      builder: _buildBasePage,
    ),
    Routes.service1Page: _PageBuilder(
      widgetBuilder: (_) => ServicePage1(),
      builder: _buildBasePage,
    ),
    Routes.service2Page: _PageBuilder(
      widgetBuilder: (_) => ServicePage2(),
      builder: _buildBasePage,
    ),
    Routes.subHomePage: _PageBuilder(
      widgetBuilder: (_) => SubHomePage(),
      builder: _buildBasePage,
    ),
    Routes.historyPage: _PageBuilder(
      widgetBuilder: (_) => HistoryPage(),
      builder: _buildBasePage,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: _build,
    );
  }

  Widget _build(BuildContext context, _ViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async {
        return !await _navigatorKey.currentState.maybePop();
      },
      child: Navigator(
        key: _navigatorKey,
        pages: viewModel.navigationStack.backStack.map(buildPage).toList(growable: false),
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          viewModel.onPopPage();
          return true;
        },
      ),
    );
  }

  Page buildPage(NavStackEntry stackEntry) {
    final _PageBuilder pageBuilder = routes[stackEntry.name] ?? _PageBuilder.unknown();
    return pageBuilder.build(stackEntry);
  }

  static MaterialPage<T> _buildBasePage<T>(NavStackEntry stackEntry, WidgetArgBuild<T> builder) {
    return MaterialPage(
      key: Key(stackEntry.name) as LocalKey,
      child: builder(stackEntry.args as T),
    );
  }

  static MaterialDialogPage<T> _buildBaseDialog<T>(NavStackEntry stackEntry, WidgetArgBuild builder) {
    return MaterialDialogPage<T>(
      key: Key(stackEntry.name) as LocalKey,
      name: stackEntry.name,
      arguments: stackEntry.args,
      child: builder(stackEntry.args),
    );
  }

  static BottomSheetDialog<T> buildScrollBottomSheetDialog<T>(NavStackEntry stackEntry, WidgetArgBuild builder) {
    return BottomSheetDialog<T>(
      key: Key(stackEntry.name) as LocalKey,
      name: stackEntry.name,
      arguments: stackEntry.args,
      isScrollControlled: true,
      child: builder(stackEntry.args),
    );
  }
}

class _ViewModel {
  _ViewModel({
    @required this.navigationStack,
    @required this.onPopPage,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      navigationStack: null,
      //navigationStack: mainNavHostSelector(store.state),
      onPopPage: () => store.dispatch(NavigateAction.pop()),
    );
  }

  final NavigationStack navigationStack;
  final VoidCallback onPopPage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType && navigationStack == other.navigationStack;

  @override
  int get hashCode => navigationStack.hashCode;
}

class _PageBuilder<T> {
  _PageBuilder({
    @required this.widgetBuilder,
    @required this.builder,
  });

  _PageBuilder.unknown()
      : widgetBuilder = ((_) => NotFoundPage()),
        builder = MainNavigationContainer._buildBasePage;

  final WidgetArgBuild<T> widgetBuilder;
  final Page<T> Function(NavStackEntry arguments, WidgetArgBuild<T> builder) builder;

  Page<T> build(NavStackEntry stackEntry) => builder(stackEntry, widgetBuilder);
}
