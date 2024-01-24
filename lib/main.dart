import 'package:flutter/material.dart';

void main() {
  var app = Application();
  runApp(app);
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Hello World !'),
        ),
      ),
    );
  }
}
