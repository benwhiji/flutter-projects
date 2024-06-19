import 'package:flutter/material.dart';

import 'maina.dart';

void main() {
  runApp(MyAppa());
}

class MyAppa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your button press logic here
            maina();
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
}
