import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:navigation_example/navigation/nav_actions.dart';
import 'package:navigation_example/redux/app_state.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key, this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landing'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('to login'),
          // onPressed: onPressed,
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(NavActions.toLoginPage());
          },
        ),
      ),
    );
  }
}
