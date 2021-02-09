import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:navigation_example/navigation/nav_node.dart';
import 'package:navigation_example/navigation/navigation_container.dart';
import 'package:navigation_example/redux/app_state.dart';
import 'package:navigation_example/redux/navigation_actions.dart';
import 'package:redux/redux.dart';

class MainHost extends StatelessWidget with AppNodePageGraph {
  MainHost({
    Key key,
    this.nodeHost,
  }) : super(key: key);
  final NavNodeHost nodeHost;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: MediaQuery.removeViewPadding(
            context: context,
            removeBottom: true,
            child: NavNodeHostNavigator(
              nodePageGraph: this,
              mainNavNodeHost: nodeHost,
              onPopPage: () {
                StoreProvider.of<AppState>(context).dispatch(NavigateAction.pop());
              },
            ),
          ),
        ),
        _bottomNavigationBarConnector(), //_bottomNavigationBar(),
      ],
    );
  }

  Widget _bottomNavigationBarConnector() {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store, nodeHost),
      builder: (context, _ViewModel viewModel) {
        return _bottomNavigationBar(viewModel);
      },
    );
  }

  Widget _bottomNavigationBar(_ViewModel viewModel) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront_sharp),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_outlined),
          label: 'History',
        ),
      ],
      currentIndex: viewModel.tabIndex,
      onTap: (index) {
        viewModel.onRouteChange(index);
      },
    );
  }
}

class _ViewModel {
  _ViewModel({
    @required this.tabIndex,
    @required this.onRouteChange,
  });

  factory _ViewModel.fromStore(Store<AppState> store, NavNodeHost nodeHost) {
    return _ViewModel(
      tabIndex: 1,
      onRouteChange: (value) {},
    );
  }

  /* static const _bottomRoutes = [
    Routes.service1Page,
    Routes.homePage,
    Routes.historyPage,
  ];*/

  final int tabIndex;
  final ValueChanged<int> onRouteChange;
}
