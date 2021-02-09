import 'package:flutter/cupertino.dart';

abstract class NavigateAction {
  NavigateAction();

  factory NavigateAction.push(String name, {Object arguments}) => NavigatePushAction(name, arguments: arguments);

  factory NavigateAction.pop() => NavigatePopAction();
}

class NavigatePushAction extends NavigateAction {
  NavigatePushAction(this.pageName, {this.hostName, this.arguments});

  final String pageName;
  final String hostName;

  final Object arguments;
}

class NavigateToHostAction extends NavigateAction {
  NavigateToHostAction({
    @required this.hostName,
    @required this.startPageName,
    this.startPageArg,
  });

  final String hostName;
  final String startPageName;
  final Object startPageArg;
}

class NavigatePopAction extends NavigateAction {}

class NavigatePopUntilAction extends NavigateAction {
  NavigatePopUntilAction({
    @required this.pageName,
    this.inclusive = false,
  });

  final String pageName;
  final bool inclusive;
}
