import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:navigation_example/navigation/nav_actions.dart';
import 'package:navigation_example/redux/app_state.dart';

class SubHomePage extends StatelessWidget {
  const SubHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('to Details'),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(NavActions.toDetails());
          },
        ),
      ),
    );
  }
}
