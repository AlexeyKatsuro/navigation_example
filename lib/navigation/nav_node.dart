import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

typedef TransformHost = List<NavNode> Function(String name, List<NavNode> nodes);

abstract class NavNode {
  String get name;
}

class NavNodePage implements NavNode {
  const NavNodePage({this.arg, @required this.name});

  final Object arg;
  @override
  final String name;
}

class NavNodeHost implements NavNode {
  const NavNodeHost({@required this.nodes, @required this.name});

  NavNodeHost.start({@required this.name, @required pageName, Object arg})
      : nodes = List.unmodifiable([NavNodePage(name: pageName, arg: arg)]);

  @override
  final String name;

  final List<NavNode> nodes;
}

extension NavNodePageExt on NavNodePage {
  bool isEqualsHierarchy(NavNode other) =>
      identical(this, other) || other is NavNodePage && runtimeType == other.runtimeType && name == other.name;
}

extension NavNodeHostExt on NavNodeHost {
  NavNodeHost copyNodes(TransformHost transform) {
    final transformedNodes = List<NavNode>.unmodifiable(transform(name, nodes.toList()));
    return NavNodeHost(
      name: name,
      nodes: transformedNodes,
    );
  }

  NavNodeHost copyHost(TransformHost transform, {String hostName}) => copyNodes((name, nodes) {
        if (hostName == null || hostName == name) {
          return transform(name, nodes);
        }
        final list = <NavNode>[];
        for (final node in nodes) {
          if (node is NavNodeHost && (hostName == node.name || node.deepHostLookUp(hostName))) {
            final newHost = node.copyHost(transform, hostName: hostName);
            if (newHost.nodes.isNotEmpty) {
              list.add(newHost);
            }
          } else {
            list.add(node);
          }
        }
        return list;
      });

  NavNodeHost copyPushToHost(NavNode targetNode, {String hostName}) =>
      copyHost((_, nodes) => nodes..add(targetNode), hostName: hostName);

  NavNodeHost copyDeepestFrontHost(TransformHost transformHost) {
    final frontHost = getDeepestFrontHost();
    return copyHost(transformHost, hostName: frontHost.name);
  }

  NavNodeHost deepPop() => copyDeepestFrontHost((_, nodes) => nodes..removeLast());

  /*NavNodeHost copyPopUntil({@required pageName, @required bool inclusive}) => copyNodes((name, nodes) {
        final finish = false;
        List<NavNode> nodeTravel(List<NavNode> nodes) {
          final list = <NavNode>[];
          for (final node in nodes.reversed) {
            if(node is NavNodePage){
              if(pageName == pageName){

              }
            } else
          }
          return list;
        }

        return null;
      });*/

  NavNodeHost copyPopHost() => copyDeepestFrontHost((_, nodes) => []);

  NavNodeHost copyPush(NavNode node) => copyNodes((_, nodes) => nodes..add(node));

  bool deepHostLookUp(String hostName) {
    for (final node in nodes) {
      if (node is NavNodeHost && (node.name == hostName || node.deepHostLookUp(hostName))) {
        return true;
      }
    }
    return false;
  }

  NavNodeHost getDeepestFrontHost() {
    if (nodes.last is NavNodePage) return this;
    for (final node in nodes.reversed) {
      if (node is NavNodeHost) {
        return node.getDeepestFrontHost();
      }
    }
    return this;
  }

  bool isEqualsHierarchy(NavNodeHost other) {
    bool result = identical(this, other) ||
        other is NavNodeHost &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            nodes.length == other.nodes.length;
    if (!result) return false;

    for (int index = 0; index < other.nodes.length; index++) {
      final node = nodes[index];
      final otherNode = other.nodes[index];
      if (node is NavNodePage && !node.isEqualsHierarchy(otherNode)) return false;
      if (node is NavNodeHost && !node.isEqualsHierarchy(otherNode)) return false;
    }
    return true;
  }
}
