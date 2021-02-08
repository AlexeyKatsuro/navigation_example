import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:navigation_example/navigation/nav_actions.dart';
import 'package:navigation_example/redux/app_state.dart';

/// This is the stateful widget that the main application instantiates.
class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAfafa),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('to sub Home'),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(NavActions.toSubHomePage());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final snackBar = SnackBar(content: Text('SnackBar'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
