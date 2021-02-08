import 'package:flutter/material.dart';

class ServiceInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Info'),
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
