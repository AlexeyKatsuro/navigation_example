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

  var rootHostActual1 = rootHostActual0.deepPop();
  test('pop last page in root', () {
    var rootHostMatcher = createRootHost(
      about: false,
    );
    expect(rootHostActual1.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual2 = rootHostActual1.deepPop();
  test('then pop page in deepest front host', () {
    var rootHostMatcher = createRootHost(about: false, details: false);
    expect(rootHostActual2.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual3 = rootHostActual2.deepPop();
  test('then pop single page form front host, empty host should be removed', () {
    var rootHostMatcher = createRootHost(about: false, details: false, history: false);
    expect(rootHostActual3.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual4 = rootHostActual3.deepPop();
  test('then pop only one page and keep another, in nested front host', () {
    var rootHostMatcher = createRootHost(about: false, details: false, history: false, service2: false);
    expect(rootHostActual4.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual5 = rootHostActual4.copyPopHost();
  test('then pop nested front host with single page', () {
    var rootHostMatcher =
        createRootHost(about: false, details: false, history: false, service2: false, service1: false);
    expect(rootHostActual5.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual6 = rootHostActual5.copyPopHost();
  test('then pop nested front host with multiple pages', () {
    var rootHostMatcher = createRootHost(
      about: false,
      details: false,
      history: false,
      service2: false,
      service1: false,
      home: false,
      subHome: false,
    );
    expect(rootHostActual6.isEqualsHierarchy(rootHostMatcher), true);
  });

  var rootHostActual7 = rootHostActual6.deepPop();
  test('then pop one page in root host', () {
    var rootHostMatcher = createRootHost(
      about: false,
      details: false,
      history: false,
      service2: false,
      service1: false,
      home: false,
      subHome: false,
      login: false,
    );
    expect(rootHostActual7.isEqualsHierarchy(rootHostMatcher), true);
  });
}

NavNodeHost createRootHost({
  bool login = true,
  bool home = true,
  bool subHome = true,
  bool service1 = true,
  bool service2 = true,
  bool history = true,
  bool details = true,
  bool about = true,
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
