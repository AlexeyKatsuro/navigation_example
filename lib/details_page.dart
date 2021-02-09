import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('to Home'),
          onPressed: () {
            // StoreProvider.of<AppState>(context).dispatch(NavActions.toService2Page());
          },
        ),
      ),
    );
  }
}
