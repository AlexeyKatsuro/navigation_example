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

const landingPageName = 'LandingPage';
const loginPageName = 'LoginPage';
const homePageName = 'HomePage';
const subHomePageName = 'SubHomePage';
const servicePage1PageName = 'ServicePage1Page';
const servicePage2PageName = 'ServicePage2Page';
const historyPageName = 'HistoryPage';
const detailsPageName = 'DetailsPage';
const aboutPageName = 'AboutPage';

void main() {
  var rootHostActual0 = createRootHost();

  var rootHostActual1 = rootHostActual0.copyPushToHost(NavNodePage(name: loginPageName), hostName: rootHostId);
  test('push next page in root host', () {
    var rootHostMatcher = createRootHost(login: true);
    expect(rootHostActual1.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual2 = rootHostActual1.copyPushToHost(
      NavNodeHost(
        nodes: [
          NavNodeHost(
            nodes: [NavNodePage(name: homePageName)],
            name: homeHostId,
          )
        ],
        name: mainHostId,
      ),
      hostName: rootHostId);
  test('then push next double host (with page) in root host', () {
    var rootHostMatcher = createRootHost(login: true, home: true);
    expect(rootHostActual2.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual3 = rootHostActual2.copyPushToHost(
    NavNodePage(name: subHomePageName),
    hostName: homeHostId,
  );
  test('then push next page in nested host', () {
    var rootHostMatcher = createRootHost(login: true, home: true, subHome: true);
    expect(rootHostActual3.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual4 = rootHostActual3
      .copyPushToHost(
        NavNodeHost(nodes: [
          NavNodePage(name: servicePage1PageName),
          NavNodePage(name: servicePage2PageName),
        ], name: servicesHostId),
        hostName: mainHostId,
      )
      .copyPushToHost(
          NavNodeHost(nodes: [
            NavNodePage(name: historyPageName),
          ], name: historyHostId),
          hostName: mainHostId);
  test('then push next hosts(with pages) outside of current front host', () {
    var rootHostMatcher = createRootHost(
      login: true,
      home: true,
      subHome: true,
      service1: true,
      service2: true,
      history: true,
    );
    expect(rootHostActual4.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual5 = rootHostActual4.copyPushToHost(
    NavNodePage(name: detailsPageName),
    hostName: mainHostId,
  );
  test('then push page outsize of current front host', () {
    var rootHostMatcher = createRootHost(
      login: true,
      home: true,
      subHome: true,
      service1: true,
      service2: true,
      history: true,
      details: true,
    );
    expect(rootHostActual5.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual6 = rootHostActual5.copyPushToHost(
    NavNodePage(name: aboutPageName),
    hostName: rootHostId,
  );
  test('then push page outsize of current front host in root host', () {
    var rootHostMatcher = createRootHost(
      login: true,
      home: true,
      subHome: true,
      service1: true,
      service2: true,
      history: true,
      details: true,
      about: true,
    );
    expect(rootHostActual6.isEqualsHierarchy(rootHostMatcher), true);
  });
}

NavNodeHost createRootHost({
  bool login = false,
  bool home = false,
  bool subHome = false,
  bool service1 = false,
  bool service2 = false,
  bool history = false,
  bool details = false,
  bool about = false,
}) {
  return NavNodeHost(
    name: rootHostId,
    nodes: [
      NavNodePage(name: landingPageName),
      if (login) NavNodePage(name: loginPageName),
      if (home || subHome || service1 || service2 || history || details)
        NavNodeHost(
          name: mainHostId,
          nodes: [
            if (home || subHome)
              NavNodeHost(
                name: homeHostId,
                nodes: [
                  if (home) NavNodePage(name: homePageName),
                  if (subHome) NavNodePage(name: subHomePageName),
                ],
              ),
            if (service1 || service2)
              NavNodeHost(
                name: servicesHostId,
                nodes: [
                  if (service1) NavNodePage(name: servicePage1PageName),
                  if (service2) NavNodePage(name: servicePage2PageName),
                ],
              ),
            if (history)
              NavNodeHost(
                name: historyHostId,
                nodes: [
                  NavNodePage(name: historyPageName),
                ],
              ),
            if (details) NavNodePage(name: detailsPageName),
          ],
        ),
      if (about) NavNodePage(name: aboutPageName),
    ],
  );
}
