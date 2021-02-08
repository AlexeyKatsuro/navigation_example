import 'package:navigation_example/redux/app_state.dart';
import 'package:navigation_example/redux/navigation_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    rootNavHost: navigationStackReducer(state.rootNavHost, action),
  );
}
