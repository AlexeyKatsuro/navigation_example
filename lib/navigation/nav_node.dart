import 'package:flutter/foundation.dart';

abstract class NavNode {
  const NavNode();

  String get name;
}

class NavNodePage extends NavNode {
  const NavNodePage({this.arg, @required this.name});

  final Object arg;
  @override
  final String name;
}

class NavNodeHost extends NavNode {
  const NavNodeHost({@required this.nodes, @required this.name});

  NavNodeHost.start({@required this.name, @required pageName, Object arg})
      : nodes = [NavNodePage(name: pageName, arg: arg)];

  @override
  final String name;

  final List<NavNode> nodes;

  NavNodeHost copyPop() => NavNodeHost(
        name: name,
        nodes: List.unmodifiable(nodes.toList()..removeLast()),
      );

  NavNodeHost copyPush(NavNode node) => NavNodeHost(
        name: name,
        nodes: List.unmodifiable(nodes.toList()..add(node)),
      );
}
