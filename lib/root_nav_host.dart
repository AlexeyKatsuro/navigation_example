import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:navigation_example/navigation/nav_node.dart';
import 'package:navigation_example/navigation/navigation_container.dart';
import 'package:navigation_example/navigation/routes.dart';
import 'package:navigation_example/navigation/selector.dart';
import 'package:navigation_example/redux/app_state.dart';
import 'package:navigation_example/redux/navigation_actions.dart';
import 'package:redux/redux.dart';

class RootNavHost extends StatelessWidget with AppNodePageGraph {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (_, _ViewModel viewModel) {
        return _build(context, viewModel);
      },
    );
  }

  Widget _build(BuildContext context, _ViewModel viewModel) {
    return NavNodeHostNavigator(
      key: Key(RouteHosts.rootHost),
      nodePageGraph: this,
      onPopPage: viewModel.onPopPage,
      mainNavNodeHost: viewModel.rootNavHost,
    );
  }
}

class _ViewModel {
  _ViewModel({
    @required this.rootNavHost,
    @required this.onPopPage,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      rootNavHost: rootNavHostSelector(store.state),
      onPopPage: () => store.dispatch(NavigateAction.pop()),
    );
  }

  final NavNodeHost rootNavHost;
  final VoidCallback onPopPage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType && rootNavHost == other.rootNavHost;

  @override
  int get hashCode => rootNavHost.hashCode;
}
