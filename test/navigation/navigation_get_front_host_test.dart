// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:navigation_example/navigation/nav_node.dart';

const rootHostId = 'rootHostId';
const mainHostId = 'mainHostId';
const homeHostId = 'homeHostId';
const servicesHostId = 'servicesHostId';
const historyHostId = 'historyHostId';

void main() {
  final rootHost = _createRootHost();

  test('getDeepestFrontHost', () {
    final page = NavNodePage(name: 'AboutPage');
    expect(rootHost.getDeepestFrontHost().name, historyHostId);
    expect(_createRootHost(pushToMainHost: page).getDeepestFrontHost().name, mainHostId);
    expect(_createRootHost(pushToRootHost: page).getDeepestFrontHost().name, rootHostId);
  });
}

NavNodeHost _createRootHost({
  NavNode pushToRootHost,
  NavNode pushToMainHost,
}) {
  return NavNodeHost(
    name: rootHostId,
    nodes: [
      NavNodePage(name: 'LandingPage'),
      NavNodePage(name: 'LoginPage'),
      NavNodeHost(
        name: mainHostId,
        nodes: [
          NavNodeHost(
            name: homeHostId,
            nodes: [
              NavNodePage(name: 'HomePage'),
              NavNodePage(name: 'SubHomePage'),
            ],
          ),
          NavNodeHost(
            name: servicesHostId,
            nodes: [
              NavNodePage(name: 'ServicePage1Page'),
              NavNodePage(name: 'ServicePage2Page'),
            ],
          ),
          NavNodeHost(
            name: historyHostId,
            nodes: [
              NavNodePage(name: 'HistoryPage'),
            ],
          ),
          if (pushToMainHost != null) pushToMainHost,
        ],
      ),
      if (pushToRootHost != null) pushToRootHost,
    ],
  );
}
