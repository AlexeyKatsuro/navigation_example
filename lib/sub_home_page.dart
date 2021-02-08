import 'package:flutter/material.dart';

class SubHomePage extends StatelessWidget {
  const SubHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub home'),
      ),
      body: Center(
        child: Text('Sub home'),
      ),
    );
  }
}
