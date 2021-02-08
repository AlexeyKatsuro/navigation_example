import 'dart:core';

import 'package:navigation_example/navigation/nav_node.dart';
import 'package:navigation_example/redux/app_state.dart';

NavNodeHost rootNavHostSelector(AppState state) => state.rootNavHost;
