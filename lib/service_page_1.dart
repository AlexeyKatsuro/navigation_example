import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:navigation_example/navigation/nav_actions.dart';
import 'package:navigation_example/redux/app_state.dart';

class ServicePage1 extends StatelessWidget {
  const ServicePage1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service 1'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('to Service 2'),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(NavActions.toService2Page());
          },
        ),
      ),
    );
  }
}
