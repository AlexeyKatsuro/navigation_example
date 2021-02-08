import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:navigation_example/navigation/nav_actions.dart';
import 'package:navigation_example/navigation/routes.dart';
import 'package:navigation_example/redux/app_state.dart';
import 'package:navigation_example/redux/navigation_actions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('to Home'),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(NavActions.toHomePage());
          },
        ),
      ),
    );
  }
}
