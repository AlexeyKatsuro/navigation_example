import 'package:flutter/material.dart';

class ServicePage2 extends StatelessWidget {
  const ServicePage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service 2'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('to Home'),
          onPressed: () {},
        ),
      ),
    );
  }
}
